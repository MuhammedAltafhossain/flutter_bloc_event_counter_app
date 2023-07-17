import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter_bloc.dart';
import 'bloc/counter_event.dart';
import 'bloc/counter_state.dart';

class CounterHomePage extends StatefulWidget {
  const CounterHomePage({super.key, required this.title});

  final String title;

  @override
  State<CounterHomePage> createState() => _CounterHomePageState();
}

class _CounterHomePageState extends State<CounterHomePage> {
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
