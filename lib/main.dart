import 'package:flutter/material.dart';
import 'package:weather_app/database/databases.dart';
import 'package:weather_app/top_page/mountain_list.dart';

void main() async {
  // Flutterの初期化を確実に行う
  WidgetsFlutterBinding.ensureInitialized();
  
  // データベースの初期化
  await createDatabase();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '九州天気情報',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreen,
          brightness: Brightness.dark,
        ),
      ),
      home: const LocationSelectionScreen(),
    );
  }
}

class LocationSelectionScreen extends StatelessWidget {
  const LocationSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('場所を選択してください'),
        centerTitle: true,
      ),
      body: const LocationGrid(),
    );
  }
}

class LocationGrid extends StatelessWidget {
  const LocationGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildLocationRow(context, [
            _LocationData('福岡', 1, Colors.lightBlue[300]!),
            _LocationData('大分', 7, Colors.red[100]!),
          ]),
          const SizedBox(height: 16),
          _buildLocationRow(context, [
            _LocationData('長崎', 3, Colors.lightGreen[600]!),
            _LocationData('佐賀', 2, Colors.blue[300]!),
          ]),
          const SizedBox(height: 16),
          _buildLocationRow(context, [
            _LocationData('熊本', 4, Colors.red[300]!),
            _LocationData('宮崎', 5, Colors.green),
          ]),
          const SizedBox(height: 16),
          _buildLocationRow(context, [
            _LocationData('鹿児島', 6, Colors.grey[800]!),
            _LocationData('沖縄', 8, Colors.pink[300]!),
          ]),
        ],
      ),
    );
  }

  Widget _buildLocationRow(BuildContext context, List<_LocationData> locations) {
    return Row(
      children: locations.map((location) => 
        Expanded(
          child: _buildLocationButton(context, location),
        )
      ).toList(),
    );
  }

  Widget _buildLocationButton(BuildContext context, _LocationData location) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () => _navigateToLocationDetails(context, location.id),
        style: ElevatedButton.styleFrom(
          backgroundColor: location.color,
          minimumSize: const Size.fromHeight(150),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          location.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _navigateToLocationDetails(BuildContext context, int locationId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MountainList(num: locationId),
      ),
    );
  }
}

class _LocationData {
  final String name;
  final int id;
  final Color color;

  const _LocationData(this.name, this.id, this.color);
}
