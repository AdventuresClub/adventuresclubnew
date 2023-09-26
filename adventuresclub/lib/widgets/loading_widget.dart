import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: Colors.purple),
          SizedBox(height: 20),
          Text(
            "Loading Profile ...",
            style: TextStyle(color: Colors.purple),
          ),
        ],
      ),
    );
  }
}
