
import '../binary/binary_implementation.dart';

class BinarySearchTree<E extends Comparable<dynamic>> {
  BinaryNode<E>? root;

  @override
  String toString() => root.toString();

  /// Insertion
  void insert(E value) {
    root = _insertAt(root, value);
  }

  // Private recursive function
  BinaryNode<E> _insertAt(BinaryNode<E>? node, E value) {
    // If the current node is null, that is the insertion point. (Base case)
    if (node == null) {
      return BinaryNode(value);
    }
    // Compares the new node value(this) to the current node value(other)
    // with respect to zero (this < other)
    if (value.compareTo(node.value) < 0) {
      // find an insertion point on the left child
      node.leftChild = _insertAt(node.leftChild, value);
    }
    // find an insertion point on the right child
    else {
      node.rightChild = _insertAt(node.rightChild, value);
    }
    return node;
  }

  /// Lookup
  bool contains(E value) {
    // Set current to root node
    var current = root;
    // While current isn't null, keep branching through the tree
    while (current != null) {
      // If current node's value = value looking for
      if (current.value == value) {
        return true;
      }
      // If the value < current node's value, check left side of the tree
      if (value.compareTo(current.value) < 0) {
        current = current.leftChild;
      }
      // If the value > current node's value, check right side of the tree
      else {
        current = current.rightChild;
      }
    }
    return false;
  }

  /// Removal
  void remove(E value) {
    root = _remove(root, value);
  }

  // Private recursive function
  BinaryNode<E>? _remove(BinaryNode<E>? node, E value) {
    // If the current node is null, return null/empty. (Base case)
    if (node == null) return null;
    if (value == node.value) {
      // If the node is a leaf node, remove and replace it with null
      if (node.leftChild == null && node.rightChild == null) {
        return null;
      }
      // If the node has no left child, return node.rightChild to reconnect to
      // the parent of the removed node
      if (node.leftChild == null) {
        return node.rightChild;
      }
      // If the node has no right child, return node.leftChild to reconnect to
      // the parent of the removed node
      if (node.rightChild == null) {
        return node.leftChild;
      }
      // If the node to be removed has both a left and right child.
      // You replace the node’s value with the smallest value from the right
      // subtree
      node.value = node.rightChild!.min.value;
      // Call remove f(x) on the right child to remove this swapped value
      node.rightChild = _remove(node.rightChild, node.value);
    }

    else if (value.compareTo(node.value) < 0) {
      node.leftChild = _remove(node.leftChild, value);
    }

    else {
      node.rightChild = _remove(node.rightChild, value);
    }
    return node;
  }
}

/// Finding minimum node in a subtree
extension _MinFinder<E> on BinaryNode<E> {
  BinaryNode<E> get min => leftChild?.min ?? this;
}