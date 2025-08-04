import 'package:flutter/material.dart';
import 'package:flutter_application_project_main/core/themes/primary_theme.dart';
import 'package:flutter_application_project_main/core/themes/primary_text.dart';

class CustomFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 18, 17, 17),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      constraints: const BoxConstraints(minHeight: 500),
      child: SafeArea(
      top: false,
        child: SingleChildScrollView(
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAboutSection(),
                const SizedBox(width: 16),
                _buildListSection(
                  title: 'Menu',
                  items: ['Giới thiệu', 'Dịch vụ', 'Tin tức', 'Nghề nghiệp'],
                ),
                const SizedBox(width: 16),
                _buildListSection(
                  title: 'Danh mục',
                  items: ['Full Time', 'Freelance', 'Temporary', 'Internship'],
                ),
              ],
            ),
            const Divider(color: Colors.white38, height: 32),
            const Text(
              'Copyright © 2024 All Rights Reserved | This application is made with love by Yuki',
              style: TextStyle(color: Colors.white54, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Về chúng tôi',
            style: PrimaryText.primaryTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Chúng tôi là nền tảng kết nối nhà tuyển dụng và người tìm việc, mang đến giải pháp tuyển dụng nhanh, hiệu quả và đáng tin cậy. Với sứ mệnh giúp hàng nghìn người tìm được công việc mơ ước, chúng tôi luôn nỗ lực cải tiến để nâng cao trải nghiệm người dùng.',
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.justify, 
            softWrap: true,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(80, 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: PrimaryTheme.buttonPrimary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                constraints: const BoxConstraints(minHeight: 40, minWidth: 80),
                alignment: Alignment.center,
                child: const Text(
                  'Đọc ở đây',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListSection({required String title, required List<String> items}) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: PrimaryText.primaryTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  item,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              )),
        ],
      ),
    );
  }
}
