
class RingBuffer<E> {
  RingBuffer(int length) : _list = List.filled(length, null, growable: false);

  final List<E?> _list;
  int _writeIndex = 0;
  int _readIndex = 0;
  int _size = 0;

  bool get isFull => _size == _list.length;

  bool get isEmpty => _size == 0;

  int _advance(int index) {
    return (index == _list.length - 1) ? 0 : index + 1;
  }

  void write(E element) {
    if (isFull) throw Exception('Buffer is full');
    // assign an index to the element being added
    _list[_writeIndex] = element;
    // increment index pointer by 1 if its not the last index in the list
    _writeIndex = _advance(_writeIndex);
    // increase list size
    _size++;
  }

  E? read() {
    if (isEmpty) return null;
    final element = _list[_readIndex];
    // increment index pointer by 1 if its not the last index in the list
    _readIndex = _advance(_readIndex);
    // decrease list size
    _size--;
    // return value of the element newly pointed at
    return element;
  }

  E? get peek => (isEmpty) ? null : _list[_readIndex];

  @override
  String toString() {
    final text = StringBuffer();
    text.write('[');
    int index = _readIndex;
    while (index != _writeIndex) {
      if (index != _readIndex) {
        text.write(', ');
      }
      text.write(_list[index % _list.length]);
      index++;
    }
    text.write(']');
    return text.toString();
  }
}

