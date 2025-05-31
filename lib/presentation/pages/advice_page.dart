import 'package:advicer/injection.dart';
import 'package:advicer/presentation/core/services/theme_service.dart';
import 'package:advicer/presentation/pages/cubit/advice_cubit.dart';
import 'package:advicer/presentation/pages/cubit/advice_cubit_state.dart';
import 'package:advicer/presentation/pages/widgets/advice_field.dart';
import 'package:advicer/presentation/pages/widgets/custom_button.dart';
import 'package:advicer/presentation/pages/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AdvicePageWrapperProvider extends StatelessWidget {
  const AdvicePageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<AdviceCubit>(),
      child: const AdvicePage(),
    );
  }
}

class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Advice', style: themeData.textTheme.headlineLarge),
        centerTitle: true,
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged:
                (_) =>
                    Provider.of<ThemeService>(
                      context,
                      listen: false,
                    ).toggleTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<AdviceCubit, AdviceCubitState>(
                  builder: (context, state) {
                    switch (state) {
                      case AdviceInitial _:
                        return Text(
                          'Your Advice is waiting for you',
                          style: themeData.textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        );
                      case AdviceStateLoading _:
                        return CircularProgressIndicator(
                          color: themeData.colorScheme.secondary,
                        );
                      case AdviceStateLoaded _:
                        return AdviceField(advice: state.advice);
                      case AdviceStateError _:
                        return ErrorMessage(message: state.message);
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Center(
                child: CustomButton(
                  onTap:
                      () =>
                          BlocProvider.of<AdviceCubit>(
                            context,
                          ).adviceRequested(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
