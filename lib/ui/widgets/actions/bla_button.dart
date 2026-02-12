import 'package:blabcar/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';

class BlaButton extends StatelessWidget {
  final IconData? icon;
  final String text;
  final bool isPrimary;
  const BlaButton({
    super.key,
    this.icon,
    required this.isPrimary,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isPrimary ? BlaColors.primary : BlaColors.white,
        border: Border.all(color: BlaColors.greyLight),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isPrimary ? BlaColors.white : BlaColors.primary,
            size: 16,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: isPrimary ? BlaColors.white : BlaColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
