import 'package:flutter/material.dart';
import 'package:getondial/data/model/response/jobs_model.dart';
import 'package:getondial/data/repository/provider/jobs_repo.dart';
import 'package:getondial/view/screens/jobs/job_inner_screen.dart';
import 'package:provider/provider.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  @override
  void initState() {
    super.initState();
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    jobProvider.fetchJobs();
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs"),
        //backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: jobProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: jobProvider.jobs.length,
              itemBuilder: (BuildContext context, int index) {
                Job job = jobProvider.jobs[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Jobinnerscreen(
                          jobId: job.id,
                        );
                      }));
                    },
                    child: Container(
                      width: double.infinity,
                      height: height * 0.18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).cardColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Row(
                          children: [
                            // Job image section
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: job.image != null &&
                                          job.image.toString().isNotEmpty
                                      ? Image.network(
                                          job.image.toString(),
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(Icons.store, size: 50);
                                          },
                                        )
                                      : Icon(Icons.store, size: 50),
                                )
                              ],
                            ),
                            SizedBox(width: 15),
                            // Job details section
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Job title
                                  Text(
                                    job.title,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1, // Avoid text overflow
                                    style: TextStyle(
                                      fontSize: 22, // Adjusted size
                                      fontWeight: FontWeight.bold,

                                      fontFamily: 'Roboto', // Standard font
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  // Store name
                                  Text(
                                    job.store?.name ?? "Unknown Store",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  // Salary
                                  Text(
                                    "₹${job.salary}/M",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  // Address
                                  Expanded(
                                    child: Text(
                                      job.store?.address.toString() ??
                                          "Unknown address",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
