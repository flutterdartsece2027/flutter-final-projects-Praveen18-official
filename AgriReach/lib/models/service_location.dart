class ServiceLocation {
  final String id;
  final String name;
  final String type;
  final String address;
  final String phone;
  final double latitude;
  final double longitude;
  final double? distance; // in kilometers
  final String? imageUrl;
  final String? description;
  final List<String>? services;
  final Map<String, dynamic>? additionalInfo;

  ServiceLocation({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.phone,
    required this.latitude,
    required this.longitude,
    this.distance,
    this.imageUrl,
    this.description,
    this.services,
    this.additionalInfo,
  });

  // Convert to JSON for API calls
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'address': address,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
      'imageUrl': imageUrl,
      'description': description,
      'services': services,
      'additionalInfo': additionalInfo,
    };
  }

  // Create from JSON
  factory ServiceLocation.fromJson(Map<String, dynamic> json) {
    return ServiceLocation(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      distance: json['distance']?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      services: json['services'] != null 
          ? List<String>.from(json['services'] as List)
          : null,
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>?,
    );
  }
}
