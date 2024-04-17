import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabail/domain/api/api.dart';
import 'package:sabail/ui/theme/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HijriDateModel extends ChangeNotifier {
  String _hijriDate = '';

  String get hijriDate => _hijriDate;

  void fetchHijriDate() async {
    try {
      final hijriDate = await HijriApi().getCurrentHijriDate();
      _hijriDate = hijriDate;
      notifyListeners();
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Что то пошло не так: $error",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.purple,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
  }
}

class PrayTimes extends StatelessWidget {
  const PrayTimes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabailColors.notwhite,
      appBar: AppBar(
        title: Consumer<HijriDateModel>(
          builder: (context, model, child) {
            return Text(model.hijriDate.isEmpty
                ? 'Хиджри дата загрузки...'
                : model.hijriDate);
          },
        ),
      ),
      body: PTbody(),
    );
  }
}

class PTbody extends StatelessWidget {
  const PTbody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
