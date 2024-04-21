import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabail/provider/image_picker_provider.dart';
import 'package:sabail/ui/theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Профиль',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: UserProfileBody(),
    );
  }
}

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ImageNotifier imageNotifier = ImageNotifier();

    return SingleChildScrollView(
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
                        width: 200.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageNotifier.image == null
                                ? const AssetImage('assets/images/фото.png')
                                : FileImage(imageNotifier.image!)
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  right: 120.0,
                  bottom: 15.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: SabailColors.notwhite,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.edit, size: 33, color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              cursorColor: Colors.blue,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                // fillColor: CryptoColors.grey.withOpacity(0.5),
                hintText: 'Введите имя',
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              cursorColor: Colors.blue,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                // fillColor: CryptoColors.grey.withOpacity(0.5),
                hintText: 'Введите фамилию',
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
