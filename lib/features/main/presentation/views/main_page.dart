import 'package:explore_egypt/core/utils/constants.dart';
import 'package:explore_egypt/features/chat/presentation/views/chat_page.dart';
import 'package:explore_egypt/features/home/presentation/views/home_page.dart';
import 'package:explore_egypt/features/main/presentation/views/widgets/custom_navigation_destination.dart';
import 'package:explore_egypt/features/profile/presentation/views/profile_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  final List<Widget> _pages = const [HomePage(), ChatPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateTextStyle.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppConstants.kPrimaryColor,
                  )
                : const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppConstants.kBlack,
                  ),
          ),
        ),
        child: NavigationBar(
          destinations: [
            CustomNavigationDestination(label: 'Home', icon: AppConstants.homeIcon,),
            CustomNavigationDestination(label: 'Chatbot', icon: AppConstants.chatIcon,),
            CustomNavigationDestination(label: 'Profile', icon: AppConstants.profileIcon,),
          ],
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          
          backgroundColor: Colors.white,
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStateColor.transparent,
          
        ),
      ),
    );
  }
}


