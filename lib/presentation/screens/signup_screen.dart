import 'package:flutter/material.dart';
import 'package:flutter_application_project_main/data/repositories/auth_repository.dart';
import 'package:flutter_application_project_main/app.dart';
import 'package:flutter_application_project_main/core/themes/primary_theme.dart';
import 'package:flutter_application_project_main/core/widgets/client/widget_appbar.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  final AuthRepository authRepository = AuthRepository();

  Future<void> registerUser() async {
    if (passwordController.text != confirmPasswordController.text) {
      _showErrorDialog("Mật khẩu và xác nhận mật khẩu không khớp!");
      return;
    }

    setState(() => isLoading = true);
    try {
      final user = await authRepository.registerUser(
        emailController.text,
        passwordController.text,
        nameController.text,
      );
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/login');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng ký thành công!')),
        );
      }
    } catch (error) {
      _showErrorDialog('Đăng ký thất bại: $error');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Lỗi'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

Widget _buildTextField(
  TextEditingController controller,
  String label,
  IconData icon, {
  bool obscureText = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Color(0xFFFFE0B2), 
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.blueGrey), 
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFFE0B2), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final inheritedTheme = AppInheritedTheme.of(context);
    return Scaffold(
     appBar: CustomAppBar(
        themeMode: inheritedTheme!.themeMode,
        toggleTheme: inheritedTheme.toggleTheme,
      ),
      body: Center(child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Center(
              child: Image.asset(
                'assets/images/logo.png', 
                height: 200,  
                width: 250,  
              ),
            ),
            Center(
            child: Text(
              'Tạo tài khoản',
              style: TextStyle(
                fontSize: 38 ,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFA726), 
              ),
            ),
          ),
            const SizedBox(height: 10), 
            const SizedBox(height: 10),
            _buildTextField(nameController, 'Tên của bạn', Icons.person_outline),
            const SizedBox(height: 10),
            _buildTextField(emailController, 'Email của bạn', Icons.email_outlined),
            const SizedBox(height: 10),
            _buildTextField(passwordController, 'Mật khẩu', Icons.lock_outline, obscureText: true),
            const SizedBox(height: 10),
            _buildTextField(confirmPasswordController, 'Xác nhận mật khẩu', Icons.lock_outline, obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (nameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          confirmPasswordController.text.isNotEmpty) {
                        registerUser();
                      } else {
                        _showErrorDialog('Vui lòng nhập đầy đủ thông tin');
                      }
                    },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(80, 32),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Ink(
                decoration: BoxDecoration(
                   gradient: PrimaryTheme.buttonPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  constraints: const BoxConstraints(minHeight: 40, minWidth: 80),
                  alignment: Alignment.center,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Đăng ký',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Đã có tài khoản?  ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        color: Color(0xFFFFA726),
                        fontSize: 12,
                      ),
                    ),
                ),
              ],
            ),
          ],
        ),
      ),),
    );
  }
}
