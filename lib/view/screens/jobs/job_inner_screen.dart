import 'package:flutter/material.dart';
import 'package:getondial/data/repository/provider/job_details.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Jobinnerscreen extends StatefulWidget {
  final int jobId;

  const Jobinnerscreen({Key? key, required this.jobId}) : super(key: key);

  @override
  State<Jobinnerscreen> createState() => _JobinnerscreenState();
}

class _JobinnerscreenState extends State<Jobinnerscreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<JobRequirementRepository>(context, listen: false)
        .fetchJobDetail(widget.jobId);
  }

  // Function to launch phone call
  void _callEmployer(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to make the call')),
      );
    }
  }

  // Function to launch email client
  void _emailEmployer(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Job Inquiry', // Optional subject
        'body': 'I am interested in the job details.' // Optional body
      },
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to send email')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Job Details'),
       // backgroundColor:  Theme.of(context).primaryColor,
      ),
      body: Consumer<JobRequirementRepository>(
        builder: (ctx, repository, _) {
          if (repository.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final job = repository.jobRequirementDetail;
          if (job == null) {
            return Center(child: Text('Job not found.'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(40),
                       ),
                    height: 200,
                    width: double.infinity,
                   
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            job.value?[0].title.toString() ?? "Unknown name",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(height: 9),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: job.value![0].image != null &&
                                      job.value![0].image.toString().isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        job.value![0].image.toString(),
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Icons.store, size: 50);
                                        },
                                      ),
                                    )
                                  : Icon(Icons.store, size: 50),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.home_work_outlined),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          job.value![0].store?.name
                                                  .toString() ??
                                              "Unknown name",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 9),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          job.value?[0].store?.address
                                                  .toString() ??
                                              "Unknown address",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.ellipsis),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 9),
                                  Row(
                                    children: [
                                      Icon(Icons.paid),
                                      SizedBox(width: 5),
                                      Text(
                                        job.value?[0].salary.toString() ??
                                            "0000",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text("Description",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    job.value?[0].description.toString() ?? "description",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                   
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: Consumer<JobRequirementRepository>(
        builder: (context, repository, _) {
          final employerPhone =
              repository.jobRequirementDetail?.value?[0].store?.phone ?? '';
          final employerEmail =
              repository.jobRequirementDetail?.value?[0].store?.email ?? '';

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  if (employerPhone.isNotEmpty) {
                    _callEmployer(employerPhone);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No phone number available')),
                    );
                  }
                },
                child: Icon(Icons.call),
                backgroundColor: Colors.green,
              ),
              SizedBox(height: 10),
              // Spacing between the buttons
              FloatingActionButton(
                onPressed: () {
                  if (employerEmail.isNotEmpty) {
                    _emailEmployer(employerEmail);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No email available')),
                    );
                  }
                },
                child: Icon(Icons.email),
                backgroundColor: Colors.blue,
              ),
            ],
          );
        },
      ),
    );
  }
}
