import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_project_main/app.dart';
import 'package:flutter_application_project_main/core/widgets/client/widget_appbar.dart';
import 'package:flutter_application_project_main/core/themes/primary_text.dart';
import 'package:flutter_application_project_main/presentation/screens/client/detailjob_screen.dart';
import 'package:intl/intl.dart';


class CareerDetail extends StatefulWidget {
  final String categoryName;

  const CareerDetail({Key? key, required this.categoryName}) : super(key: key);

  @override
  _CareerDetailState createState() => _CareerDetailState();
}

class _CareerDetailState extends State<CareerDetail> {
  late String categoryId = '';
  late List<dynamic> jobs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategoryId();
  }

  Future<void> fetchCategoryId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    categoryId = prefs.getString('selectedCategoryId') ?? '';
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    if (categoryId.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(Uri.parse(
          'https://backend-jobnest.onrender.com/job/category/$categoryId'));

      if (response.statusCode == 200) {
        final List<dynamic> decodedJobs = jsonDecode(response.body);
        setState(() {
          jobs = decodedJobs;
          isLoading = false;
        });
      } else {
        throw Exception('Không thể tải danh sách công việc');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Lỗi khi tải danh sách công việc: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final inheritedTheme = AppInheritedTheme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        themeMode: inheritedTheme!.themeMode,
        toggleTheme: inheritedTheme.toggleTheme,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600), // Giới hạn chiều rộng
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? const CircularProgressIndicator()
              : jobs.isEmpty
                  ? const Text(
                      'Không có công việc nào phù hợp',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.categoryName,
                          style: PrimaryText.primaryTextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.separated(
                            itemCount: jobs.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final job = jobs[index] as Map<String, dynamic>;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailJobScreen(job: job),
                                    ),
                                  );
                                },
                                child: _JobCardDesign(
                                  logoUrl: job['company']?['logo'] ?? '',
                                  jobTitle: job['title'] ?? 'Không có tiêu đề',
                                  companyName: job['company']?['nameCompany'] ?? 'Không có công ty',
                                  jobDescription: job['description'] ?? 'Không có mô tả',
                                  jobExperience: job['exp'] ?? 'Không yêu cầu',
                                  jobLocation: job['location'] ?? 'Remote',
                                  jobSalary: job['salary'] != null
                                      ? '${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(job['salary'])} VND'
                                      : 'Không rõ',
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

class _JobCardDesign extends StatelessWidget {
  final String logoUrl;
  final String jobTitle;
  final String companyName;
  final String jobDescription;
  final String jobExperience;
  final String jobLocation;
  final String jobSalary;

  const _JobCardDesign({
    Key? key,
    required this.logoUrl,
    required this.jobTitle,
    required this.companyName,
    required this.jobDescription,
    required this.jobExperience,
    required this.jobLocation,
    required this.jobSalary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: logoUrl.isNotEmpty ? NetworkImage(logoUrl) : null,
            backgroundColor: Colors.grey.shade200,
            child: logoUrl.isEmpty
                ? const Icon(Icons.business, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobTitle,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  companyName,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8.0),
                Text(
                  jobDescription,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12.0),
                Wrap(
                  spacing: 6,
                  children: [
                    _infoText(jobExperience),
                    _dotSeparator(),
                    _infoText(jobLocation),
                    _dotSeparator(),
                    _infoText(jobSalary),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dotSeparator() {
    return const Text(" • ", style: TextStyle(color: Colors.black26));
  }

  Widget _infoText(String text) {
    return Text(text, style: const TextStyle(fontSize: 12.0, color: Colors.black54));
  }
}
