
import 'dart:math';
import 'binary_implementation.dart';

/// 1. Height of a Tree
// Height of a Tree = distance between root node and furthest leaf node
double height(BinaryNode? node) {
// Base case
  if (node == null) return -1;
// Here, you recursively call the height function of the child nodes.
// For every child node you visit, you add 1 to the height of the highest child
  return 1 + max( height(node.leftChild), height(node.rightChild) );
}

/// 2. Serialization
// Representing a complex object using another data type
extension Serializable<T> on BinaryNode<T> {
  // similar to traversePreOrder f(x) but performs action on null nodes too.
  void traversePreOrderWithNull(void Function(T? value) action)
  {
    action(value);
    if (leftChild == null) {
      action(null);
    }
    else {
      leftChild!.traversePreOrderWithNull(action);
    }
    if (rightChild == null) {
      action(null);
    }
    else {
      rightChild!.traversePreOrderWithNull(action);
    }
  }
}

List<T?> serialize<T>(BinaryNode<T> node) {
  final list = <T?>[];
  // add each node value(including nulls) to the list
  node.traversePreOrderWithNull((value) => list.add(value));
  return list;
}

// Deserialize takes a mutable list of values
BinaryNode<T>? deserialize<T>(List<T?> list) {
// This is the base case. If the list is empty you’ll end recursion here.
  if (list.isEmpty) return null;
// var to point at the last element in the list
  final value = list.removeLast();
// You also won’t bother making any nodes for null values in the list.
  if (value == null) return null;
// You reassemble the tree by creating a node from the current value
  final node = BinaryNode<T>(value);
// Recursively call deserialize to assign nodes to the left and right children.
  node.leftChild = deserialize(list);
  node.rightChild = deserialize(list);
  return node;
}

// This is a helper function that first reverses the list before calling the
// main deserialize function.
BinaryNode<T>? deserializeHelper<T>(List<T?> list) {
  return deserialize(list.reversed.toList());
}