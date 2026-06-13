import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/utils/validators.dart';
import 'package:explore_egypt/core/widgets/custom_app_bar_background.dart';
import 'package:explore_egypt/features/users/model/entities/user_model.dart';
import 'package:explore_egypt/features/users/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:explore_egypt/features/users/presentation/views/widget/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel userModel;
  EditProfilePage({super.key, required this.userModel});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController bioController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.userModel.name;
    bioController.text = widget.userModel.bio ?? 'No Bio';

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final double appBarHeight =
        AppBar().preferredSize.height + MediaQuery.of(context).padding.top;
    final double expandedHeight = screenHeight * .23;

    final double scrollOffset = _scrollController.hasClients
        ? _scrollController.offset
        : 0;
    final double gradientHeight = (expandedHeight - scrollOffset).clamp(
      appBarHeight,
      expandedHeight,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.kBGColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leadingWidth: 70,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: AppColors.kWhite),
        ),
        titleSpacing: 0,
        title: Text(
          'EditProfile',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontFamily: GoogleFonts.notoSerif().fontFamily,
            color: AppColors.kWhite,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final state = context.read<ProfileCubit>().state;

                String? imagePath;
                if (state is ProfileLoaded) {
                  imagePath = state.pickedImage ?? state.user.imageURL;
                }
                context.read<ProfileCubit>().updateUserData(
                  userName: nameController.text,
                  bio: bioController.text,
                  image: imagePath,
                );
              }
            },
            icon: Icon(Icons.check, color: AppColors.kWhite),
          ),
        ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(height: gradientHeight, child: AppBarBackground()),
          ),
          Positioned.fill(
            top: appBarHeight + 20,
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileUpdatedSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile updated successfully')),
                  );
                  Navigator.pop(context);
                }
                if (state is ProfileUpdateFaild) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                }
              },
              builder: (context, state) {
                if (state is ProfileUpdateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                String? imagePath;

                if (state is ProfileLoaded) {
                  imagePath = state.pickedImage ?? state.user.imageURL;
                }
                return UpdateUserDataWidget(
                  scrollController: _scrollController,
                  imagePath: imagePath,
                  formKey: formKey,
                  nameController: nameController,
                  bioController: bioController,
                  email: widget.userModel.email,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UpdateUserDataWidget extends StatelessWidget {
  const UpdateUserDataWidget({
    super.key,
    required ScrollController scrollController,
    required this.imagePath,
    required this.formKey,
    required this.nameController,
    required this.bioController,
    required this.email,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final String? imagePath;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController bioController;
  final String email;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
        spacing: 16,
        children: [
          UpdateUserPhoto(
            imagePath: imagePath,
            onPressed: () async {
              await context.read<ProfileCubit>().pickImage();
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: BoxBorder.all(color: Color(0xffEF8B43), width: .5),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  EditPageFields(
                    isEnabled: true,
                    hintText: 'Name',
                    leading: SvgPicture.asset(
                      AppConstants.profileIcon,
                      colorFilter: ColorFilter.mode(
                        AppColors.kPrimaryVariant,
                        BlendMode.srcIn,
                      ),
                    ),
                    controller: nameController,
                  ),
                  EditPageFields(
                    initialValue: email,
                    isEnabled: false,
                    hintText: 'Email',
                    leading: Icon(
                      Icons.email_outlined,
                      color: AppColors.kPrimaryVariant,
                    ),
                  ),
                  EditPageFields(
                    isEnabled: true,
                    hintText: 'Bio',
                    leading: Icon(
                      Icons.chat_outlined,
                      color: AppColors.kPrimaryVariant,
                    ),
                    controller: bioController,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UpdateUserPhoto extends StatelessWidget {
  const UpdateUserPhoto({
    super.key,
    required this.imagePath,
    required this.onPressed,
  });

  final String? imagePath;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        UserPhoto(imageURL: imagePath),
        IconButton(
          onPressed: onPressed,
          icon: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.kPrimaryVariant,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.kWhite, width: 1.5),
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              color: AppColors.kWhite,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class EditPageFields extends StatelessWidget {
  const EditPageFields({
    super.key,
    required this.hintText,
    required this.isEnabled,
    this.initialValue,
    this.leading,
    this.controller,
  });

  final String? initialValue;
  final String hintText;
  final bool isEnabled;
  final Widget? leading;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(top: 16, bottom: 20),
      dense: true,
      isThreeLine: hintText == 'Bio' ? true : false,
      titleTextStyle: TextStyle(height: .7, color: Colors.black),
      leading: leading,
      title: Text(hintText),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: TextFormField(
          initialValue: initialValue,
          controller: controller,
          //style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            fillColor: Color(0xfff9f9f9),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0x4D9E9E9E)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0x4D9E9E9E)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0x4D9E9E9E)),
            ),
            contentPadding: EdgeInsets.only(
              left: 12,
              right: 12,
              top: 2,
              bottom: 2,
            ),
            enabled: isEnabled,
          ),
          maxLines: hintText == 'Bio' ? 3 : 1,
          cursorColor: AppColors.kPrimaryColor,
          validator: (value) {
            return Validators.generalValidator(value);
          },
        ),
      ),
    );
  }
}
