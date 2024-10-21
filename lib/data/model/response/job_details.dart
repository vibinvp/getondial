// class JobRequirement {
//   int id;
//   int moduleId;
//   int storeId;
//   int vendorId;
//   String title;
//   int salary;
//   String description;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Store store;
//   Vendor vendor;

//   JobRequirement({
//     required this.id,
//     required this.moduleId,
//     required this.storeId,
//     required this.vendorId,
//     required this.title,
//     required this.salary,
//     required this.description,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.store,
//     required this.vendor,
//   });

//   factory JobRequirement.fromJson(Map<String, dynamic> json) {
//     return JobRequirement(
//       id: json['id'],
//       moduleId: json['module_id'],
//       storeId: json['store_id'],
//       vendorId: json['vendor_id'],
//       title: json['title'],
//       salary: json['salary'],
//       description: json['description'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       store: Store.fromJson(json['store']),
//       vendor: Vendor.fromJson(json['vendor']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'module_id': moduleId,
//       'store_id': storeId,
//       'vendor_id': vendorId,
//       'title': title,
//       'salary': salary,
//       'description': description,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//       'store': store.toJson(),
//       'vendor': vendor.toJson(),
//     };
//   }
// }

// class Store {
//   int id;
//   String name;
//   String phone;
//   String email;
//   String logo;
//   String latitude;
//   String longitude;
//   String address;
//   int? minimumOrder;
//   bool? scheduleOrder;
//   int? status;
//   int vendorId;
//   DateTime createdAt;
//   DateTime updatedAt;
//   bool? freeDelivery;
//   List<int> rating;
//   String coverPhoto;
//   bool? delivery;
//   bool? takeAway;
//   bool? itemSection;
//   int? tax;
//   int? zoneId;
//   bool? reviewsSection;
//   bool? active;
//   String? offDay;
//   int? selfDeliverySystem;
//   bool? posSystem;
//   int? minimumShippingCharge;
//   String? deliveryTime;
//   int? veg;
//   int? nonVeg;
//   int? orderCount;
//   int? totalOrder;
//   int? moduleId;
//   int? orderPlaceToScheduleInterval;
//   int? featured;
//   int? perKmShippingCharge;
//   bool? prescriptionOrder;
//   String? slug;
//   String? maximumShippingCharge;
//   bool? cutlery;
//   bool? gstStatus;
//   String? gstCode;
//   List<Translation> translations;

