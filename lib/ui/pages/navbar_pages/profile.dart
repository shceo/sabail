import 'package:flutter/material.dart';
import 'package:sabail/ui/theme/app_colors.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabailColors.notwhite,
      body: const ProfileBody(),
    );
  }
}



class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(

          
        ),
        CircleAvatar(
          child: Container(color: Colors.amber,),
        )
      ],
    );
  }
}