class UnbordingContent {
  String image;
  String title;
  String description;

  UnbordingContent(
      {required this.image, required this.title, required this.description});
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Create Your Own Plate',
    image: 'assets/forinter.riv',
    description:
        "Create unforgettable memories with our unique feature to curate your favorite cuisines and food, tailored to your special occasion.",
  ),
  UnbordingContent(
    title: 'Exquisite Catering',
    image: 'assets/secondAnimation.riv',
    description:
        "Experience culinary artistry like never before with our innovative and exquisite cuisine creations",
  ),
  UnbordingContent(
    title: 'Personal Order Executive',
    image: 'assets/thirdAnimation.riv',
    description:
        "Embark on a personalized culinary journey with our dedicated one-to-one customer support, ensuring a seamless and satisfying experience every step of the way.",
  ),
];
