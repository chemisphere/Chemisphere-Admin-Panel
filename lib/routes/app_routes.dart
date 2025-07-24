import 'package:education_web_admin_panel/routes/routes.dart';
import 'package:education_web_admin_panel/routes/routes_middleware.dart';
import 'package:get/get.dart';
import '../features/Files/screens/Notes.dart';
import '../features/Test/screens/test_screen.dart';
import '../features/authentication/screens/forget_password/forget_password.dart';
import '../features/authentication/screens/login/login.dart';
import '../features/authentication/screens/reset_password/reset_password.dart';
import '../features/shop/screens/UserDashboard/dashboard.dart';
import '../features/shop/screens/UserDashboard/widgets/fetch_user_record.dart';

class TAppRoute{
  static final List<GetPage> pages = [
    GetPage(name:TRoutes.login, page:()=> const LoginScreen()),
    GetPage(name:TRoutes.forgetPassaword, page:()=>const ForgetPasswordScreen(),middlewares:[TRouteMiddleware()]),
    GetPage(name:TRoutes.resetPassword, page:()=> const ResetPasswordScreen(), middlewares:[TRouteMiddleware()]),
    GetPage(name:TRoutes.users, page:()=> const DashboardScreen(), middlewares:[TRouteMiddleware()]),
    GetPage(name:TRoutes.userList, page:()=> const TFetchUserBatchRecord(), middlewares:[TRouteMiddleware()]),
    GetPage(name:TRoutes.files, page:()=> const FilesScreen(), middlewares:[TRouteMiddleware()]),
    GetPage(name:TRoutes.test, page:()=> const TestScreen(), middlewares:[TRouteMiddleware()]),
  ];
}