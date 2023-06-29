class ChangeTabAction {
  final int index;

  const ChangeTabAction({
    required this.index,
  });

  @override
  String toString() {
    return 'SetCurrentIndexAction{index: $index}';
  }
}
