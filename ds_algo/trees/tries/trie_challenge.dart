
import 'trie_implementation.dart';

/// Look up words using lists
class EnglishDictionary {
  final List<String> words = ["Cat","Cute","To","A"];
  List<String> lookup(String prefix) {
    return words.where((word) {
      return word.startsWith(prefix);
    }).toList();
  }
}

/// 1. Additional Properties (allStrings,count and isEmpty)
// add the following code in StringTie class

  // final Set<String> _allStrings = {};
  // Set<String> get allStrings => _allStrings;

  // in insert, under current.isTerminating = true;
  // _allStrings.add(text)

  // in remove, under current.isTerminating = false;
  // _allStrings.remove(text)

  // int get count => _allStrings.length;
  // bool get isEmpty => _allStrings.isEmpty;

/// 2. Generic Trie
class Trie<E, T extends Iterable<E>> {
  TrieNode<E> root = TrieNode(key: null, parent: null);

  void insert(T collection) {
    var current = root;
    for (E element in collection) {
      current.children[element] ??= TrieNode(
        key: element,
        parent: current,
      );
      current = current.children[element]!;
    }
    current.isTerminating = true;
  }

  bool contains(T collection){
    var current = root;
    for(E element in collection){
      final child = current.children[element];
      if(child == null){
        return false;
      }
      current = child;
    }
    return current.isTerminating;
  }

  void remove(T collection){
    var current = root;
    for(E element in collection){
      final child = current.children[element];
      if(child == null){
        return;
      }
      current = child;
    }
    if(!current.isTerminating){
      return;
    }
    current.isTerminating = false;
    while(current.parent != null && current.children.isEmpty &&
        !current.isTerminating){
      current.parent!.children[current.key!] = null;
      current = current.parent!;
    }
  }
}