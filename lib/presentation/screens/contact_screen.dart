import 'package:flutter/material.dart';
import 'package:flutter_application_project_main/core/widgets/client/widget_appbar.dart';
import 'package:flutter_application_project_main/app.dart';
import 'package:flutter_application_project_main/core/themes/primary_text.dart';
import 'package:flutter_application_project_main/core/themes/primary_theme.dart';
import 'package:flutter_application_project_main/core/widgets/client/widget_footer.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final inheritedTheme = AppInheritedTheme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        themeMode: inheritedTheme!.themeMode,
        toggleTheme: inheritedTheme.toggleTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      "Liên hệ",
                      style: PrimaryText.primaryTextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(_nameController, 'HỌ VÀ TÊN', Icons.person),
                  _buildTextField(_emailController, 'EMAIL', Icons.email),
                  _buildTextField(_phoneController, 'SỐ ĐIỆN THOẠI', Icons.phone),
                  _buildCustomQuestionField(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: PrimaryTheme.buttonPrimary,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          minHeight: 45.0,
                        ),
                        child: const Text(
                          "Gửi câu hỏi",
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Những câu hỏi thường xuyên",
                    style: PrimaryText.primaryTextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ..._buildFAQs(),
                  const SizedBox(height: 20),
                  Text(
                    "Contact Info",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildInfoCard(
                          icon: Icons.home,
                          title: 'Vị trí',
                          content: 'Việt Nam',
                        ),
                        _buildInfoCard(
                          icon: Icons.language,
                          title: 'Thời gian làm việc',
                          content: 'Giờ hành chính',
                        ),
                        _buildInfoCard(
                          icon: Icons.email,
                          title: 'Email',
                          content: 'tranngochan2004.vn@gmail.com',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 330,
              child: CustomFooter(),
            ),
          ],
        ),
      ),
    );
  }

  

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscureText = false,
    int maxLines = 1,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        maxLines: maxLines,
        cursorColor: const Color(0xFFFFE0B2),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: label,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black54),
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, color: Colors.blueGrey),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFFFCE86), width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black), 
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomQuestionField() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CÂU HỎI',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFFFCE86), width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.message, color: Colors.blueGrey),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _messageController,
                  maxLines: 4,
                  cursorColor: Color(0xFFFFE0B2),
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Câu hỏi của bạn là gì...',
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  List<Widget> _buildFAQs() {
    final faqs = [
      {
        "question": "Tên công ty của bạn là gì?",
        "answer":
            "Tên công ty của chúng tôi là XYZ, chuyên cung cấp các dịch vụ chất lượng cao trong lĩnh vực công nghệ thông tin và phần mềm.",
      },
      {
        "question": "Cần trả bao nhiêu cho 3 tháng?",
        "answer":
            "Chi phí cho 3 tháng sử dụng dịch vụ của chúng tôi là 3 triệu đồng, bao gồm tất cả các dịch vụ hỗ trợ và bảo trì.",
      },
      {
        "question": "Tôi có cần đăng ký không?",
        "answer":
            "Có, bạn cần đăng ký để sử dụng dịch vụ của chúng tôi. Quá trình đăng ký rất đơn giản và nhanh chóng.",
      },
      {
        "question": "Tôi nên liên hệ ai khi cần hỗ trợ?",
        "answer":
            "Khi cần hỗ trợ, bạn có thể liên hệ với bộ phận hỗ trợ khách hàng qua email support@xyz.com hoặc gọi vào số điện thoại 0123456789.",
      },
    ];

    return faqs.map((faq) {
      return buildQuestionSection(faq['question']!, faq['answer']!);
    }).toList();
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        margin: const EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: Colors.black),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                content,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuestionSection(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            answer,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
