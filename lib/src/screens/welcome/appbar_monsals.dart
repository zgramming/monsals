import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarMonsals extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final List<Widget>? actions;

  const AppBarMonsals({
    Key? key,
    this.height = kToolbarHeight,
    this.actions,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'MONSALS',
            style: GoogleFonts.openSans(),
          ),
          const SizedBox(width: 10),
          LiveClock(
            builder: (ctx, time) => RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: GlobalFunction.formatYMD(time)),
                  const TextSpan(text: ' '),
                  TextSpan(text: GlobalFunction.formatHMS(time)),
                ],
              ),
            ),
          )
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
