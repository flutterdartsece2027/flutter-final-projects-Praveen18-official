import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:flutter/foundation.dart' show kIsWeb;

class NearbyServicesScreen extends StatefulWidget {
  static const routeName = '/nearby-services';

  const NearbyServicesScreen({Key? key}) : super(key: key);

  @override
  _NearbyServicesScreenState createState() => _NearbyServicesScreenState();
}

class ServiceLocation {
  final String name;
  final String type;
  final latlong2.LatLng position;
  final Color color;

  ServiceLocation({
    required this.name,
    required this.type,
    required this.position,
    required this.color,
  });
}

class _NearbyServicesScreenState extends State<NearbyServicesScreen> {
  final MapController _mapController = MapController();
  final latlong2.LatLng _coimbatoreCenter = const latlong2.LatLng(11.0168, 76.9558);
  late List<ServiceLocation> _serviceLocations;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeServiceLocations();
    // Add a small delay to ensure map tiles load properly
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _initializeServiceLocations() {
    _serviceLocations = [
      // Fertilizer Shops (Blue)
      ServiceLocation(
        name: 'Co-optex Fertilizer',
        type: 'fertilizer',
        position: const latlong2.LatLng(11.0268, 76.9558),
        color: Colors.blue,
      ),
      // Seed Suppliers (Green)
      ServiceLocation(
        name: 'Kaveri Seeds',
        type: 'seed',
        position: const latlong2.LatLng(11.0068, 76.9458),
        color: Colors.green,
      ),
      // Government Help Centers (Orange)
      ServiceLocation(
        name: 'Krishi Vigyan Kendra',
        type: 'govt',
        position: const latlong2.LatLng(11.0168, 76.9658),
        color: Colors.orange,
      ),
      // Equipment Rental (Purple)
      ServiceLocation(
        name: 'Farm Equipment Rental',
        type: 'equipment',
        position: const latlong2.LatLng(11.0068, 76.9758),
        color: Colors.purple,
      ),
    ];
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Widget _buildMap() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: _coimbatoreCenter,
        zoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
          userAgentPackageName: 'com.agrireach.app',
          maxZoom: 19,
        ),
        MarkerLayer(
          markers: _serviceLocations.map((location) {
            return Marker(
              point: location.position,
              width: 40,
              height: 40,
              child: Icon(
                _getIconForType(location.type),
                color: location.color,
                size: 40,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _zoomIn() {
    _mapController.move(
      _mapController.center,
      _mapController.zoom + 1,
    );
  }

  void _zoomOut() {
    if (_mapController.zoom > 1) {
      _mapController.move(
        _mapController.center,
        _mapController.zoom - 1,
      );
    }
  }

  Widget _buildLegend() {
    return Positioned(
      top: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLegendItem('Fertilizer Shops', Colors.blue),
            _buildLegendItem('Seed Suppliers', Colors.green),
            _buildLegendItem('Govt. Help Centers', Colors.orange),
            _buildLegendItem('Equipment Rental', Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agricultural Services - Coimbatore'),
      ),
      body: Stack(
        children: [
          // Map container
          SizedBox.expand(
            child: _buildMap(),
          ),
          _buildLegend(),
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoomIn',
                  mini: true,
                  onPressed: _zoomIn,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'zoomOut',
                  mini: true,
                  onPressed: _zoomOut,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'fertilizer':
        return Icons.eco;
      case 'seed':
        return Icons.grass;
      case 'govt':
        return Icons.account_balance;
      case 'equipment':
        return Icons.agriculture;
      default:
        return Icons.location_on;
    }
  }
}
