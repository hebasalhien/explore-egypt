import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/help_center/model/entities/faq_model.dart';
import 'package:explore_egypt/features/help_center/presentation/cubit/help_center_cubit.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/custom_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCenterView extends StatefulWidget {
  const HelpCenterView({super.key});

  @override
  State<HelpCenterView> createState() => _HelpCenterViewState();
}

class _HelpCenterViewState extends State<HelpCenterView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => HelpCenterCubit()..loadFaqs(),
      child: Scaffold(
        appBar: HelpCenterAppBar(),
        body: BlocBuilder<HelpCenterCubit, HelpCenterState>(
          builder: (context, state) {
            if (state is HelpCenterLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is HelpCenterError) {
              return Center(child: Text(state.error));
            }
            if (state is HelpCenterLoaded) {
              return FaqWidget(
                screenWidth: screenWidth,
                faqs: state.faq,
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class FaqWidget extends StatelessWidget {
  const FaqWidget({
    super.key,
    required this.screenWidth,
    required this.faqs,
  });

  final double screenWidth;
  final List<FaqModel> faqs;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              'Popular Topics',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontFamily: GoogleFonts.notoSerif().fontFamily,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                return ExpandableContainer(question: faqs[index].question, answer: faqs[index].answer);
              },
            ),

            Text(
              'Contact us!',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontFamily: GoogleFonts.notoSerif().fontFamily,
              ),
            ),
            TextField(
              maxLines: 6,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0x4DEF8B43)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0x4DEF8B43)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0x4DEF8B43)),
                ),
                hintText: ' message..',
              ),
            ),
            CustomGradientButton(
              screenWidth: screenWidth,
              title: "Submit",
              topToBottom: false,
              hasIcon: false,
            ),
          ],
        ),
      ),
    );
  }
}



class ExpandableContainer extends StatelessWidget {
  const ExpandableContainer({
    super.key,
    required this.question,
    required this.answer,
  });
  final String question;
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 8),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Color(0x4DEF8B43)),
        ),
        collapsedIconColor: AppColors.kPrimaryVariant,
        iconColor: AppColors.kPrimaryVariant,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Color(0x4DEF8B43)),
        ),
        title: Text(
          question,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontFamily: GoogleFonts.notoSansArabic().fontFamily,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              answer,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class HelpCenterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HelpCenterAppBar({super.key});
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * .11,
      title: Text(
        'Help Center',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: AppColors.kWhite),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.vertical(
          bottom: Radius.circular(40),
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.vertical(
            bottom: Radius.circular(40),
          ),
          gradient: LinearGradient(
            colors: [AppColors.kSecondaryVariant, AppColors.kPrimaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
