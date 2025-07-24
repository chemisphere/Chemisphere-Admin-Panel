import 'package:education_web_admin_panel/features/shop/models/creteUser_model.dart';
import 'package:education_web_admin_panel/utils/constants/enums.dart';
import 'package:get/get.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/admin_model.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  final Rx<Batch> batchPath = Batch.batches.obs;
  RxBool loading = false.obs;
  Rx<AdminModel> admin = AdminModel.empty().obs;
  Rx<List<UserModel>> users = Rx<List<UserModel>>([]);
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final RxList<UserModel> allNeet11Users = <UserModel>[].obs;
  final RxList<UserModel> allJee12Users = <UserModel>[].obs;
  final RxList<UserModel> allNeet12Users = <UserModel>[].obs;
  final RxList<UserModel> allJee11Users = <UserModel>[].obs;
  final RxList<UserModel> allUserImages = <UserModel>[].obs;

  @override
  void onInit(){
    adminDetails();
    getBatchWiseUserData();
    super.onInit();
  }

  /// FETCHES ADMIN DETAILS FROM THE REPOSITORY
  Future<AdminModel> adminDetails() async{
    try{
      loading.value = true;
      final admin = await userRepository.fetchAdminDetails();
      this.admin.value = admin;
      loading.value = false;
      return admin;
    }
    catch(e){
      TLoaders.errorSnackBar(title:'Something went wrong',message:e.toString());
      return AdminModel.empty();
    }
  }


  /// GETTING BATCH WISE USER DATA FROM THE FIREBASE BACKAND
  void getBatchWiseUserData() async {
    try {

      loading.value = true;
      RxList<UserModel> targetBatch = <UserModel>[].obs;

       if (batchPath.value == Batch.NEET11 && allNeet11Users.isEmpty) {
        targetBatch = allNeet11Users;
      } else if (batchPath.value == Batch.NEET12 && allNeet12Users.isEmpty) {
        targetBatch = allNeet12Users;
      } else if (batchPath.value == Batch.JEE11 && allJee11Users.isEmpty) {
        targetBatch = allJee11Users;
      } else if (batchPath.value == Batch.JEE12 && allJee12Users.isEmpty) {
        targetBatch = allJee12Users;
      }

      final batches = await userRepository.fetchBatchUsersFromDatabase(batchPath.value);

      targetBatch.assignAll(batches);
      users.value = batches;
      loading.value = false;

    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
        title: "Oh Snap",
        message: "Unable to fetch Images, Something went wrong. Try again",
      );
    }
  }
}