import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:getondial/data/model/response/job_details.dart';
import 'package:http/http.dart' as http;

class JobRequirementRepository with ChangeNotifier {
  JobRequirement? _jobRequirementDetail;
  bool _isLoading = false;

  JobRequirement? get jobRequirementDetail => _jobRequirementDetail;
  bool get isLoading => _isLoading;

Future<void> fetchJobDetail(int id) async {
  _isLoading = true;
  notifyListeners();

  final url = 'https://getondial.com/api/v1/jobs/detailslist/$id';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      
      if (data != null) {
        _jobRequirementDetail = JobRequirement.fromJson(data);
        // print("Salary: ${_jobRequirementDetail!.salary}");
      } else {
        throw Exception('Data is null');
      }
    } else {
      throw Exception('Failed to load job detail');
    }
  } catch (error) {
    print("**********************${error}");
    throw error;
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}


}
