library pathfinding.core.heap;

// From https://github.com/qiao/heap.js

import 'dart:math';

typedef int Comparator(a, b);

int defaultCmp(x, y) {
  if (x < y) {
    return -1;
  }
  if (x > y) {
    return 1;
  }
  return 0;
}

/**
 * Insert item x in list a, and keep it sorted assuming a is sorted.
 * If x is already in a, insert it to the right of the rightmost x.
 * Optional args lo (default 0) and hi (default a.length) bound the slice
 * of a to be searched.
 */
_insort(List a, x, int lo, int hi, Comparator cmp) {
  var mid;
  if (lo == null) {
    lo = 0;
  }
  if (cmp == null) {
    cmp = defaultCmp;
  }
  if (lo < 0) {
    throw new Exception('lo must be non-negative');
  }
  if (hi == null) {
    hi = a.length;
  }
  while (cmp(lo, hi) < 0) {
    mid = ((lo + hi) / 2).floor();
    if (cmp(x, a[mid]) < 0) {
      hi = mid;
    } else {
      lo = mid + 1;
    }
  }
  a.insert(lo, x);
}

/**
 * Push item onto heap, maintaining the heap invariant.
 */
_heappush(List array, item, cmp) {
  if (cmp == null) {
    cmp = defaultCmp;
  }
  array.add(item);
  return _siftdown(array, 0, array.length - 1, cmp);
}

/**
 * Pop the smallest item off the heap, maintaining the heap invariant.
 */
_heappop(array, cmp) {
  var lastelt, returnitem;
  if (cmp == null) {
    cmp = defaultCmp;
  }
  lastelt = array.removeLast();
  if (array.length > 0) {
    returnitem = array[0];
    array[0] = lastelt;
    _siftup(array, 0, cmp);
  } else {
    returnitem = lastelt;
  }
  return returnitem;
}

/**
 * Pop and return the current smallest value, and add the new item.
 *
 * This is more efficient than heappop() followed by heappush(), and can be
 * more appropriate when using a fixed size heap. Note that the value
 * returned may be larger than item! That constrains reasonable use of
 * this routine unless written as part of a conditional replacement:
 *   if item > array[0]
 *     item = heapreplace(array, item)
 */
_heapreplace(array, item, cmp) {
  var returnitem;
  if (cmp == null) {
    cmp = defaultCmp;
  }
  returnitem = array[0];
  array[0] = item;
  _siftup(array, 0, cmp);
  return returnitem;
}

/**
 * Fast version of a heappush followed by a heappop.
 */
_heappushpop(array, item, cmp) {
  var _ref;
  if (cmp == null) {
    cmp = defaultCmp;
  }
  if (array.length && cmp(array[0], item) < 0) {
    _ref = [array[0], item];
    item = _ref[0];
    array[0] = _ref[1];
    _siftup(array, 0, cmp);
  }
  return item;
}

/**
 * Transform list into a heap, in-place, in O(array.length) time.
 */
_heapify(array, cmp) {
  var i, _i, _j, _len, _ref, _ref1, _results, _results1;
  if (cmp == null) {
    cmp = defaultCmp;
  }
  _results1 = [];
  for (var _j = 0, _ref = (array.length / 2).floor();
      0 <= _ref ? _j < _ref : _j > _ref; 0 <= _ref ? _j++ : _j--){
    _results1.push(_j);
  }
  _ref1 = _results1.reverse();
  _results = [];
  _i = 0;
  for (_len = _ref1.length; _i < _len; _i++) {
    i = _ref1[_i];
    _results.push(_siftup(array, i, cmp));
  }
  return _results;
}

/**
 * Update the position of the given item in the heap.
 * This function should be called every time the item is being modified.
 */
_updateItem(array, item, cmp) {
  var pos;
  if (cmp == null) {
    cmp = defaultCmp;
  }
  pos = array.indexOf(item);
  _siftdown(array, 0, pos, cmp);
  return _siftup(array, pos, cmp);
}

/**
 * Find the n largest elements in a dataset.
 */
