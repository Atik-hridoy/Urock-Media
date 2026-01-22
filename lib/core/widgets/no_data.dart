import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({super.key, this.text, required this.onPressed});
  final String? text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text ?? "No item found"),
          SizedBox(height: 10),
          SizedBox(
            width: 100,
            height: 40,
            child: ElevatedButton(onPressed: onPressed, child: Text("Retry")),
          ),
        ],
      ),
    );
  }
}
