
import 'avl_challenge.dart';

class AvlNode<T> extends TraversableBinaryNode<T>{
  AvlNode(this.value);

  @override
  T value;

  @override
  AvlNode<T>? leftChild;

  @override
  AvlNode<T>? rightChild;

  @override
  String toString() {
    return _diagram(this);
  }

  String _diagram(
      AvlNode<T>? node, [
        String top = '',
        String root = '',
        String bottom = ''
      ]) {
    if (node == null) {
      return '$root null\n';
    }
    if (node.leftChild == null && node.rightChild == null) {
      return '$root ${node.value}\n';
    }
    final a = _diagram(
      node.rightChild,
      '$top ',
      '$top┌──',
      '$top│ ',
    );
    final b = '$root${node.value}\n';
    final c = _diagram(
      node.leftChild,
      '$bottom│ ',
      '$bottom└──',
      '$bottom ',
    );
    return '$a$b$c';
  }

  int height = 0;
  // if the child is not null, return height of the child, else return -1
  int get leftHeight => leftChild?.height ?? -1;
  int get rightHeight => rightChild?.height ?? -1;
  // diff between height of children (value at most must be 1)
  int get balanceFactor => leftHeight - rightHeight;

}

