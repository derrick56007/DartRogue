library pathfinding.finders.astar;

import 'dart:math';

import 'heap.dart';
import 'grid.dart';
//import 'nodederp.dart';
import 'util.dart';
import 'heuristic.dart';

/**
 * A* path-finder.
 * based upon https://github.com/bgrins/javascript-astar
 * @constructor
 * @param {object} opt
 * @param {boolean} opt.allowDiagonal Whether diagonal movement is allowed.
 * @param {boolean} opt.dontCrossCorners Disallow diagonal movement touching block corners.
 * @param {function} opt.heuristic Heuristic function to estimate the distance
 *     (defaults to manhattan).
 * @param {integer} opt.weight Weight to apply to the heuristic to allow for suboptimal paths,
 *     in order to speed up the search.
 */
class AStarFinder {
  bool allowDiagonal;
  bool dontCrossCorners;
  HeuristicFn heuristic;
  int weight;

  AStarFinder({this.allowDiagonal: true, this.dontCrossCorners: false,
      HeuristicFn heuristic, this.weight: 1}) {
    this.heuristic = heuristic == null ? Heuristic.manhattan : heuristic;
  }

  /**
   * Find and return the the path.
   * @return {Array.<[number, number]>} The path, including both start and
   *     end positions.
   */
  findPath(startX, startY, endX, endY, Grid grid) {
    var openList = new Heap((nodeA, nodeB) {
      return nodeA.f - nodeB.f;
    }),
    startNode = grid.getTileObjectAt(startX, startY),
    endNode = grid.getTileObjectAt(endX, endY),
    heuristic = this.heuristic,
    allowDiagonal = this.allowDiagonal,
    dontCrossCorners = this.dontCrossCorners,
    weight = this.weight,
    node, neighbors, neighbor, i, l, x, y, ng;

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

      // if reached the end position, construct the path and return it
      if (node == endNode) {
        return backtrace(endNode);
      }

      // get neigbours of the current node
      neighbors = grid.getNeighbors(node, allowDiagonal, dontCrossCorners);
      i = 0;
      for (l = neighbors.length; i < l; ++i) {
        neighbor = neighbors[i];

        if (neighbor.closed == true) {
          continue;
        }

        x = neighbor.x;
        y = neighbor.y;

        // get the distance between current node and the neighbor
        // and calculate the next g score
        ng = node.g + ((x - node.x == 0 || y - node.y == 0) ? 1 : SQRT2);

        // check if the neighbor has not been inspected yet, or
        // can be reached with smaller cost from the current node
        if (neighbor.opened != true || ng < neighbor.g) {
          neighbor.g = ng;
          neighbor.h = neighbor.h != null ?
              neighbor.h : weight * heuristic(abs(x - endX), abs(y - endY));
          neighbor.f = neighbor.g + neighbor.h;
          neighbor.parent = node;

          if (neighbor.opened != true) {
            openList.push(neighbor);
            neighbor.opened = true;
          } else {
            // the neighbor can be reached with smaller cost.
            // Since its f value has been updated, we have to
            // update its position in the open list
            openList.updateItem(neighbor);
          }
        }
      } // end for each neighbor
    } // end while not open list empty

    // fail to find the path
    return [];
  }
}
