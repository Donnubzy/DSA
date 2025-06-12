
/// DEFINING THE GRAPH STRUCTURE
class Vertex<T> {
  const Vertex({required this.index, required this.data});
  final int index;
  final T data;

  @override
  String toString() => data.toString();
}

class Edge<T> {
  const Edge(this.source, this.destination, [this.weight]);
  final Vertex<T> source;
  final Vertex<T> destination;
  final double? weight;

}

// To specify if the graph to be constructed is directed/undirected.
enum EdgeType { directed, undirected }
// Interface to implement type of graph to be constructed
abstract class Graph<E> {
  // Returns all of the vertices in the graph.
  Iterable<Vertex<E>> get vertices;
  // Creates a vertex and adds it to the graph.
  Vertex<E> createVertex(E data);
  // Connects two vertices in the graph with either a directed or undirected
  // edge. The weight is optional.
  void addEdge(Vertex<E> source, Vertex<E> destination,
      {EdgeType edgeType, double? weight });
  // Returns a list of outgoing edges from a specific vertex.
  List<Edge<E>> edges(Vertex<E> source);
  // Returns the weight of the edge between two vertices.
  double? weight(Vertex<E> source, Vertex<E> destination);
}

/// IMPLEMENTATIONS
/// A] USING ADJACENCY LISTS
class AdjacencyList<E> implements Graph<E> {
  // Map to store the outgoing edges for each vertex
  final Map<Vertex<E>, List<Edge<E>>> _connections = {};
  // var to assign a unique index to each new vertex
  var _nextIndex = 0;

  @override
  Iterable<Vertex<E>> get vertices => _connections.keys;

  @override
  Vertex<E> createVertex(E data) {
    // Create a new vertex with a unique index.
    final vertex = Vertex( index: _nextIndex, data: data );
    _nextIndex++;
    // Add the vertex as a key in the _connections map. You haven’t connected
    // it to any other vertices in the graph yet, so the list of outgoing edges
    // is empty.
    _connections[vertex] = [];
    return vertex;
  }

  @override
  void addEdge( Vertex<E> source, Vertex<E> destination,
      { EdgeType edgeType = EdgeType.undirected, double? weight } ) {
    // Since source is a vertex, check if it exists in the _connections map
    // If it does, create a new directed edge from the source to the destination
    // Then add it to the vertex’s list of edges.
    _connections[source]?.add(
      Edge(source, destination, weight),
    );
    // If this is an undirected graph, then also add an edge going the other
    // direction
    if (edgeType == EdgeType.undirected) {
      _connections[destination]?.add(
        Edge(destination, source, weight),
      );
    }
  }

  // Gets the stored outgoing edges for the provided vertex. If source is
  // unknown,the method returns an empty list.
  @override
  List<Edge<E>> edges(Vertex<E> source) {
    return _connections[source] ?? [];
  }

  // Here, you search for an edge from source to destination. If it exists,
  // you return its weight.
  @override
  double? weight( Vertex<E> source, Vertex<E> destination ) {
    final match = edges(source).where((edge) {
      return edge.destination == destination;
    });
    if (match.isEmpty) return null;
    return match.first.weight;
  }

  // Printing in terminal
  String toString() {
    final result = StringBuffer();
    // Loop through every key-value pair in _connections.
    _connections.forEach((vertex, edges) {
      // For every vertex, find all of the destinations and join them into a
      // single comma-separated string.
      final destinations = edges.map((edge) {
        return edge.destination;
      }).join(', ');
      // Put each vertex and its destinations on a new line.
      result.writeln('$vertex --> $destinations');
    });
    return result.toString();
  }
}

/// B] USING ADJACENCY MATRIX
class AdjacencyMatrix<E> implements Graph<E> {
  // store the vertices in a list
  final List<Vertex<E>> _vertices = [];
  // store the edges in a 2-D list => [ [],[],[] ]
  final List<List<double?>?> _weights = [];
  var _nextIndex = 0;

  @override
  Iterable<Vertex<E>> get vertices => _vertices;

  @override
  Vertex<E> createVertex(E data) {
    // Create and add a new vertex to the list(_vertices)
    final vertex = Vertex( index: _nextIndex, data: data );
    _nextIndex++;
    _vertices.add(vertex);
    // Append a null value at the end of every row. This in effect creates a new
    // destination column for each row in the matrix
    for (var i = 0; i < _weights.length; i++) {
      _weights[i]?.add(null);
    }
    // Add a new row to the matrix, again filled with null weight values.
    final row = List<double?>.filled(_vertices.length, null, growable: true);
    _weights.add(row);
    return vertex;
  }

  @override
  void addEdge(Vertex<E> source, Vertex<E> destination,
      {EdgeType edgeType = EdgeType.undirected, double? weight}) {
    // Add a directed edge where source is the row and destination is the column
    _weights[source.index]?[destination.index] = weight;
    // If the edge type for the graph is undirected, then also add another edge
    // going from the destination to the source.
    if (edgeType == EdgeType.undirected) {
      _weights[destination.index]?[source.index] = weight;
    }
  }

  @override
  List<Edge<E>> edges(Vertex<E> source) {
    List<Edge<E>> edges = [];
    // To find all the edges for some source, you loop through all the values
    // in a row
    for (var column = 0; column < _weights.length; column++) {
      final weight = _weights[source.index]?[column];
      // if weight is null, skip and move to next weight value in the row
      if (weight == null) continue;
      // Use the column to look up the destination vertex.
      final destination = _vertices[column];
      // Add all weight values to the empty list (edges)
      edges.add(Edge(source, destination, weight));
    }
    return edges;
  }

  @override
  double? weight(Vertex<E> source, Vertex<E> destination) {
    return _weights[source.index]?[destination.index];
  }

  @override
  String toString() {
    final output = StringBuffer();
    // You first create a list of the vertices
    for (final vertex in _vertices) {
      output.writeln('${vertex.index}: ${vertex.data}');
    }
    // Then you build up a grid of weights, row by row
    for (int i = 0; i < _weights.length; i++) {
      for (int j = 0; j < _weights.length; j++) {
        final value = (_weights[i]?[j] ?? '0.0').toString();
        output.write(value.padRight(10));
      }
      output.writeln();
    }
    return output.toString();
  }
}

/// CHALLENGES
/// GRAPH YOUR FRIENDS
// mutual friend for Pablo and Megan is Manda

// Solving it programmatically
// in main()
// final megansFriends =
// Set.of(graph.edges(megan).map((edge) => edge.destination.data));
// final pablosFriends =
// Set.of(graph.edges(pablo).map((edge) => edge.destination.data));
// final mutualFriends = megansFriends.intersection(pablosFriends);
// print(mutualFriends);
//