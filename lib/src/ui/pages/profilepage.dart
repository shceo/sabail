import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:provider/provider.dart';
import 'package:sabail/src/provider/image_picker_provider.dart';
import 'package:sabail/src/ui/theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Профиль',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              FlutterIslamicIcons.mosque,
              size: 30,
            ),
          ),
        ],
      ),
      body: const UserProfileBody(),
    );
  }
}

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              Provider.of<ImageNotifier>(context, listen: false).getImage();
            },
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Consumer<ImageNotifier>(
                    builder: (context, imageNotifier, child) {
                      return Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageNotifier.image == null
                                ? const AssetImage('assets/images/islamic_profile_placeholder.png')
                                : FileImage(imageNotifier.image!) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        FlutterIslamicIcons.quran,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildIslamicTextField(hintText: 'Введите имя', icon: Icons.abc),
          const SizedBox(height: 16),
          _buildIslamicTextField(hintText: 'Введите фамилию', icon: Icons.star),
        ],
      ),
    );
  }

  Widget _buildIslamicTextField({required String hintText, required IconData icon}) {
    return TextField(
      cursorColor: Colors.blue,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: SabailColors.darkpurple.withOpacity(0.2),
        prefixIcon: Icon(icon, color: Colors.blue),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
