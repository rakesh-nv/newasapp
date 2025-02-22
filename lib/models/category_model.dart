class CategoryModel {
  final String name;
  final String imageUrl;

  CategoryModel({required this.name, required this.imageUrl});
}

final List<CategoryModel> categories = [
  CategoryModel(
    name: 'Tech',
    imageUrl: 'assets/images/tech.jpg',
  ),
  CategoryModel(
    name: 'Economy',
    imageUrl: 'assets/images/economy.jpg',
  ),
  CategoryModel(
    name: 'Sport',
    imageUrl: 'assets/images/sport.jpg',
  ),
  CategoryModel(
    name: 'Health',
    imageUrl: 'assets/images/health.jpg',
  ),
  CategoryModel(
    name: 'Fun',
    imageUrl: 'assets/images/fun.jpg',
  ),
  CategoryModel(
    name: 'Science',
    imageUrl: 'assets/images/science.jpg',
  ),
  CategoryModel(
    name: 'General',
    imageUrl: 'assets/images/general.jpg',
  ),
  CategoryModel(
    name: 'Music',
    imageUrl: 'assets/images/music.jpg',
  ),
  CategoryModel(
    name: 'Art',
    imageUrl: 'assets/images/art.jpg',
  ),
];
