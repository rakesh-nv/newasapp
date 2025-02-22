import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:newsapp/models/news_channel_headlinesModel.dart';
import 'package:newsapp/view_model/news_viewModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsapp/models/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  int _selectedIndex = 0;
  String _selectedCategory = '';

  final List<String> _categories = [
    'Headlines',
    'Recent',
    'Categories',
    'Profile'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index != 2) {
        // If not on categories page
        _selectedCategory = ''; // Reset selected category
      }
    });
  }

  void _onCategorySelected(CategoryModel category) {
    setState(() {
      _selectedIndex = 0; // Switch to home page
      _selectedCategory = category.apiCategory; // Set selected category
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 2
              ? 'News Category'
              : _selectedCategory.isNotEmpty
                  ? _selectedCategory.toUpperCase()
                  : 'Headlines',
          style: TextStyle(
              color: Color(0xFF9D8DDE),
              fontSize: 24,
              fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.grey),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: _selectedIndex == 2 ? _buildCategoryGrid() : _buildNewsList(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              activeIcon: Icon(Icons.access_time_filled),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              activeIcon: Icon(Icons.grid_view),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF9D8DDE),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return _buildCategoryCard(categories[index]);
      },
    );
  }

  Widget _buildCategoryCard(CategoryModel category) {
    return GestureDetector(
      onTap: () => _onCategorySelected(category),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(category.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(8),
          child: Text(
            category.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: double.infinity,
          child: FutureBuilder<NewsChannelsHeadlinenModel>(
            future: newsViewModel.fetchNewsChannelHeadlinesApi(
              category: _selectedCategory,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitCircle(
                    size: 50,
                    color: Color(0xFF9D8DDE),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData ||
                  snapshot.data?.articles?.isEmpty == true) {
                return Center(
                  child: Text('No news available'),
                );
              }
              
              // Featured article
              final featuredArticle = snapshot.data!.articles![0];
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(featuredArticle.urlToImage ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          featuredArticle.title ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        // News list
        FutureBuilder<NewsChannelsHeadlinenModel>(
          future: newsViewModel.fetchNewsChannelHeadlinesApi(
            category: _selectedCategory,
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data?.articles?.isEmpty == true) {
              return SizedBox.shrink();
            }

            return Padding(
              padding: EdgeInsets.all(16),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.articles!.length - 1,
                itemBuilder: (context, index) {
                  final article = snapshot.data!.articles![index + 1];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      onTap: () {
                        // TODO: Navigate to article detail
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: article.urlToImage ?? '',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[200],
                                child: Center(
                                  child: SpinKitCircle(
                                    color: Color(0xFF9D8DDE),
                                    size: 24,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[200],
                                child: Icon(Icons.error, color: Colors.grey),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF9D8DDE).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    _selectedCategory.isEmpty ? 'SPORTS' : _selectedCategory.toUpperCase(),
                                    style: TextStyle(
                                      color: Color(0xFF9D8DDE),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  article.title ?? '',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                    height: 1.3,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  article.publishedAt?.split('T')[0] ?? '',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
