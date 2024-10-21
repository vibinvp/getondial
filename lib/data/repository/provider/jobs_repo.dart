// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:getondial/data/model/response/jobs_model.dart';
// import 'package:http/http.dart' as http;


// class JobProvider with ChangeNotifier {
//   List<Job> _jobs = [];
//   bool _isLoading = false;

//   List<Job> get jobs => _jobs;
//   bool get isLoading => _isLoading;

//   final String _apiUrl = "https://getondial.com/api/v1/jobs/list";

//   Future<void> fetchJobs() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await http.get(Uri.parse(_apiUrl));
//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         JobResponse jobResponse = JobResponse.fromJson(jsonResponse);
//         _jobs = jobResponse.jobs;
//       } else {
//         throw Exception('Failed to load jobs');
//       }
//     } catch (error) {
//       print(error);
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:getondial/data/model/response/jobs_model.dart';
import 'package:http/http.dart' as http;


class JobProvider with ChangeNotifier {
  List<Job> _jobs = [];
  bool _isLoading = false;

  List<Job> get jobs => _jobs;
  bool get isLoading => _isLoading;

  Future<void> fetchJobs() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://getondial.com/api/v1/jobs/list'); // Replace with your API endpoint

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['value'];
        _jobs = data.map((json) => Job.fromJson(json)).toList();
        print("${jobs[0].image}/////////////////////////");
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (error) {
      throw error;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