//   Store({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.email,
//     required this.logo,
//     required this.latitude,
//     required this.longitude,
//     required this.address,
//     this.minimumOrder,
//     this.scheduleOrder,
//     this.status,
//     required this.vendorId,
//     required this.createdAt,
//     required this.updatedAt,
//     this.freeDelivery,
//     required this.rating,
//     required this.coverPhoto,
//     this.delivery,
//     this.takeAway,
//     this.itemSection,
//     this.tax,
//     this.zoneId,
//     this.reviewsSection,
//     this.active,
//     this.offDay,
//     this.selfDeliverySystem,
//     this.posSystem,
//     this.minimumShippingCharge,
//     this.deliveryTime,
//     this.veg,
//     this.nonVeg,
//     this.orderCount,
//     this.totalOrder,
//     this.moduleId,
//     this.orderPlaceToScheduleInterval,
//     this.featured,
//     this.perKmShippingCharge,
//     this.prescriptionOrder,
//     this.slug,
//     this.maximumShippingCharge,
//     this.cutlery,
//     this.gstStatus,
//     this.gstCode,
//     required this.translations,
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
//       minimumOrder: json['minimum_order'],
//       scheduleOrder: json['schedule_order'],
//       status: json['status'],
//       vendorId: json['vendor_id'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       freeDelivery: json['free_delivery'],
//       rating: List<int>.from(json['rating']),
//       coverPhoto: json['cover_photo'],
//       delivery: json['delivery'],
//       takeAway: json['take_away'],
//       itemSection: json['item_section'],
//       tax: json['tax'],
//       zoneId: json['zone_id'],
//       reviewsSection: json['reviews_section'],
//       active: json['active'],
//       offDay: json['off_day'],
//       selfDeliverySystem: json['self_delivery_system'],
//       posSystem: json['pos_system'],
//       minimumShippingCharge: json['minimum_shipping_charge'],
//       deliveryTime: json['delivery_time'],
//       veg: json['veg'],
//       nonVeg: json['non_veg'],
//       orderCount: json['order_count'],
//       totalOrder: json['total_order'],
//       moduleId: json['module_id'],
//       orderPlaceToScheduleInterval: json['order_place_to_schedule_interval'],
//       featured: json['featured'],
//       perKmShippingCharge: json['per_km_shipping_charge'],
//       prescriptionOrder: json['prescription_order'],
//       slug: json['slug'],
//       maximumShippingCharge: json['maximum_shipping_charge'],
//       cutlery: json['cutlery'],
//       gstStatus: json['gst_status'],
//       gstCode: json['gst_code'],
//       translations: (json['translations'] as List)
//           .map((e) => Translation.fromJson(e))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'phone': phone,
//       'email': email,
//       'logo': logo,
//       'latitude': latitude,
//       'longitude': longitude,
//       'address': address,
//       'minimum_order': minimumOrder,
//       'schedule_order': scheduleOrder,
//       'status': status,
//       'vendor_id': vendorId,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//       'free_delivery': freeDelivery,
//       'rating': rating,
//       'cover_photo': coverPhoto,
//       'delivery': delivery,
//       'take_away': takeAway,
//       'item_section': itemSection,
//       'tax': tax,
//       'zone_id': zoneId,
//       'reviews_section': reviewsSection,
//       'active': active,
//       'off_day': offDay,
//       'self_delivery_system': selfDeliverySystem,
//       'pos_system': posSystem,
//       'minimum_shipping_charge': minimumShippingCharge,
//       'delivery_time': deliveryTime,
//       'veg': veg,
//       'non_veg': nonVeg,
//       'order_count': orderCount,
//       'total_order': totalOrder,
//       'module_id': moduleId,
//       'order_place_to_schedule_interval': orderPlaceToScheduleInterval,
//       'featured': featured,
//       'per_km_shipping_charge': perKmShippingCharge,
//       'prescription_order': prescriptionOrder,
//       'slug': slug,
//       'maximum_shipping_charge': maximumShippingCharge,
//       'cutlery': cutlery,
//       'gst_status': gstStatus,
//       'gst_code': gstCode,
//       'translations': translations.map((e) => e.toJson()).toList(),
//     };
//   }
// }

// class Translation {
//   int id;
//   String translationableType;
//   int translationableId;
//   String locale;
//   String key;
//   String value;

//   Translation({
//     required this.id,
//     required this.translationableType,
//     required this.translationableId,
//     required this.locale,
//     required this.key,
//     required this.value,
//   });

//   factory Translation.fromJson(Map<String, dynamic> json) {
//     return Translation(
//       id: json['id'],
//       translationableType: json['translationable_type'],
//       translationableId: json['translationable_id'],
//       locale: json['locale'],
//       key: json['key'],
//       value: json['value'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'translationable_type': translationableType,
//       'translationable_id': translationableId,
//       'locale': locale,
//       'key': key,
//       'value': value,
//     };
//   }
// }

// class Vendor {
//   int id;
//   String firstName;
//   String lastName;
//   String phone;
//   String email;
//   DateTime? emailVerifiedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String? bankName;
//   String? branch;
//   String? holderName;
//   String? accountNo;
//   String? image;
//   String? status;
//   String? firebaseToken;

//   Vendor({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.phone,
//     required this.email,
//     this.emailVerifiedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     this.bankName,
//     this.branch,
//     this.holderName,
//     this.accountNo,
//     this.image,
//     this.status,
//     this.firebaseToken,
//   });

//   factory Vendor.fromJson(Map<String, dynamic> json) {
//     return Vendor(
//       id: json['id'],
//       firstName: json['f_name'],
//       lastName: json['l_name'],
//       phone: json['phone'],
//       email: json['email'],
//       emailVerifiedAt: json['email_verified_at'] != null
//           ? DateTime.parse(json['email_verified_at'])
//           : null,
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       bankName: json['bank_name'],
//       branch: json['branch'],
//       holderName: json['holder_name'],
//       accountNo: json['account_no'],
//       image: json['image'],
//       status: json['status'],
//       firebaseToken: json['firebase_token'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'f_name': firstName,
//       'l_name': lastName,
//       'phone': phone,
//       'email': email,
//       'email_verified_at': emailVerifiedAt?.toIso8601String(),
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//       'bank_name': bankName,
//       'branch': branch,
//       'holder_name': holderName,
//       'account_no': accountNo,
//       'image': image,
//       'status': status,
//       'firebase_token': firebaseToken,
//     };
//   }
// }

