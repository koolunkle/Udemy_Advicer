import 'package:flutter/material.dart';

class AdviceField extends StatelessWidget {
  const AdviceField({required this.advice, super.key});

  final String advice;

  static String emptyAdvice = 'What should I do with an empty advice?';

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: themeData.colorScheme.onPrimary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Text(
            advice.isNotEmpty ? '''" $advice "''' : emptyAdvice,
            style: themeData.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
