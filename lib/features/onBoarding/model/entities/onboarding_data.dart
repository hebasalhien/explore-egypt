class OnboardingData {
  final String title;
  final String description;
  final String imageUrl;

  const OnboardingData({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

const List<OnboardingData> onboardingPages = [
  OnboardingData(
    title: "Discover\nEgypt's Wonders",
    description: "Explore ancient history, breathtaking landscapes, and unforgettable experiences across Egypt.",
    imageUrl: "assets/images/onBoarding_1.png", 
  ),
  OnboardingData(
    title: "Build Your\nPerfect Plan",
    description: "Create day-by-day itineraries, organize your stops, and manage your adventure with ease.",
    imageUrl: "assets/images/onBoarding_2.png",
  ),
  OnboardingData(
    title: "Travel Smarter\nwith AI",
    description: "Get personalized recommendations, chat assistance, and smart guidance throughout your journey.",
    imageUrl: "assets/images/onBoarding_3.png",
  ),
];