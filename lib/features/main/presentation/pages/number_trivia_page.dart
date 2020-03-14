import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honeycrisp/features/main/presentation/bloc/number_trivia_bloc.dart';
import 'package:honeycrisp/features/main/presentation/widgets/widgets.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Number Trivia'),
        ),
        body: SingleChildScrollView(
          child: buildBody(context),
        ));
  }

  // NOTE: Interesting how Reso Coder builds the screen wireframe
  //       layout with placeholders:
  //       https://www.youtube.com/watch?v=G-R-1rzR3zw (15m)
  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(message: 'Start searching');
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(
                      numberTrivia: state.trivia,
                    );
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                },
              ),
              // top half of the screen with height

              SizedBox(height: 20),
              // Bottom half
              TriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}

