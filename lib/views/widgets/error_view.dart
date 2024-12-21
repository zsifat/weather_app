import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Object error;

  const ErrorView({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Error: $error'),
    );
  }
}
