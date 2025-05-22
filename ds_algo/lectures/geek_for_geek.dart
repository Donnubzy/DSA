
import '../stacks/stack_implementation.dart';

void main () {
  List<String> names = const ["Abu", "Ada", "Bosun", "James", "Tochi", "Wiz"];
  List<int> numbers = const [6, 8, 0, 1, 3];

  List<List> mat = [
    [ 0, 1, 0 ],
    [ 0, 0, 0 ], //b
    [ 0, 1, 0 ], //a
  ];
  print(GfG.celebrity(mat));
}

class GfG {
  // Function to find the celebrity
  static int celebrity(List<List> mat) {
    int n = mat.length;
    Stacks st = Stacks(9);

    // Push everybody in stack
    for (int i = 0; i < n; i++) {
      st.push(i);
    }

    // Find a potential celebrity
    while (st.size > 1 && st.size < n) {
      int a = st.peek;
      st.pop();
      int b = st.peek;
      st.pop();

      // if a knows b
      if (mat[a][b] != 0) {
        st.push(b);
      }
      st.push(a);
    }

    // Potential candidate of celebrity
    int c = st.peek;
    st.pop();

    // Check if c is actually a celebrity or not
    for (int i = 0; i < n; i++) {
      if(i == c) continue;

    // If any person doesn't know 'c' or 'c' doesn't know any person, return -1
      else if (mat[c][i] != 0 || mat[i][c] == 0)
        return -1;
    }
    return c;
  }
}

/// Reverse Stack
// void main() {
//   Stack stack = Test.st;
//   stack.push(1);
//   stack.push(2);
//   stack.push(3);
//   stack.push(4);
//
//   print("Original Stack : ${stack.storage}");
//   Test.reverse();
//   print("Reversed Stack : ${stack.storage}");
// }

class Test{
  static Stack st = Stack();

  static void reverse(){
    // if pushed items in the stack > 0
    if (st.size > 0) {
      dynamic x = st.peek;
      st.pop();
      reverse();
      insert_at_bottom(x);
    }
  }

  static void insert_at_bottom(dynamic x) {
    // push to stack
    if (st.isEmpty)
      st.push(x);
    // push to temp stack
    else {
      dynamic a = st.peek;
      st.pop();
      insert_at_bottom(x);
      st.push(a);
    }
  }
}