import 'dart:convert';

class JobRequirement {
    final List<Value>? value;
    final String? message;

    JobRequirement({
        this.value,
        this.message,
    });

    factory JobRequirement.fromRawJson(String str) => JobRequirement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory JobRequirement.fromJson(Map<String, dynamic> json) => JobRequirement(
        value: json["value"] == null ? [] : List<Value>.from(json["value"]!.map((x) => Value.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "value": value == null ? [] : List<dynamic>.from(value!.map((x) => x.toJson())),
        "message": message,
    };
}

class Value {
    final int? id;
    final int? moduleId;
    final int? storeId;
    final int? vendorId;
    final String? title;
    final String? image; // Added image field
    final int? salary;
    final String? description;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Store? store;
    final Vendor? vendor;

    Value({
        this.id,
        this.moduleId,
        this.storeId,
        this.vendorId,
        this.title,
        this.image, // Constructor update
        this.salary,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.store,
        this.vendor,
    });

    factory Value.fromRawJson(String str) => Value.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        moduleId: json["module_id"],
        storeId: json["store_id"],
        vendorId: json["vendor_id"],
        title: json["title"],
        image: json["image"], // JSON deserialization
        salary: json["salary"],
        description: json["description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "module_id": moduleId,
        "store_id": storeId,
        "vendor_id": vendorId,
        "title": title,
        "image": image, // JSON serialization
        "salary": salary,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "store": store?.toJson(),
        "vendor": vendor?.toJson(),
    };
}

class Store {
    final int? id;
    final String? name;
    final String? phone;
    final String? email;
    final String? logo;
    final String? latitude;
    final String? longitude;
    final String? address;
    final dynamic footerText;
    final int? minimumOrder;
    final dynamic comission;
    final bool? scheduleOrder;
    final int? status;
    final int? vendorId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final bool? freeDelivery;
    final List<int>? rating;
    final String? coverPhoto;
    final bool? delivery;
    final bool? takeAway;
    final bool? itemSection;
    final int? tax;
    final int? zoneId;
    final bool? reviewsSection;
    final bool? active;
    final String? offDay;
    final int? selfDeliverySystem;
    final bool? posSystem;
    final int? minimumShippingCharge;
    final String? deliveryTime;
    final int? veg;
    final int? nonVeg;
    final int? orderCount;
    final int? totalOrder;
    final int? moduleId;
    final int? orderPlaceToScheduleInterval;
    final int? featured;
    final int? perKmShippingCharge;
    final bool? prescriptionOrder;
    final String? slug;
    final String? maximumShippingCharge;
    final bool? cutlery;
    final bool? gstStatus;
    final String? gstCode;
    final List<Translation>? translations;

    Store({
        this.id,
        this.name,
        this.phone,
        this.email,
        this.logo,
        this.latitude,
        this.longitude,
        this.address,
        this.footerText,
        this.minimumOrder,
        this.comission,
        this.scheduleOrder,
        this.status,
        this.vendorId,
        this.createdAt,
        this.updatedAt,
        this.freeDelivery,
        this.rating,
        this.coverPhoto,
        this.delivery,
        this.takeAway,
        this.itemSection,
        this.tax,
        this.zoneId,
        this.reviewsSection,
        this.active,
        this.offDay,
        this.selfDeliverySystem,
        this.posSystem,
        this.minimumShippingCharge,
        this.deliveryTime,
        this.veg,
        this.nonVeg,
        this.orderCount,
        this.totalOrder,
        this.moduleId,
        this.orderPlaceToScheduleInterval,
        this.featured,
        this.perKmShippingCharge,
        this.prescriptionOrder,
        this.slug,
        this.maximumShippingCharge,
        this.cutlery,
        this.gstStatus,
        this.gstCode,
        this.translations,
    });

    factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        logo: json["logo"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
        footerText: json["footer_text"],
        minimumOrder: json["minimum_order"],
        comission: json["comission"],
        scheduleOrder: json["schedule_order"],
        status: json["status"],
        vendorId: json["vendor_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        freeDelivery: json["free_delivery"],
        rating: json["rating"] == null ? [] : List<int>.from(json["rating"]!.map((x) => x)),
        coverPhoto: json["cover_photo"],
        delivery: json["delivery"],
        takeAway: json["take_away"],
        itemSection: json["item_section"],
        tax: json["tax"],
        zoneId: json["zone_id"],
        reviewsSection: json["reviews_section"],
        active: json["active"],
        offDay: json["off_day"],
        selfDeliverySystem: json["self_delivery_system"],
        posSystem: json["pos_system"],
        minimumShippingCharge: json["minimum_shipping_charge"],
        deliveryTime: json["delivery_time"],
        veg: json["veg"],
        nonVeg: json["non_veg"],
        orderCount: json["order_count"],
        totalOrder: json["total_order"],
        moduleId: json["module_id"],
        orderPlaceToScheduleInterval: json["order_place_to_schedule_interval"],
        featured: json["featured"],
        perKmShippingCharge: json["per_km_shipping_charge"],
        prescriptionOrder: json["prescription_order"],
        slug: json["slug"],
        maximumShippingCharge: json["maximum_shipping_charge"],
        cutlery: json["cutlery"],
        gstStatus: json["gst_status"],
        gstCode: json["gst_code"],
        translations: json["translations"] == null ? [] : List<Translation>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "logo": logo,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "footer_text": footerText,
        "minimum_order": minimumOrder,
        "comission": comission,
        "schedule_order": scheduleOrder,
        "status": status,
        "vendor_id": vendorId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "free_delivery": freeDelivery,
        "rating": rating == null ? [] : List<dynamic>.from(rating!.map((x) => x)),
        "cover_photo": coverPhoto,
        "delivery": delivery,
        "take_away": takeAway,
        "item_section": itemSection,
        "tax": tax,
        "zone_id": zoneId,
        "reviews_section": reviewsSection,
        "active": active,
        "off_day": offDay,
        "self_delivery_system": selfDeliverySystem,
        "pos_system": posSystem,
        "minimum_shipping_charge": minimumShippingCharge,
        "delivery_time": deliveryTime,
        "veg": veg,
        "non_veg": nonVeg,
        "order_count": orderCount,
        "total_order": totalOrder,
        "module_id": moduleId,
        "order_place_to_schedule_interval": orderPlaceToScheduleInterval,
        "featured": featured,
        "per_km_shipping_charge": perKmShippingCharge,
        "prescription_order": prescriptionOrder,
        "slug": slug,
        "maximum_shipping_charge": maximumShippingCharge,
        "cutlery": cutlery,
        "gst_status": gstStatus,
        "gst_code": gstCode,
        "translations": translations == null ? [] : List<dynamic>.from(translations!.map((x) => x.toJson())),
    };
}

class Translation {
    final int? id;
    final String? translationableType;
    final int? translationableId;
    final String? locale;
    final String? key;
    final String? value;

    Translation({
        this.id,
        this.translationableType,
        this.translationableId,
        this.locale,
        this.key,
        this.value,
    });

    factory Translation.fromRawJson(String str) => Translation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        translationableType: json["translationable_type"],
        translationableId: json["translationable_id"],
        locale: json["locale"],
        key: json["key"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "translationable_type": translationableType,
        "translationable_id": translationableId,
        "locale": locale,
        "key": key,
        "value": value,
    };
}

class Vendor {
    final int? id;
    final String? fName;
    final String? lName;
    final String? phone;
    final String? email;
    final DateTime? emailVerifiedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic bankName;
    final dynamic branch;
    final dynamic holderName;
    final dynamic accountNo;
    final dynamic image;
    final int? status;
    final dynamic firebaseToken;

    Vendor({
        this.id,
        this.fName,
        this.lName,
        this.phone,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.bankName,
        this.branch,
        this.holderName,
        this.accountNo,
        this.image,
        this.status,
        this.firebaseToken,
    });

    factory Vendor.fromRawJson(String str) => Vendor.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        id: json["id"],
        fName: json["f_name"],
        lName: json["l_name"],
        phone: json["phone"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        bankName: json["bank_name"],
        branch: json["branch"],
        holderName: json["holder_name"],
        accountNo: json["account_no"],
        image: json["image"],
        status: json["status"],
        firebaseToken: json["firebase_token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "l_name": lName,
        "phone": phone,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "bank_name": bankName,
        "branch": branch,
        "holder_name": holderName,
        "account_no": accountNo,
        "image": image,
        "status": status,
        "firebase_token": firebaseToken,
    };
}
