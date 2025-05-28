import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sabail/src/ui/pages/screens/tasbih_Screen.dart';
import 'package:sabail/src/presentation/app/app_colors.dart';

class MainThreePodWidget extends StatelessWidget {
  const MainThreePodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> texts = ['Кибла', 'Тасбих', 'Сунна'];
    List<IconData> icons = [
      FlutterIslamicIcons.qibla,
      FlutterIslamicIcons.solidTasbih2,
      FlutterIslamicIcons.wudhu,
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        3,
        (index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Page(index)),
            );
          },
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icons[index],
                  size: 28,
                  color: SabailColors.darkpurple,
                ),
                Text(
                  texts[index],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  final int index;
  Page(this.index);

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return const QiblahCompassScreen();
    } else if (index == 1) {
      return TasbihScreen();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Дуа'),
        ),
        body: const Center(
          child: Text('Здесь будут отображаться Дуа'),
        ),
      );
    }
  }
}

class QiblahCompassScreen extends StatefulWidget {
  const QiblahCompassScreen({Key? key}) : super(key: key);

  @override
  State<QiblahCompassScreen> createState() => _QiblahCompassScreenState();
}

class _QiblahCompassScreenState extends State<QiblahCompassScreen> {
  bool _hasPermission = false;
  int _selectedCompass = 0; // 0: Basic, 1: Needle, 2: Map

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
    }
    setState(() {
      _hasPermission = status.isGranted;
    });
  }

  Widget _buildCompassWidget() {
    switch (_selectedCompass) {
      case 0:
        return const BasicCompass();
      case 1:
        return const QiblahCompassWithNeedle();
      case 2:
        return const QiblahMapCompass();
      default:
        return const BasicCompass();
    }
  }

  Widget _buildIconButton(int compassIndex, IconData icon) {
    bool isSelected = _selectedCompass == compassIndex;
    return Material(
      shape: const CircleBorder(),
      color: isSelected ? SabailColors.darkpurple : Colors.white,
      elevation: isSelected ? 4 : 2,
      child: IconButton(
        icon: Icon(icon, color: isSelected ? Colors.white : SabailColors.darkpurple),
        onPressed: () {
          setState(() {
            _selectedCompass = compassIndex;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabailColors.notwhite,
      appBar: AppBar(
        backgroundColor: SabailColors.darkpurple,
        title: const Text('Кибла'),
      ),
      body: _hasPermission
          ? Stack(
              children: [
                Center(child: _buildCompassWidget()),
                // Круглые кнопки для переключения режимов, расположенные справа
                Positioned(
                  right: 16,
                  top: MediaQuery.of(context).size.height / 2 - 75,
                  child: Column(
                    children: [
                      _buildIconButton(0, Icons.explore),
                      const SizedBox(height: 16),
                      _buildIconButton(1, Icons.adjust),
                      const SizedBox(height: 16),
                      _buildIconButton(2, Icons.map),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: ElevatedButton(
                onPressed: _checkPermission,
                child: const Text('Разрешить доступ к местоположению'),
              ),
            ),
    );
  }
}

class BasicCompass extends StatelessWidget {
  const BasicCompass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QiblahDirection>(
      stream: FlutterQiblah.qiblahStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(SabailColors.maketPurple),
          );
        }
        if (snapshot.hasError) {
          return Text('Ошибка: ${snapshot.error}');
        }
        final qiblahDirection = snapshot.data;
        double angle = qiblahDirection?.qiblah ?? 0;
        return Transform.rotate(
          angle: angle * (math.pi / 180) * -1,
          child: Icon(
            Icons.explore,
            size: 200,
            color: SabailColors.darkpurple,
          ),
        );
      },
    );
  }
}

class QiblahCompassWithNeedle extends StatelessWidget {
  const QiblahCompassWithNeedle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QiblahDirection>(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(SabailColors.maketPurple),
          );
        if (snapshot.hasError) {
          return Text('Ошибка: ${snapshot.error}');
        }
        final qiblahDirection = snapshot.data;
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.rotate(
              angle: ((qiblahDirection?.direction ?? 0) * (math.pi / 180) * -1),
              child: SvgPicture.asset('assets/compass.svg'),
            ),
            Transform.rotate(
              angle: ((qiblahDirection?.qiblah ?? 0) * (math.pi / 180) * -1),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/needle.svg',
                fit: BoxFit.contain,
                height: 300,
              ),
            ),
            Positioned(
              bottom: 8,
              child: Text("${qiblahDirection?.offset.toStringAsFixed(3)}°"),
            ),
          ],
        );
      },
    );
  }
}

class QiblahMapCompass extends StatefulWidget {
  const QiblahMapCompass({Key? key}) : super(key: key);

  @override
  _QiblahMapCompassState createState() => _QiblahMapCompassState();
}

class _QiblahMapCompassState extends State<QiblahMapCompass> {
  GoogleMapController? _controller;
  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(21.4225, 39.8262), // Координаты Каабы
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _initialPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
      onMapCreated: (controller) => _controller = controller,
      markers: {
        const Marker(
          markerId: MarkerId('kaaba'),
          position: LatLng(21.4225, 39.8262),
          infoWindow: InfoWindow(title: 'Кааба'),
        ),
      },
    );
  }
}
