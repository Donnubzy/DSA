
import '../stacks/stack_implementation.dart';

/// Reverse Stack
void main() {
  Stack stack = Test.st;
  stack.push(1);
  stack.push(2);
  stack.push(3);
  stack.push(4);

  print("Original Stack : ${stack.storage}");
  Test.reverse();
  print("Reversed Stack : ${stack.storage}");
}

class Test<E>{
  static Stack st = Stack();

  static void reverse<E>(){
    // if pushed items in the stack > 0
    if (st.size > 0) {
      E x = st.peek;
      st.pop();
      reverse();
      insert_at_bottom(x);
    }
  }

  static void insert_at_bottom<E>(E x) {
    // push to stack
    if (st.isEmpty)
      st.push(x);
    // push to temp stack
    else {
      E a = st.peek;
      st.pop();
      insert_at_bottom(x);
      st.push(a);
    }
  }
}