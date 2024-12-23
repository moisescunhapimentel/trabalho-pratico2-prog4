import 'package:flutter/material.dart';
import 'package:trabalho2/utils/custom_response.dart';

void showErrorSnackBarIfHasError(
    BuildContext context, CustomResponse response) {
  if (!response.hasError) {
    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        response.error!,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    ),
  );
}
