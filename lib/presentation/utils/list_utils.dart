extension ListUtils<T> on List<T> {
  /// Extension on [List] to insert a specified [element] between each pair of elements in the list.
  ///
  /// If the list is empty, it returns an empty list.
  ///
  /// Example:
  /// ```{dart}
  /// List<int> myList = [1, 2, 3];
  /// print(myList.insertBetweenElements(0));  // Output: [1, 0, 2, 0, 3]
  /// ```
  List<T> insertBetweenElements(T element) {
    if (isEmpty) {
      return [];
    }

    final result = <T>[];

    for (var i = 0; i < length - 1; i++) {
      result
        ..add(elementAt(i))
        ..add(element);
    }

    result.add(last);

    return result;
  }

  T? firstOrNullWhere(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }

    return null;
  }
}
