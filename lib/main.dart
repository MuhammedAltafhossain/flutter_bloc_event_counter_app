import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_event_counter_app/bloc/counter_bloc.dart';
import 'package:flutter_bloc_event_counter_app/bloc/counter_event.dart';

import 'bloc/counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (valueContext) => CounterBloc(),
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            if (state is CounterInit) {
              return _view(context, 0);
            }
            if (state is CounterUpdate) {
              return _view(context, state.counter);
            }

            return Container();
          },
        ));
  }

  Widget _view(BuildContext context, int value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<CounterBloc>().add(CounterIncrease());
              },
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                context.read<CounterBloc>().add(CounterDecrease());
              },
              child: const Icon(Icons.remove),
            )
          ],
        )
      ],
    );
  }
}
