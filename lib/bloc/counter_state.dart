import 'package:equatable/equatable.dart';

abstract class CounterState extends Equatable {
  const CounterState();
}

class CounterInit extends CounterState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CounterUpdate extends CounterState {
  final int counter;

  const CounterUpdate({required this.counter});

  @override
  // TODO: implement props
  List<Object?> get props => [counter];
}
