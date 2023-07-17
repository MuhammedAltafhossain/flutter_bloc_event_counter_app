import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_event_counter_app/bloc_api/api_service/api_service.dart';
import 'package:flutter_bloc_event_counter_app/bloc_api/user_event.dart';
import 'package:flutter_bloc_event_counter_app/bloc_api/user_state.dart';

import 'model/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  List<UserModel> userModelList = [];

  UserBloc() : super(UserInit()) {
    ApiService apiService = ApiService();
    on<GetAllUserList>((event, emit) async {
      try {
        emit(UserLoading());
        userModelList = await apiService.getData();
        emit(UserDataLoaded(userModelList));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
