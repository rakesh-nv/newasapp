class CategoryModel {
  final String name;
  final String imageUrl;
  final String apiCategory;  // This will be used for the API call

  CategoryModel({
    required this.name, 
    required this.imageUrl, 
    required this.apiCategory
  });
}

final List<CategoryModel> categories = [
  CategoryModel(
    name: 'Tech',
    imageUrl: 'assets/images/tech.jpg',
    apiCategory: 'technology'
  ),
  CategoryModel(
    name: 'Economy',
    imageUrl: 'assets/images/economy.jpg',
    apiCategory: 'business'
  ),
  CategoryModel(
    name: 'Sport',
    imageUrl: 'assets/images/sport.jpg',
    apiCategory: 'sports'
  ),
  CategoryModel(
    name: 'Health',
    imageUrl: 'assets/images/health.jpg',
    apiCategory: 'health'
  ),
  CategoryModel(
    name: 'Fun',
    imageUrl: 'assets/images/fun.jpg',
    apiCategory: 'entertainment'
  ),
  CategoryModel(
    name: 'Science',
    imageUrl: 'assets/images/science.jpg',
    apiCategory: 'science'
  ),
  CategoryModel(
    name: 'General',
    imageUrl: 'assets/images/general.jpg',
    apiCategory: 'general'
  ),
  CategoryModel(
    name: 'Music',
    imageUrl: 'assets/images/music.jpg',
    apiCategory: 'entertainment'
  ),
  CategoryModel(
    name: 'Art',
    imageUrl: 'assets/images/art.jpg',
    apiCategory: 'entertainment'
  ),
];
