import 'package:education_web_admin_panel/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../data/repositories/authentication/authentication_repositories.dart';

class TRouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route){
    return AuthenticationRepository.instance.isAuthenticated ? null : const RouteSettings(name:TRoutes.login);
  }
}