
void main(){
  // // create instance var of class
  // Addition sum = Addition(9);
  // // add 'value' to setter
  // final result = sum.add = 5;
  // // call getter
  // print(sum.addition);
  //
  // // Addition operator
  // final add = Addition(7);
  // final add2 = Addition(8);
  // final product = add + add2;
  // print(product.number);
}

class Addition{
  Addition(this.number);
  int number;

  set add(int value) => number = value * 2;
  int get addition => number;

  Addition operator + (Addition other){
    return Addition(
        number + other.number
    );
  }
}

// void rhombus(int n){
//   var stars = "* " * n;
//   int empty = int.parse("");
//   for (int space = 1; space <= n; space++){
//     // print(space * " " + stars);
//     print(space * int.parse("*"));
//   }
// }
