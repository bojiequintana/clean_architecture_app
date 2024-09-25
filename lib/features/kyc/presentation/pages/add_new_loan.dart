import 'package:flutter/material.dart';

class AddNewLoan extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AddNewLoan(),
      );
  const AddNewLoan({super.key});

  @override
  State<AddNewLoan> createState() => _AddNewLoanState();
}

class _AddNewLoanState extends State<AddNewLoan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add loan application"),
      ),
      body: const Column(),
    );
  }
}
