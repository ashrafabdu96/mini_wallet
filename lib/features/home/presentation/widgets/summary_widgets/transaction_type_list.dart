import 'package:flutter/material.dart';

class TransactionTypeWidget extends StatefulWidget {
  const TransactionTypeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionTypeWidget> createState() => TransactionTypeWidgetState();
}

class TransactionTypeWidgetState extends State<TransactionTypeWidget> {
  String type = "withdraw";
  bool isDeposit = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: const Text("Transaction Type"),
      value: type,
      items: const [
        DropdownMenuItem(
          value: "deposit",
          child: Text("Deposit"),
        ),
        DropdownMenuItem(
          value: "withdraw",
          child: Text("Withdraw"),
        ),
      ],
      onChanged: (onChanged) {
        type = onChanged.toString();
        setState(
          () {
            isDeposit = onChanged == "deposit" ? true : false;
          },
        );
      },
    );
  }
}
