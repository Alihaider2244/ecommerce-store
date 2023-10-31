import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final title;
  PrimaryButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
