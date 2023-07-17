import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_event_counter_app/bloc/counter_bloc.dart';
import 'package:flutter_bloc_event_counter_app/bloc/counter_event.dart';
import 'package:flutter_bloc_event_counter_app/bloc_api/user_bloc.dart';
import 'package:flutter_bloc_event_counter_app/bloc_api/user_event.dart';
import 'package:flutter_bloc_event_counter_app/bloc_api/user_state.dart';

import 'bloc/counter_state.dart';
import 'bloc_api/model/user_model.dart';
import 'bloc_pattern_counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (valueContext) => UserBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Bloc Event'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserBloc>().add(GetAllUserList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserError) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is UserDataLoaded) {
              return _view(context, state.userModelList);
            }

            return Container();
          },
        ));
  }

  Widget _view(BuildContext context, List<UserModel> userModelList) {
    return ListView.builder(
        itemCount: userModelList.length,
        itemBuilder: (context, itemIndex) {
          UserModel userModel = userModelList[itemIndex];
          return ListTile(
            leading: Text(userModel.id.toString()),
            title: Text(userModel.name.toString()),
            subtitle: Text(userModel.email.toString()),
          );
        });
  }
}
