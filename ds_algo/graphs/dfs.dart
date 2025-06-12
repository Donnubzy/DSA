
import '../stacks/stack_implementation.dart';
import 'graph.dart';

extension DepthFirstSearch<E> on Graph<E> {
  List<Vertex<E>> depthFirstSearch(Vertex<E> source) {
    // Stack is used to store your path through the graph
    final stack = Stack<Vertex<E>>();
    // Remembers which vertices have been pushed before
    final pushed = <Vertex<E>>{};
    // List that stores the order in which the vertices were visited
    final visited = <Vertex<E>>[];

    stack.push(source);
    pushed.add(source);
    visited.add(source);

    // Name the loop 'outerLoop' so that you have a way to continue to the
    // next vertex, even from within a nested for loop.
    outerLoop:
    // Continue to check the top of the stack for a vertex until the stack is
    // empty
    while (stack.isNotEmpty) {
      final vertex = stack.peek;
      // Find all the neighboring edges for the current vertex
      final neighbors = edges(vertex);
      // Here, you loop through every edge connected to the current vertex and
      // check if the neighboring vertex has been seen.
      for (final edge in neighbors) {
        // If not, push it onto the stack then add it to the set(pushed) and
        // list(visited).
        if (!pushed.contains(edge.destination)) {
          stack.push(edge.destination);
          pushed.add(edge.destination);
          visited.add(edge.destination);
          // Once a neighbor to visit is found, you continue to outerLoop and
          // peek at the newly pushed neighbor
          continue outerLoop;
        }
      }
      // If the current vertex did not have any unvisited neighbors, you’ve
      // reached a dead end, pop it off the stack
      stack.pop();
    }
    return visited;
  }
}

extension CyclicGraph<E> on Graph<E> {
  // helper method
  bool _hasCycle(Vertex<E> source, Set<Vertex<E>> pushed) {
    // Initialize the algorithm by adding the source vertex.
    pushed.add(source);
    // Visit every neighboring edge.
    final neighbors = edges(source);
    for (final edge in neighbors) {
      // Checks if the adjacent vertex has not been visited before
      if (!pushed.contains(edge.destination)) {
        // Recursively dive deeper down a branch to check for a cycle.
        if (_hasCycle(edge.destination, pushed)) {
          return true;
        }
      }
      // If the adjacent vertex has been visited before, you’ve found a cycle.
      else {
        return true;
      }
    }
    // Remove the source vertex so you can continue to find other paths with a
    // potential cycle.
    pushed.remove(source);
    // If you’ve reached this far, then no cycle was found.
    return false;
  }

  // main call method
  bool hasCycle(Vertex<E> source) {
    Set<Vertex<E>> pushed = {};
    return _hasCycle(source, pushed);
  }
}

/// CHALLENGE
/// RECURSIVE DFS
extension RecursiveDfs<E> on Graph<E>{
  // helper method
  void _dfs(Vertex<E> source, List<Vertex<E>> visited, Set<Vertex<E>> pushed){
    // Mark the source vertex as visited.
    pushed.add(source);
    visited.add(source);
    // Visit every neighboring edge.
    final neighbors = edges(source);
    for (final edge in neighbors) {
      // As long as the adjacent vertex has not been visited yet, continue to
      // dive deeper down the branch recursively.
      if (!pushed.contains(edge.destination)) {
        _dfs(edge.destination, visited, pushed);
      }
    }
  }

  // main call method
  List<Vertex<E>> dfs(Vertex<E> start) {
    List<Vertex<E>> visited = [];
    Set<Vertex<E>> pushed = {};
    // call helper method
    _dfs(start, visited, pushed);
    return visited;
  }
}