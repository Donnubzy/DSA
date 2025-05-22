
/// Create the TrieNode
class TrieNode<T> {
  TrieNode({this.key, this.parent});
  // key holds the data for the node. This is nullable because the root node of
  // the trie has no key. The reason it’s called a key is because you use it in
  // a map of key-value pairs to store children nodes.
  T? key;
  // TrieNode holds a reference to its parent.
  TrieNode<T>? parent;
  // In a trie, a node needs to hold multiple different elements. The children
  // map accomplishes that.
  Map<T, TrieNode<T>?> children = {};
  // Acts as a marker for the end of a collection.
  bool isTerminating = false;
}

/// Create the Trie itself (String-based trie)
class StringTrie {
  TrieNode<int> root = TrieNode(key: null, parent: null);

  /// Insert
  void insert(String text) {
    // tracks the traversal through the collection
    var current = root;
    // The trie stores each code unit in a separate node.You first check if the
    // node exists in the children map. If it does not, you create a new node.
    for (var codeUnit in text.codeUnits) {
      current.children[codeUnit] ??= TrieNode(
        key: codeUnit,
        parent: current,
      );
      // During each loop, you move current to the next node.
      current = current.children[codeUnit]!;
    }
    // After the for loop completes, current is referencing the node at the end
    // of the collection, that is,You mark that node as the terminating node.
    current.isTerminating = true;
  }

  /// Contains
  bool contains(String text) {
    var current = root;
    // Iterate through the collection in search of a string
    for (var codeUnit in text.codeUnits) {
      final child = current.children[codeUnit];
      // if no item is passed to the collection.
      if (child == null) {
        return false;
      }
      // moving to the next node, true if the last node is a terminating node in
      // the collection.
      current = child;
    }
    // false is returned if the items pushed in is just a subset of a larger
    // collection or it's not in the collection
    return current.isTerminating;
  }

  /// Remove
  void remove(String text) {
    var current = root;
    // Iterate through the collection to see if the string to be removed exists
    // if no, return null.
    for (final codeUnit in text.codeUnits) {
      final child = current.children[codeUnit];
      if (child == null) {
        return;
      }
      // Iterate till current is the last node
      current = child;
    }
    // if the last node is not marked as terminating
    if (!current.isTerminating) {
      return;
    }
    // set to false so the current node can be removed by the loop below
    current.isTerminating = false;
    //
    while (
    // current node has a parent.
    current.parent != null &&
        // current node does not have children,it means other collections don’t
        // depend on the current node
        current.children.isEmpty &&
        // check if the current node is terminating. If it is, then it belongs to
        // another collection.
        !current.isTerminating) {
      // remove the current node (by the key)
      current.parent!.children[current.key!] = null;
      // Backtrack current to the parent of the current node and repeat loop till
      // all nodes have been removed i.e reached the root.
      current = current.parent!;
    }
  }

  /// Prefix Matching
  List<String> matchPrefix(String prefix) {
    var current = root;
    // verify the trie contains the prefix, if not, return an empty list
    for (final codeUnit in prefix.codeUnits) {
      final child = current.children[codeUnit];
      if (child == null) {
        return [];
      }
      // Iterate till the last node in the prefix
      current = child;
    }
    // return a recursive helper method to find all the sequences after the
    // current node.
    return _moreMatches(prefix, current);
  }

  List<String> _moreMatches(String prefix, TrieNode<int> node) {
    // Empty list to hold the results
    List<String> results = [];
    // if the current node is a terminating one add to the list(results)
    if (node.isTerminating) {
      results.add(prefix);
    }
    // check the current node’s children.
    for (final child in node.children.values) {
      final codeUnit = child!.key!;
      // For every child node, recursively call '_moreMatches' to seek out other
      // terminating nodes.
      results.addAll(
        _moreMatches(
          '$prefix${String.fromCharCode(codeUnit)}',
          child,
        ),
      );
    }
    return results;
  }

}