_nlargest(array, n, cmp) {
  var elem, result, _i, _len, _ref;
  if (cmp == null) {
    cmp = defaultCmp;
  }
  result = array.slice(0, n);
  if (!result.length) {
    return result;
  }
  _heapify(result, cmp);
  _ref = array.slice(n);
  _i = 0;
  for (_len = _ref.length; _i < _len; _i++) {
    elem = _ref[_i];
    _heappushpop(result, elem, cmp);
  }
  return result.sort(cmp).reverse();
}

/**
 * Find the n smallest elements in a dataset.
 */
_nsmallest(array, n, cmp) {
  var elem, i, los, result, _i, _j, _len, _ref, _ref1, _results;
  if (cmp == null) {
    cmp = defaultCmp;
  }
  if (n * 10 <= array.length) {
    result = array.slice(0, n).sort(cmp);
    if (!result.length) {
      return result;
    }
    los = result[result.length - 1];
    _ref = array.slice(n);
    _i = 0;
    for (_len = _ref.length; _i < _len; _i++) {
      elem = _ref[_i];
      if (cmp(elem, los) < 0) {
        _insort(result, elem, 0, null, cmp);
        result.removeLast();
        los = result[result.length - 1];
      }
    }
    return result;
  }
  _heapify(array, cmp);
  _results = [];
  i = _j = 0;
  for (_ref1 = min(n, array.length); 0 <= _ref1 ? _j < _ref1 : _j > _ref1; i = 0 <= _ref1 ? ++_j : --_j) {
    _results.push(_heappop(array, cmp));
  }
  return _results;
}

_siftdown(array, startpos, pos, cmp) {
  var newitem, parent, parentpos;
  if (cmp == null) {
    cmp = defaultCmp;
  }
  newitem = array[pos];
  while (pos > startpos) {
    parentpos = (pos - 1) >> 1;
    parent = array[parentpos];
    if (cmp(newitem, parent) < 0) {
      array[pos] = parent;
      pos = parentpos;
      continue;
    }
    break;
  }
  return array[pos] = newitem;
}

_siftup(array, pos, cmp) {
  var childpos, endpos, newitem, rightpos, startpos;
  if (cmp == null) {
    cmp = defaultCmp;
  }
  endpos = array.length;
  startpos = pos;
  newitem = array[pos];
  childpos = 2 * pos + 1;
  while (childpos < endpos) {
    rightpos = childpos + 1;
    if (rightpos < endpos && !(cmp(array[childpos], array[rightpos]) < 0)) {
      childpos = rightpos;
    }
    array[pos] = array[childpos];
    pos = childpos;
    childpos = 2 * pos + 1;
  }
  array[pos] = newitem;
  return _siftdown(array, startpos, pos, cmp);
}

class Heap {
  Comparator cmp;
  List nodes;

  Heap([cmp]) {
    this.cmp = cmp != null ? cmp : defaultCmp;
    this.nodes = [];
  }

  push(x) {
    return _heappush(this.nodes, x, this.cmp);
  }

  insert(x) {
    return push(x);
  }

  pop() {
    return _heappop(this.nodes, this.cmp);
  }

  remove() => pop();

  peek() {
    return this.nodes[0];
  }

  top() => peek();
  front() => peek();

  contains(x) {
    return this.nodes.indexOf(x) != -1;
  }

  has(x) => contains(x);

  replace(x) {
    return _heapreplace(this.nodes, x, this.cmp);
  }

  pushpop(x) {
    return _heappushpop(this.nodes, x, this.cmp);
  }

  heapify() {
    return _heapify(this.nodes, this.cmp);
  }

  updateItem(x) {
    return _updateItem(this.nodes, x, this.cmp);
  }

  clear() {
    return this.nodes = [];
  }

  empty() {
    return this.nodes.length == 0;
  }

  size() {
    return this.nodes.length;
  }

  clone() {
    var heap;
    heap = new Heap(this.cmp);
    heap.nodes = new List.from(this.nodes);
    return heap;
  }

  copy() => clone();

  toArray() {
    return new List.from(this.nodes);
  }
}
