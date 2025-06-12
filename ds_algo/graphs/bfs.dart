
import '../queues/queue_implementation.dart';
import 'graph.dart';

extension BreadthFirstSearch<E> on Graph<E> {
  List<Vertex<E>> breadthFirstSearch(Vertex<E> source) {
    // Keeps track of the neighboring vertices to visit next.
    final queue = QueueStack<Vertex<E>>();
    // Remembers which vertices have been enqueued before.
    Set<Vertex<E>> enqueued = {};
    // Stores the order in which the vertices were explored.
    List<Vertex<E>> visited = [];
    // Initialize the BFS algorithm by first enqueuing the source vertex.
    queue.enqueue(source);
    // Add the source vertex to the set
    enqueued.add(source);
    while (true) {
      // Continue to dequeue a vertex from the queue until the queue is empty.
      final vertex = queue.dequeue();
      if (vertex == null) break;
      // Every time you dequeue a vertex from the queue, you add it to the list
      // of visited vertices.
      visited.add(vertex);
      // Find all edges that start from the current vertex and iterate over them
      final neighborEdges = edges(vertex);
      for (final edge in neighborEdges) {
        // For each edge, check to see if its destination vertex has been
        // enqueued before, and if not, you add it to the queue and set.
        if (!enqueued.contains(edge.destination)) {
          queue.enqueue(edge.destination);
          enqueued.add(edge.destination);
        }
      }
    }
    return visited;
  }
}

/// CHALLENGES
/// 1] MAXIMUM QUEUE SIZE
// You can observe this by adding print statements after every enqueue and
// dequeue in breadthFirstSearch.

/// 2] ITERATIVE BFS
extension RecursiveBfs<E> on Graph<E> {
  // helper method
  void _bfs( QueueStack<Vertex<E>> queue, Set<Vertex<E>> enqueued,
      List<Vertex<E>> visited ) {
    final vertex = queue.dequeue();
    // Base case
    if (vertex == null) return;
    visited.add(vertex);
    final neighborEdges = edges(vertex);
    for (final edge in neighborEdges) {
      if (!enqueued.contains(edge.destination)) {
        queue.enqueue(edge.destination);
        enqueued.add(edge.destination);
      }
    }
    // Recursive case
    _bfs(queue, enqueued, visited);
  }

  // main call method
  List<Vertex<E>> bfs(Vertex<E> source) {
    final queue = QueueStack<Vertex<E>>();
    final Set<Vertex<E>> enqueued = {};
    List<Vertex<E>> visited = [];

    queue.enqueue(source);
    enqueued.add(source);
    // Call helper method
    _bfs(queue, enqueued, visited);
    return visited;
  }
}

/// 3] DISCONNECTED GRAPH
extension Connected<E> on Graph<E> {
  bool isConnected() {
    // If there are no vertices, treat the graph as connected
    if (vertices.isEmpty) return true;
    // Perform a breadth-first search starting from the first vertex.
    final visited = breadthFirstSearch(vertices.first);
    // Go through every vertex in the graph and check if it has been visited
    // before
    for (final vertex in vertices) {
      // If a vertex is in the vertices but not found while traversing the
      // graph using bfs, its disconnected
      if (!visited.contains(vertex)) {
        return false;
      }
    }
    return true;
  }
}