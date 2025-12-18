import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfview_app/pages/design/images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({
    super.key
  });


  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 16,
      title: const Text('SelfView'),
      actionsPadding: const EdgeInsets.only(right: 16),
      actions: <Widget>[
        SvgIconButton()
      ],
    );
  }
}


class SvgIconButton extends StatelessWidget {

  const SvgIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){},
      icon: SvgPicture.asset(
        'assets/icons/profile_user.svg',
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(Color(0xFF2D6CDF), BlendMode.srcIn),
      )
    );
  }
}
