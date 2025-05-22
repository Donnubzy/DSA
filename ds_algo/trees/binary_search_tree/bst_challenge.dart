
import '../binary/binary_implementation.dart';
import 'bst_implementation.dart';

extension Checker<E extends Comparable<dynamic>> on BinaryNode<E> {

  /// 1. Binary Tree or Binary Search Tree?
  bool isBinarySearchTree() {
    //this: current node in tree, min/max : min/max values of nodes in the tree
    return _isBST(this, min: null, max: null);
  }

  bool _isBST(BinaryNode<E>? tree, {E? min, E? max}) {
    /// BASE CASE
    // No more nodes to inspect and all conditions are met, it is a BST.
    if (tree == null) return true;

    /// BOUNDS CASE
    //  If the current value exceeds the bounds of min and max, the current node
    //  violates BST rules, return false.
    if (min != null && tree.value.compareTo(min) < 0) {
      return false;
    }
    else if (max != null && tree.value.compareTo(max) >= 0) {
      return false;
    }

    /// RECURSIVE CASE
    // When traversing through the left children, the current value is set as
    // the max value. Any node on the left side must be < the parent.
    return _isBST(tree.leftChild, min: min, max: tree.value) &&
        // When traversing through the right children, the current value is set
        // as the min value. Any node on the right side must be >= the parent.
        _isBST(tree.rightChild, min: tree.value, max: max);
  }
}

/// 2. Equality between two Binary Search Trees
bool treesEqual(BinarySearchTree first, BinarySearchTree second) {
  return _isEqual(first.root, second.root);
}
// Recursive function to compare two BSTs
bool _isEqual(BinaryNode? first, BinaryNode? second) {
  // Base case
  // if either of them has a null, then both BSTs aren't equal
  if (first == null || second == null) {
    return first == null && second == null;
  }
  // Check the value of the first and second nodes for equality
  return first.value == second.value &&
      // Recursively check the left and right children for equality
      _isEqual(first.leftChild, second.leftChild) &&
      _isEqual(first.rightChild, second.rightChild);
}

/// 3. Is it a Subtree?
extension Subtree<E> on BinarySearchTree {
  bool containsSubtree(BinarySearchTree subtree) {
    // Create an empty set
    Set set = <E>{};
    // Traverse through the tree and add all the values in the tree to the set
    root?.traverseInOrder((value) {
      set.add(value);
    });
    // To check if the values in subtree are in the root tree.
    var isEqual = true;
    // Traverse through the subtree and compare values with the root tree
    subtree.root?.traverseInOrder((value) {
      // If false at any point, return false as isEqual.
      isEqual = isEqual && set.contains(value);
    });
    return isEqual;
  }
}
