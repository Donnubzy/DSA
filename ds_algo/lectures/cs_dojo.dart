
/// Solving sum of objects in Lists using Big O Notation(calc runtime)
// void main(){
//   List list = [2,4,18];
//   print(sum(list));
//
//   List list_2d = [
//     [1,1,1], // 0
//     [2,2,2], // 1
//     [3,3,3]  // 2
//   ];
//
//   int summation = sum(list_2d[0]) + sum(list_2d[1]) + sum(list_2d[2]);
//   print(summation);
// }

// int sum(List value){
//   int index = 0;
//   for(var i = 0; i < value.length; ++i){
//     index += value[i] as int;
//   }
//   return index;
// }

/// RECURSION : solving a f(n) problem by calling itself
// Factorial of a number : n! = n * (n-1) * (n-2)...3 * 2 * 1
// int fact(int n){
//   int value = 1;
//   if(n >= 1){
//     value = n * fact(n - 1);
//   }
//   return value;
// }

// Fibonacci sequence : 1,1,2,3,5,8,13,... (current + former = next)
// int fib(int n){
//    // base case => n < 3
//   int value = 1;
//   if(n >= 3){
//     // recursive case
//     value = fib(n-1) + fib(n-2);
//   }
//   return value;
// }

// Find how many steps it takes from the top left corner to the bottom right
// corner of a "n * m" square grid (where movement is only downward and to the
// right) e.g grid_path(3,3) -> 6

// int grid_path(int n, int m){
//   if(n == 1 || m == 1) return 1;
//   return grid_path(n, m-1) + grid_path(n-1, m);
// }

// Find the number of ways you can partition n objects using parts up to m
// (where m >= 0) e.g count_partitions(9,5) -> 23

// int count_partitions(int n, int m){
//   if(n == 0){
//     return 1;
//   }
//   else if (m == 0 || n < 0){
//     return 0;
//   }
//   return count_partitions(n-m, m) + count_partitions(n, m-1);
// }

/// Linked Lists
// void main(){
//   Node head = Node(6);
//   Node nodeB = Node(9);
//   Node nodeC = Node(4);
//   head.next = nodeB;
//   nodeB.next = nodeC;
//   print(count(head));
// }
//
// class Node {
//   int data;
//   Node? next = null;
//   Node(this.data);
// }
//
// int count(Node head){
//   int count = 1;
//   Node? current = head;
//   while(current?.next != null){
//     current = current?.next;
//     count += 1;
//   }
//   return count;
// }

/// TREES
/// Binary Tree example
// void main(){
//   Node root = Node(2);
//   Node nodeB = Node(3);
//   Node nodeC = Node(4);
//   root.left = nodeB;
//   root.right = nodeC;
//   nodeB.left = Node(5);
//   nodeB.right = Node(6);
//
//   print(find_sum(root));
// }
//
// class Node{
//   int data;
//   Node? left = null;
//   Node? right = null;
//   Node(this.data);
// }
// Calculating sum of data in the tree above (using recursion)
// find_sum(Node? root){
//   if(root == null){
//     return 0;
//   }
//   return root.data + find_sum(root.left) + find_sum(root.right);
// }


/// USING BINARY SEARCH TO FIND INDEX OF A NUMBER(Target) IN A LIST
// void main(){
//   List<int> numbers = [-2,3,4,7,8,9,11,13]; // ascending order
//   print(find_number(numbers, 8));
// }

// find_number(List arr, int target){
//   int left = 0;
//   int right = arr.length - 1;
//   //iterating through the list from 'left' to 'right' checking for the target.
//   while(left <= right){
//     int mid = (left + right) ~/ 2;
//     if(arr[mid] == target){
//       return mid;
//     }
//     else if (arr[mid] > target){
//    // right gets a new value, iteration re-occurs to check for target
//       right = mid - 1;
//     }
//     else {
//       left = mid + 1;
//     }
//   }
//   // if the value isn't in the list after iterating from left to right
//   return -1;
// }


String search(List<int> arr, int target){
  if(arr.isEmpty){
    return "Empty list";
  }
  int testEntry = 1;
  while(target > arr[0] && target < arr.length){
    if(target == arr[0]){
      return "Success";
    }
    testEntry += 1;
    return "Failure";
  }
  return "$target is not in the list";
}

/// Recurrence of an item in a hashtable/dictionary
// String? recur(String text){
//   Map counts = {};
//   for(var char in text.codeUnits){
//     // TODO: equate a char to an item in the counts Map
//     // If char is in counts
//     if(char == counts.keys){
//       return "${String.fromCharCode(char)}";
//     }
//     counts[char] = 1;
//   }
//   return null;
// }