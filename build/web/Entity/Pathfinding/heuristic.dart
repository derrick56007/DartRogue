library pathfinding.core.heuristic;

import 'dart:math';

typedef HeuristicFn(dx, dy);

class Heuristic {
  /**
   * Manhattan distance.
   * @param {number} dx - Difference in x.
   * @param {number} dy - Difference in y.
   * @return {number} dx + dy
   */
  static manhattan(dx, dy) {
      return dx + dy;
  }

  /**
   * Euclidean distance.
   * @param {number} dx - Difference in x.
   * @param {number} dy - Difference in y.
   * @return {number} sqrt(dx * dx + dy * dy)
   */
  static euclidean(dx, dy) {
      return sqrt(dx * dx + dy * dy);
  }

  /**
   * Chebyshev distance.
   * @param {number} dx - Difference in x.
   * @param {number} dy - Difference in y.
   * @return {number} max(dx, dy)
   */
  static chebyshev(dx, dy) {
      return max(dx, dy);
  }
}