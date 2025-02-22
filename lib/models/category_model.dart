class CategoryModel {
  final String name;
  final String imageUrl;
  final String apiCategory;

  CategoryModel({
    required this.name, 
    required this.imageUrl, 
    required this.apiCategory
  });
}

final List<CategoryModel> categories = [
  CategoryModel(
    name: 'Tech',
    imageUrl: 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=800',
    apiCategory: 'technology'
  ),
  CategoryModel(
    name: 'Economy',
    imageUrl: 'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?w=800',
    apiCategory: 'business'
  ),
  CategoryModel(
    name: 'Sport',
    imageUrl: 'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800',
    apiCategory: 'sports'
  ),
  CategoryModel(
    name: 'Health',
    imageUrl: 'https://images.unsplash.com/photo-1498837167922-ddd27525d352?w=800',
    apiCategory: 'health'
  ),
  CategoryModel(
    name: 'Fun',
    imageUrl: 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=800',
    apiCategory: 'entertainment'
  ),
  CategoryModel(
    name: 'Science',
    imageUrl: 'https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800',
    apiCategory: 'science'
  ),
  CategoryModel(
    name: 'General',
    imageUrl: 'https://images.unsplash.com/photo-1495020689067-958852a7765e?w=800',
    apiCategory: 'general'
  ),
  CategoryModel(
    name: 'Music',
    imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800',
    apiCategory: 'entertainment'
  ),
  CategoryModel(
    name: 'Art',
    imageUrl: 'https://images.unsplash.com/photo-1547891654-e66ed7ebb968?w=800',
    apiCategory: 'entertainment'
  ),
];
