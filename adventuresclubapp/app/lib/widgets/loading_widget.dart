import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: Colors.purple),
          const SizedBox(height: 20),
          Text(
            "loadingProfile".tr(),
            style: const TextStyle(color: Colors.purple),
          ),
        ],
      ),
    );
  }
}
