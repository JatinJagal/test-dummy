import 'package:get/get.dart';
import 'package:test_projectt/core/preferences/user_preferences.dart';
import 'package:test_projectt/core/routes/app_page.dart';
import 'package:test_projectt/feature/profile/models/user_profile_model.dart';
import 'package:test_projectt/feature/profile/repository/profile_repository.dart';

class ProfileController extends GetxController {
  final ProfileRepository _repository = ProfileRepository();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rxn<UserProfileModel> userProfile = Rxn<UserProfileModel>();

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _repository.getUserProfile();

    result.fold(
      (error) {
        errorMessage.value = error;
      },
      (data) {
        userProfile.value = data;
      },
    );

    isLoading.value = false;
  }

  Future<void> logout() async {
    await AppSession.clearStorage();
    Get.offAllNamed(Routes.LOGIN);
  }
}
