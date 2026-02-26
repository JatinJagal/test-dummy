import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_projectt/core/global/constants/app_colors.dart';
import 'package:test_projectt/core/global/style/style.dart';
import 'package:test_projectt/core/utils/common_widgets/custom_button.dart';
import 'package:test_projectt/feature/profile/controller/profile_controller.dart';
import 'package:test_projectt/feature/profile/models/user_profile_model.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Profile", style: txt18W600),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Error: ${controller.errorMessage.value}",
                  style: txt14W600.copyWith(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.getUserProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: const Text(
                    "Retry",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        final user = controller.userProfile.value;
        if (user == null) {
          return const Center(child: Text("No Profile Data"));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildProfileHeader(user),
              const SizedBox(height: 24),
              _buildInfoSection("Contact Information", [
                _buildInfoTile(
                  Icons.email_outlined,
                  "Email",
                  user.email ?? "-",
                ),
                _buildInfoTile(
                  Icons.phone_outlined,
                  "Phone",
                  user.phone ?? "-",
                ),
              ]),
              const SizedBox(height: 16),
              _buildInfoSection("Personal Details", [
                _buildInfoTile(
                  Icons.cake_outlined,
                  "Birth Date",
                  user.birthDate ?? "-",
                ),
                _buildInfoTile(
                  Icons.person_pin_circle_outlined,
                  "Gender",
                  user.gender?.capitalizeFirst ?? "-",
                ),
                _buildInfoTile(
                  Icons.bloodtype_outlined,
                  "Blood Group",
                  user.bloodGroup ?? "-",
                ),
              ]),
              const SizedBox(height: 16),
              _buildInfoSection("Address", [
                _buildInfoTile(
                  Icons.location_on_outlined,
                  "Address",
                  "${user.address?.address}, ${user.address?.city}",
                ),
                _buildInfoTile(
                  Icons.map_outlined,
                  "State",
                  "${user.address?.state}, ${user.address?.postalCode}",
                ),
              ]),
              const SizedBox(height: 16),
              _buildInfoSection("Work & Education", [
                _buildInfoTile(
                  Icons.school_outlined,
                  "University",
                  user.university ?? "-",
                ),
                _buildInfoTile(
                  Icons.work_outline,
                  "Company",
                  "${user.company?.title} at ${user.company?.name}",
                ),
              ]),
              const SizedBox(height: 32),
              CustomButton(
                text: "Logout",
                onPressed: controller.logout,
                backgroundColor: AppColors.danger,
                foregroundColor: Colors.white,
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileHeader(UserProfileModel user) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: user.image != null
                ? NetworkImage(user.image!)
                : null,
            child: user.image == null
                ? const Icon(
                    Icons.person,
                    size: 50,
                    color: AppColors.textSecondary,
                  )
                : null,
          ),
        ),
        const SizedBox(height: 16),
        Text("${user.username} ${user.lastName}", style: txt20W700),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: txt16W600.copyWith(color: AppColors.primary)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Styles.txt12W400.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: txt14W600.copyWith(color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
