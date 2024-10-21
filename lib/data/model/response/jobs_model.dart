import 'package:getondial/data/model/response/job_details.dart';

class Job {
  final int id;
  final int moduleId;
  final int storeId;
  final int vendorId;
  final String title;
  final int salary;
  final String description;
  final String createdAt;
  final String updatedAt;
  final Store? store;
  final String? image; // Added image field

  Job({
    required this.id,
    required this.moduleId,
    required this.storeId,
    required this.vendorId,
    required this.title,
    required this.salary,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.store,
    this.image, // Initialize image field
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      moduleId: json['module_id'],
      storeId: json['store_id'],
      vendorId: json['vendor_id'],
      title: json['title'],
      salary: json['salary'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      store: json['store'] != null ? Store.fromJson(json['store']) : null,
      image: json['image'], // Handle image field
    );
  }
}




// class Job {
//   final int id;
//   final int moduleId;
//   final int storeId;
//   final int vendorId;
//   final String title;
//   final int salary;
//   final String description;
//   final String createdAt;
//   final String updatedAt;
//   final Store? store;

//   Job({
//     required this.id,
//     required this.moduleId,
//     required this.storeId,
//     required this.vendorId,
//     required this.title,
//     required this.salary,
//     required this.description,
//     required this.createdAt,
//     required this.updatedAt,
//     this.store,
//   });

//   factory Job.fromJson(Map<String, dynamic> json) {
//     return Job(
//       id: json['id'],
//       moduleId: json['module_id'],
//       storeId: json['store_id'],
//       vendorId: json['vendor_id'],
//       title: json['title'],
//       salary: json['salary'],
//       description: json['description'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       store: json['store'] != null ? Store.fromJson(json['store']) : null,
//     );
//   }
// }

// class Store {
//   final int id;
//   final String name;
//   final String phone;
//   final String email;
//   final String logo;
//   final String latitude;
//   final String longitude;
//   final String address;

//   Store({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.email,
//     required this.logo,
//     required this.latitude,
//     required this.longitude,
//     required this.address,
//   });

//   factory Store.fromJson(Map<String, dynamic> json) {
//     return Store(
//       id: json['id'],
//       name: json['name'],
//       phone: json['phone'],
//       email: json['email'],
//       logo: json['logo'],
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//       address: json['address'],
//     );
//   }
// }