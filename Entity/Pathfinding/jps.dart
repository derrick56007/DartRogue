library pathfinding.finders.jump_point_search;

import 'dart:math';

import 'heap.dart';
import 'grid.dart';
//import 'nodederp.dart';
import 'util.dart';
import 'heuristic.dart';
import '../../World/TileObject/TileObject.dart';

_comparator(TileObject nodeA, TileObject nodeB) {
  return nodeA.f.toDouble() - nodeB.f.toDouble();
}


/**
 * Path finder using the Jump Point Search algorithm
 * @param {object} opt
 * @param {function} opt.heuristic Heuristic function to estimate the distance
 *     (defaults to manhattan).
 */
class JumpPointFinder {
  Grid grid;
  Heap openList;
  TileObject startNode;
  TileObject endNode;
  HeuristicFn heuristic;

  JumpPointFinder([this.heuristic]) {
    if (heuristic == null) {
      heuristic = Heuristic.manhattan;
    }
  }

  /**
   * Find and return the path.
   * @return {Array.<[number, number]>} The path, including both start and
   *     end positions.
   */
  List findPath(int startX, int startY, int endX, int endY, Grid grid) {
    var openList = this.openList = new Heap(_comparator);
    var startNode = this.startNode = grid.getTileObjectAt(startX, startY),
        endNode = this.endNode = grid.getTileObjectAt(endX, endY), node;

    this.grid = grid;


    // set the `g` and `f` value of the start node to be 0
    startNode.g = 0;
    startNode.f = 0;

    // push the start node into the open list
    openList.push(startNode);
    startNode.opened = true;

    // while the open list is not empty
    while (!openList.empty()) {
        // pop the position of node which has the minimum `f` value.
        node = openList.pop();
        node.closed = true;

        if (node == endNode) {
            return backtrace(endNode);
        }

        this._identifySuccessors(node);
    }

    // fail to find the path
    return [];
  }

  /**
   * Identify successors for the given node. Runs a jump point search in the
   * direction of each available neighbor, adding any points found to the open
   * list.
   * @protected
   */
  _identifySuccessors(node) {
    var grid = this.grid,
        heuristic = this.heuristic,
        openList = this.openList,
        endX = this.endNode.x,
        endY = this.endNode.y,
        neighbors, neighbor,
        jumpPoint, i, l,
        x = node.x, y = node.y,
        jx, jy, dx, dy, d, ng, jumpNode;

    neighbors = this._findNeighbors(node);
    i = 0;
    for (l = neighbors.length; i < l; ++i) {
      neighbor = neighbors[i];
      jumpPoint = this._jump(neighbor[0], neighbor[1], x, y);
      if (jumpPoint != null) {

        jx = jumpPoint[0];
        jy = jumpPoint[1];
        jumpNode = grid.getTileObjectAt(jx, jy);

        if (jumpNode.closed == true) {
          continue;
        }

        // include distance, as parent may not be immediately adjacent:
        d = Heuristic.euclidean(abs(jx - x), abs(jy - y));
        ng = node.g + d; // next `g` value

        if (jumpNode.opened != true || ng < jumpNode.g) {
          jumpNode.g = ng;
          if (jumpNode.h != null && jumpNode.h != 0) {
            jumpNode.h = jumpNode.h;
          } else {
            jumpNode.h = heuristic(abs(jx - endX), abs(jy - endY));
          }
          jumpNode.f = jumpNode.g + jumpNode.h;
          jumpNode.parent = node;

          if (jumpNode.opened != true) {
              openList.push(jumpNode);
              jumpNode.opened = true;
          } else {
              openList.updateItem(jumpNode);
          }
        }
      }
    }
  }

