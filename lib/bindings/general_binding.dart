import 'package:education_web_admin_panel/features/Files/controller/banner_controller.dart';
import 'package:education_web_admin_panel/features/Files/controller/files_controller.dart';
import 'package:get/get.dart';
import '../features/authentication/controller/user_controller.dart';
import '../utils/helpers/network_manager.dart';



class GeneralBindings extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(()=> NetworkManager(),fenix:true);
    Get.lazyPut(()=> UserController(),fenix:true);
    Get.lazyPut(()=> BannerController(),fenix:true);
    Get.lazyPut(()=> FilesController(),fenix:true);
  }
}