
import '../../queues/queue_implementation.dart';
import 'general_implementation.dart';

/// 1. Print each element in a tree by Level
void printEachLevel<T>(TreeNode<T> tree) {
  final result = StringBuffer();
  // Initialize a Queue data structure to facilitate the level-order traversal.
  final queue = QueueStack<TreeNode<T>>();
  // To note the amount of nodes to work on before moving to new line/level.
  var nodesLeftInCurrentLevel = 0;
  // Enqueue all elements in the Tree used
  queue.enqueue(tree);
  // Your level-order traversal continues until your queue is empty.
  while (!queue.isEmpty) {
    // In the first while loop, set nodesLeftInCurrentLevel to the number of
    // current elements in the queue (by level).
    nodesLeftInCurrentLevel = queue.length;
    // Using another while loop, you dequeue the first nodesLeftInCurrentLevel
    // number of elements from the queue.
    while (nodesLeftInCurrentLevel > 0) {
      final node = queue.dequeue();
      if (node == null) break;
      // Every element you dequeue is added to result w/o establishing a new line.
      result.write('${node.value} ');
      // Enqueue all the children of the node.
      for (var element in node.children) {
        queue.enqueue(element);
      }
      // decrement counter for nodesLeftInCurrentLevel till it gets to 0.
      nodesLeftInCurrentLevel -= 1;
    }
    // At this point, you append a newline to result. In the next iteration,
    // nodesLeftInCurrentLevel will be updated with the count of the queue,
    // representing the number of children from the previous iteration.
    result.write('\n');
  }
  print(result);
}

/// 2.
///  Create three separate nodes with the following names and types:
//  • Column: a tree node that takes multiple children.
//  • Padding: a tree node that takes a single child.
//  • Text: a tree leaf node.
//  Use your widget nodes to build a simple widget tree.

class Widget {}

class Column extends Widget {
  Column({this.children});
  List<Widget>? children;
}

class Padding extends Widget {
  Padding({this.value = 0.0, this.child});
  double value;
  Widget? child;
}

class Text extends Widget {
  Text([this.value = ""]);
  String value;
}