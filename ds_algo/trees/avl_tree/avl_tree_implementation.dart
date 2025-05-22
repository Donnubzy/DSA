
import 'avl_node_implementation.dart';
import 'dart:math' as math;

class AvlTree<E extends Comparable<dynamic>> {
  AvlNode<E>? root;

  @override
  String toString() => root.toString();

  /// Insertion
  void insert(E value) {
    root = _insertAt(root, value);
  }

  AvlNode<E> _insertAt(AvlNode<E>? node, E value) {
    if (node == null) {
      return AvlNode(value);
    }
    if (value.compareTo(node.value) < 0) {
      node.leftChild = _insertAt(node.leftChild, value);
    }
    else {
      node.rightChild = _insertAt(node.rightChild, value);
    }
    final balancedNode = balanced(node);
    balancedNode.height = 1 + math.max(
        balancedNode.leftHeight, balancedNode.rightHeight);
    return balancedNode;
  }

  AvlNode<E> leftRotate(AvlNode<E> rotatedNode) {
// The right child of the current root node is chosen as the pivot point.
    final pivot = rotatedNode.rightChild!;
// The right child of the node to be rotated(root node) is now set as the pivots
// former left child
    rotatedNode.rightChild = pivot.leftChild;
// The pivot’s new leftChild is now set as the rotated node(root node).
    pivot.leftChild = rotatedNode;
// You update the heights of the rotated node and the pivot.
    rotatedNode.height = 1 + math.max(rotatedNode.leftHeight,
        rotatedNode.rightHeight);
    pivot.height = 1 + math.max(pivot.leftHeight, pivot.rightHeight);
// Finally, return the pivot as the new root node.
    return pivot;
  }

  /// Symmetrical opposite of leftRotate
  AvlNode<E> rightRotate(AvlNode<E> rotatedNode) {
    final pivot = rotatedNode.leftChild!;
    rotatedNode.leftChild = pivot.rightChild;
    pivot.rightChild = rotatedNode;
    rotatedNode.height = 1 + math.max(rotatedNode.leftHeight,
        rotatedNode.rightHeight);
    pivot.height = 1 + math.max(pivot.leftHeight, pivot.rightHeight);
    return pivot;
  }

  AvlNode<E> rightLeftRotate(AvlNode<E> rotatedNode) {
    if (rotatedNode.rightChild == null) {
      return rotatedNode;
    }
    // perform right rotate on a selected node first
    rotatedNode.rightChild = rightRotate(rotatedNode.rightChild!);
    // then perform left rotate on a new selected node
    return leftRotate(rotatedNode);
  }

  /// Symmetrical opposite of rightLeftRotate
  AvlNode<E> leftRightRotate(AvlNode<E> rotatedNode) {
    if (rotatedNode.leftChild == null) {
      return rotatedNode;
    }
    // perform right rotate on a selected node first
    rotatedNode.leftChild = leftRotate(rotatedNode.leftChild!);
    // then perform left rotate on a new selected node
    return rightRotate(rotatedNode);
  }

  AvlNode<E> balanced(AvlNode<E> node) {
    switch (node.balanceFactor) {
      // when left side has more nodes than right side
      case 2:
        final left = node.leftChild;
        if (left != null && left.balanceFactor == -1) {
          return leftRightRotate(node);
        } else {
          return rightRotate(node);
        }
    // when right side has more nodes than left side
      case -2:
        final right = node.rightChild;
        if (right != null && right.balanceFactor == 1) {
          return rightLeftRotate(node);
        } else {
          return leftRotate(node);
        }
    // when node is balanced
      default:
        return node;
    }
  }

  /// Lookup
  bool contains(E value) {
    var current = root;
    while (current != null) {
      if (current.value == value) {
        return true;
      }
      if (value.compareTo(current.value) < 0) {
        current = current.leftChild;
      }
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

  AvlNode<E>? _remove(AvlNode<E>? node, E value) {
    if (node == null) return null;
    if (value == node.value) {
      if (node.leftChild == null && node.rightChild == null) {
        return null;
      }
      if (node.leftChild == null) {
        return node.rightChild;
      }
      if (node.rightChild == null) {
        return node.leftChild;
      }
      node.value = node.rightChild!.min.value;
      node.rightChild = _remove(node.rightChild, node.value);
    }

    else if (value.compareTo(node.value) < 0) {
      node.leftChild = _remove(node.leftChild, value);
    }

    else {
      node.rightChild = _remove(node.rightChild, value);
    }
    final balancedNode = balanced(node);
    balancedNode.height = 1 + math.max(
        balancedNode.leftHeight, balancedNode.rightHeight);
    return balancedNode;
  }
}

/// Finding minimum node in a subtree
extension _MinFinder<E> on AvlNode<E> {
  AvlNode<E> get min => leftChild?.min ?? this;
}