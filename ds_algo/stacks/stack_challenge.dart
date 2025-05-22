
import 'stack_implementation.dart';

/// Reverse a List
void reverse(List list){
  Stacks stack = Stacks(5);
  for(var item in list){
    stack.push(item);
  }
  while(stack.isNotEmpty){
    print(stack.pop());
  }
}

/// Reverse a String
void reverseString(String text){
  Stacks stacker = Stacks(5);
  for(var i in text.codeUnits){
    stacker.push(i);
  }
  while(stacker.isNotEmpty){
    print(String.fromCharCode(stacker.pop()));
  }
}

/// Reverse words in a string
String reverseWords(String str) {
  Stack stack = Stack();
  String result = " ";

  for (int i = 0; i < str.length; ++i) {
    if (str.codeUnitAt(i) != " ")
      stack.push(str[i]);
    else {
      while (!stack.isEmpty) {
        result += stack.pop();
      }
      result = " ";
    }
  }
  // Reverse the words by popping them after being initially pushed
  while (!stack.isEmpty) {
    result += stack.pop();
  }
  return result;
}

/// Reverse a stack using recursion (w/o loops)
class Test{
  // using Stack class for stack implementation
  static Stack st = Stack();

  // Recursive function that inserts an element at the bottom of a stack.
  static void insert_at_bottom(dynamic x) {
    if (st.isEmpty)
      st.push(x);
    else {
      // All items are held in Function Call Stack until we reach end of the
      // stack. When the stack becomes empty, the st.size becomes 0, the
      // above if part is executed and the item is inserted at the bottom
      dynamic a = st.peek;
      st.pop();
      insert_at_bottom(x);
      // push all the items held in Function Call Stack once the item is
      // inserted at the bottom
      st.push(a);
    }
  }

  // Below is the function that reverses the given stack using insert_at_bottom()
  static void reverse(){
    if (st.size > 0) {
      // Hold all items in Function Call Stack until we reach end of the stack
      dynamic x = st.peek;
      st.pop();
      reverse();
      // Insert all the items held in Function Call Stack one by one from the
      // bottom to top.
      insert_at_bottom(x);
    }
  }
}

/// Checking for balanced parenthesis "()"
bool check(String text){
  Stacks stack = Stacks(5);
  int open = "(".codeUnitAt(0);
  int close = ")".codeUnitAt(0);

  for(var units in text.codeUnits){
    if(units == open){
      stack.push(units);
    }
    else if(units == close){
      if(stack.isEmpty){
        return false;
      }
      stack.pop();
    }
  }
  return stack.isEmpty;
}

/// Reverse Polish Notation
void main(){
  List token = [2,1,"+",4,"*",];
  // Output = 12 i.e ((2+1) * 4)
 final value = polishReverse(token);
 print(value);
}

 polishReverse(List list){
  Stack stack = Stack();
  for(var item in list){
    if(item == "+"){
      stack.push(stack.pop() + stack.pop());
    }
    else if(item == "*"){
     stack.push(stack.pop() * stack.pop());
    }
    //TODO prevent pushing the signs "+" or "*" into the stack ??
    stack.push(item);
  }
  return stack.storage;
}