
import '../queues/priority_queue/priority_queue_implementation.dart';
import 'graph.dart';

// Distance-Vertex Pair
class Pair<T> implements Comparable<Pair<T>> {
  Pair(this.distance, [this.vertex]);
  double distance;
  Vertex<T>? vertex;

  @override
  int compareTo(Pair<T> other) {
    if (distance == other.distance) return 0;
    if (distance > other.distance) return 1;
    return -1;
  }

  @override
  String toString() => '($distance, $vertex)';
}

class Dijkstra<E> {
  Dijkstra(this.graph);
  final Graph<E> graph;

  Map<Vertex<E>, Pair<E>?> shortestPaths(Vertex<E> source) {
    // The queue allows you to visit the shortest route next in each pass
    final queue = PriorityQueue<Pair<E>>(priority: Priority.min);
    // The set visited prevents you from unnecessarily checking vertices that
    // were previously visited.
    final visited = <Vertex<E>>{};
    // The map paths is used to store the distance-previous vertex pair
    // information for every vertex in the graph
    final paths = <Vertex<E>, Pair<E>?>{};
    // Initialize every vertex in the graph with a null distance-vertex pair.
    for (final vertex in graph.vertices) {
      paths[vertex] = null;
    }
    // Initialize the algorithm with the source vertex,
    // This is where the search will start from, so the distance to this vertex
    // is zero. queue holds the current vertex
    queue.enqueue(Pair(0, source));
    // paths stores a reference to the previous vertex, Since the source vertex
    // does not have a previous vertex, using Pair(0) causes the previous vertex
    // to default to null.
    paths[source] = Pair(0);
    visited.add(source);
    // The queue holds the vertices that are known but haven’t been visited yet.
    while (!queue.isEmpty) {
      final current = queue.dequeue()!;
      // Points to the distance of the current vertex saved in the map(paths)
      final savedDistance = paths[current.vertex]!.distance;
      // If the currently explored vertex distance is more than the saved value
      // in paths, ignore and go on
      if (current.distance > savedDistance) continue;
      // Add the current vertex to the visited set so that you can skip over it
      // later since you now know the shortest route to this vertex.
      visited.add(current.vertex!);

      for (final edge in graph.edges(current.vertex!)) {
        final neighbor = edge.destination;
        // If you’ve previously visited the destination vertex, ignore and go on
        if (visited.contains(neighbor)) continue;
        // Find the total distance from the source to the neighboring vertex
        final weight = edge.weight ?? double.infinity;
        final totalDistance = current.distance + weight;
        // Last updated and saved(in paths) distance from the source vertex to
        // neighbor vertex of the current vertex.Newly discovered vertices will
        // get a default distance of infinity
        final knownDistance = paths[neighbor]?.distance ?? double.infinity;
        // Compare the known distance of that vertex with the new total that you
        // just calculated.If you find a shorter route this time around, then
        // update paths and enqueue this vertex for visiting later
        if (totalDistance < knownDistance) {
          paths[neighbor] = Pair(totalDistance, current.vertex);
          queue.enqueue(Pair(totalDistance, neighbor));
        }
      }
    }
    return paths;
  }

  List<Vertex<E>> shortestPath(Vertex<E> source, Vertex<E> destination, {
    Map<Vertex<E>, Pair<E>?>? paths}){
    // You find all of the paths. Providing paths as an argument is an
    // optimization if you need to call shortestPath multiple times on the same
    // graph.
    final allPaths = paths ?? shortestPaths(source);
    // Ensure that a path to a particular destination actually exists
    if (!allPaths.containsKey(destination)) return [];
    var current = destination;
    final path = <Vertex<E>>[current];
    // Build the path by working backwards from the destination
    while (current != source) {
      // previous is the vertex from the distance-previous vertex pair
      final previous = allPaths[current]?.vertex;
      // if null, no path exists.
      if (previous == null) return [];
      path.add(previous);
      current = previous;
    }
    // Since the list is built backwards reverse the list before returning it.
    return path.reversed.toList();
  }
}

/// CHALLENGES
/// FIND ALL THE SHORTEST PATHS
extension ShortestPaths<E> on Dijkstra<E> {
  Map<Vertex<E>, List<Vertex<E>>> shortestPathsLists(Vertex<E> source) {
    // The map stores the path to every vertex from the source vertex
    final allPathsLists = <Vertex<E>, List<Vertex<E>>>{};
    // Perform Dijkstra’s algorithm to find all the paths from the source vertex
    final allPaths = shortestPaths(source);
    // For every vertex in the graph
    for (final vertex in graph.vertices) {
      // Find the shortest path from the source to each vertex(destination)
      final path = shortestPath(source, vertex, paths: allPaths);
      // Generate the list of vertices that makes up the path.
      allPathsLists[vertex] = path;
    }
    return allPathsLists;
  }
}
