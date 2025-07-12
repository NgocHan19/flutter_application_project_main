import 'package:flutter/material.dart';
import 'package:flutter_application_project_main/core/widgets/admin/widget_appbar.dart';
import 'package:flutter_application_project_main/core/widgets/admin/widget_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_project_main/app.dart';
import 'package:flutter_application_project_main/presentation/screens/signup_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/account_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/contact_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/admin/category_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/admin/benefit_page.dart';
import 'package:flutter_application_project_main/presentation/screens/admin/profile_screen.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int usersCount = 0;
  int companiesCount = 0;
  int jobsCount = 0;
  int applicationsCount = 0;

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  Future<void> fetchStats() async {
    try {
      final responses = await Future.wait([
        http.get(Uri.parse('https://backend-jobnest.onrender.com/user/count')),
        http.get(
            Uri.parse('https://backend-jobnest.onrender.com/company/count')),
        http.get(Uri.parse('https://backend-jobnest.onrender.com/job/count')),
        http.get(Uri.parse(
            'https://backend-jobnest.onrender.com/application/count')),
      ]);

      if (responses.every((response) => response.statusCode == 200)) {
        setState(() {
          usersCount = json.decode(responses[0].body)['totalUsers'] ?? 0;
          companiesCount = json.decode(responses[1].body)['count'] ?? 0;
          jobsCount = json.decode(responses[2].body)['count'] ?? 0;
          applicationsCount = json.decode(responses[3].body)['count'] ?? 0;
        });
      } else {
        throw Exception('Failed to load stats');
      }
    } catch (e) {
      print('Error fetching stats: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final inheritedTheme = AppInheritedTheme.of(context);

    return Scaffold(
      appBar: AdminAppBar(
        themeMode: inheritedTheme!.themeMode,
        toggleTheme: inheritedTheme.toggleTheme,
      ),
      drawer: AdminDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 40),
            _buildStatisticsGrid(),
            SizedBox(height: 20),
            _buildCategoryTitle("Danh mục"),
            SizedBox(height: 10),
            _buildCategoriesGrid(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

Widget _buildHeader() {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: Color(0xFFFFA726),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(45),
            bottomRight: Radius.circular(45),
          ),
        ),
        padding: EdgeInsets.only(left: 35, top: 10, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Xin chào !", style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(height: 5),
            Text(
              "Yuki",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      Positioned(
        left: 35,
        right: 35,
        bottom: -20, // tạo hiệu ứng nổi
        child: _buildSearchBar(),
      )
    ],
  );
}


  // 🔍 Thanh tìm kiếm
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Tìm kiếm công việc ...",
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }

  // 📊 Thống kê số liệu
  Widget _buildStatisticsGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
        children: [
          _buildStatCard(usersCount.toString(), "Tài khoản", Color(0xFF64B5F6)),
          _buildStatCard(jobsCount.toString(), "Ngành nghề", Color(0xFF81C784)),
          _buildStatCard(companiesCount.toString(), "Công ty", Color(0xFFFFD54F)), 
          _buildStatCard(applicationsCount.toString(), "Đơn ứng tuyển", Color(0xFFBA68C8)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String number, String title, Color color) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }

  // 🏷 Tiêu đề danh mục
  Widget _buildCategoryTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  // 🏷 Thiết kế danh mục
  Widget _buildCategoriesGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          _buildMenuItem(Icons.person_add, 'Đăng ký', SignUpScreen()),
          _buildMenuItem(Icons.contact_mail, 'Liên hệ', ContactScreen()),
          _buildMenuItem(Icons.account_circle, 'Tài khoản', AccoutScreen()),
          _buildMenuItem(Icons.category, 'Danh mục', CategoryScreen()),
          _buildMenuItem(Icons.volunteer_activism, 'Phúc lợi', BenefitPage()),
          _buildMenuItem(Icons.person, 'Hồ sơ', ProfilePage()),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 4)) // Bóng đổ nhẹ
          ],
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              radius: 25,
              child: Icon(icon, color: Color(0xFFFFA726), size: 28),
            ),
            SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