  /**
   Search recursively in the direction (parent -> child), stopping only when a
   * jump point is found.
   * @protected
   * @return {Array.<[number, number]>} The x, y coordinate of the jump point
   *     found, or null if not found
   */
  _jump(x, y, px, py) {
    var grid = this.grid,
        dx = x - px, dy = y - py, jx, jy;

    if (!grid.isWalkableAt(x, y)) {
        return null;
    }
    else if (grid.getTileObjectAt(x, y) == this.endNode) {
        return [x, y];
    }

    // check for forced neighbors
    // along the diagonal
    if (dx != 0 && dy != 0) {
        if ((grid.isWalkableAt(x - dx, y + dy) && !grid.isWalkableAt(x - dx, y)) ||
            (grid.isWalkableAt(x + dx, y - dy) && !grid.isWalkableAt(x, y - dy))) {
            return [x, y];
        }
    }
    // horizontally/vertically
    else {
        if( dx != 0 ) { // moving along x
            if((grid.isWalkableAt(x + dx, y + 1) && !grid.isWalkableAt(x, y + 1)) ||
               (grid.isWalkableAt(x + dx, y - 1) && !grid.isWalkableAt(x, y - 1))) {
                return [x, y];
            }
        }
        else {
            if((grid.isWalkableAt(x + 1, y + dy) && !grid.isWalkableAt(x + 1, y)) ||
               (grid.isWalkableAt(x - 1, y + dy) && !grid.isWalkableAt(x - 1, y))) {
                return [x, y];
            }
        }
    }

    // when moving diagonally, must check for vertical/horizontal jump points
    if (dx != 0 && dy != 0) {
        jx = this._jump(x + dx, y, x, y);
        jy = this._jump(x, y + dy, x, y);
        if (jx != null || jy != null) {
            return [x, y];
        }
    }

    // moving diagonally, must make sure one of the vertical/horizontal
    // neighbors is open to allow the path
    if (grid.isWalkableAt(x + dx, y) || grid.isWalkableAt(x, y + dy)) {
        return this._jump(x + dx, y + dy, x, y);
    } else {
        return null;
    }
  }

  /**
   * Find the neighbors for the given node. If the node has a parent,
   * prune the neighbors based on the jump point search algorithm, otherwise
   * return all available neighbors.
   * @return {Array.<[number, number]>} The neighbors found.
   */
  _findNeighbors(node) {
    TileObject parent = node.parent;
    Grid grid = this.grid;
    var neighbors = [], neighborNodes, neighborNode, i, l;
    int x = node.x, y = node.y, dx, dy, px, py, nx, ny;

    // directed pruning: can ignore most neighbors, unless forced.
    if (parent != null) {
        px = parent.x;
        py = parent.y;
        // get the normalized direction of travel
        dx = ((x - px) / max(abs(x - px), 1)).floor();
        dy = ((y - py) / max(abs(y - py), 1)).floor();

        // search diagonally
        if (dx != 0 && dy != 0) {
            if (grid.isWalkableAt(x, y + dy)) {
                neighbors.add([x, y + dy]);
            }
            if (grid.isWalkableAt(x + dx, y)) {
                neighbors.add([x + dx, y]);
            }
            if (grid.isWalkableAt(x, y + dy) || grid.isWalkableAt(x + dx, y)) {
                neighbors.add([x + dx, y + dy]);
            }
            if (!grid.isWalkableAt(x - dx, y) && grid.isWalkableAt(x, y + dy)) {
                neighbors.add([x - dx, y + dy]);
            }
            if (!grid.isWalkableAt(x, y - dy) && grid.isWalkableAt(x + dx, y)) {
                neighbors.add([x + dx, y - dy]);
            }
        }
        // search horizontally/vertically
        else {
            if(dx == 0) {
                if (grid.isWalkableAt(x, y + dy)) {
                    if (grid.isWalkableAt(x, y + dy)) {
                        neighbors.add([x, y + dy]);
                    }
                    if (!grid.isWalkableAt(x + 1, y)) {
                        neighbors.add([x + 1, y + dy]);
                    }
                    if (!grid.isWalkableAt(x - 1, y)) {
                        neighbors.add([x - 1, y + dy]);
                    }
                }
            }
            else {
                if (grid.isWalkableAt(x + dx, y)) {
                    if (grid.isWalkableAt(x + dx, y)) {
                        neighbors.add([x + dx, y]);
                    }
                    if (!grid.isWalkableAt(x, y + 1)) {
                        neighbors.add([x + dx, y + 1]);
                    }
                    if (!grid.isWalkableAt(x, y - 1)) {
                        neighbors.add([x + dx, y - 1]);
                    }
                }
            }
        }
    }
    // return all neighbors
    else {
        neighborNodes = grid.getNeighbors(node, true);
        i = 0;
        for (l = neighborNodes.length; i < l; ++i) {
            neighborNode = neighborNodes[i];
            neighbors.add([neighborNode.x, neighborNode.y]);
        }
    }

    return neighbors;
  }
}