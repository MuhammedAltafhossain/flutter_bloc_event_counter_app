import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {}

class GetAllUserList extends UserEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
