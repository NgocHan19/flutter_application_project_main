import 'package:flutter/material.dart';
import 'package:flutter_application_project_main/presentation/screens/client/home_screen.dart';
import 'package:flutter_application_project_main/hello.dart';
import 'package:flutter_application_project_main/presentation/screens/jobpath_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/register_jobseeker.dart';
import 'package:flutter_application_project_main/presentation/screens/login_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/client/menu_career.dart';
import 'package:flutter_application_project_main/presentation/screens/client/company_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/signup_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/account_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/contact_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/client/blogdetail_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/client/profile_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/forgetpass_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/resetpass_screen.dart';
import 'package:flutter_application_project_main/presentation/modal/filter_modal.dart';
import 'package:flutter_application_project_main/presentation/screens/admin/home_a.dart';
import 'package:flutter_application_project_main/presentation/screens/post_job/home_p.dart';
import 'package:flutter_application_project_main/presentation/screens/admin/job_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/confirm_screen.dart';
import 'package:flutter_application_project_main/presentation/screens/companyregister_screen.dart';
import 'route_names.dart';

class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    RouteNames.hello: (context) => const Hello(),
    RouteNames.home: (context) => const HomeScreen(),
    RouteNames.login: (context) => const LoginScreen(),
    RouteNames.signup: (context) => SignUpScreen(),
    RouteNames.menucareer: (context) => const MenuCareer(),
    RouteNames.company: (context) => const CompanyScreen(),
    RouteNames.accout: (context) => AccoutScreen(),
    RouteNames.contact: (context) => const ContactScreen(),
    RouteNames.blogdetail: (context) => const BlogDetail(),
    RouteNames.profile: (context) => ProfileScreen(),
    RouteNames.forgetpassscreen: (context) => const ForgetPassScreen(),
    RouteNames.resetpassscreen: (context) => const ResetPassScreen(),
    RouteNames.filter_modal: (context) => const FilterModal(),
    RouteNames.home_a: (context) => AdminDashboard(),
    RouteNames.home_p: (context) => EmployerHomePage(),
    RouteNames.job_manager: (context) => JobListScreen(),
    RouteNames.jobpath: (context) => JobPathScreen(),
    RouteNames.jobseeker: (context) => JobSeekerScreen(),
    RouteNames.confirm: (context) => ConfirmScreen(),
    RouteNames.companyregister: (context) => CompanyRegistrationScreen(),
  };
}
