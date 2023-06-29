import 'package:equatable/equatable.dart';

class TabState extends Equatable {
  final int currentIndex;

  const TabState({
    required this.currentIndex,
  });

  factory TabState.initial() => const TabState(currentIndex: 0);

  @override
  List<Object?> get props => [currentIndex];

  @override
  String toString() {
    return 'TabState{currentIndex: $currentIndex}';
  }

  TabState copyWith({
    int? currentIndex,
  }) {
    return TabState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
