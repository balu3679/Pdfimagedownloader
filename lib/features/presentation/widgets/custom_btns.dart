import 'package:flutter/material.dart';

class CustomBtns extends StatelessWidget {
  final bool? hasicon;
  final IconData? icon;
  final String label;
  final bool? isloading;
  final Function() onpress;
  const CustomBtns({
    super.key,
    this.hasicon = false,
    required this.label,
    this.isloading = false,
    this.icon,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onpress,
      style: TextButton.styleFrom(fixedSize: Size.fromHeight(56)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            isloading!
                ? [CircularProgressIndicator(color: Colors.white)]
                : [
                  if (hasicon!) Icon(icon),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                  ),
                ],
      ),
    );
  }
}
