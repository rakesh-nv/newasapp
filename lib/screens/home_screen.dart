import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/news_bloc.dart';
import 'package:newsapp/bloc/news_event.dart';
import 'package:newsapp/bloc/news_state.dart';
import 'package:newsapp/models/news_channel_headlinesModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/screens/profile_screen.dart';
import 'package:newsapp/screens/news_detail_screen.dart';
import 'package:newsapp/screens/video_news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedCategory = '';

  final List<String> _categories = [
    'Headlines',
    'Videos',
    'Categories',
    'Profile'
  ];

  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(const FetchNewsHeadlines());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index != 2 && index != 3) {
        _selectedCategory = '';
        if (index == 0) {
          context.read<NewsBloc>().add(const FetchNewsHeadlines());
        } else if (index == 1) {
          context.read<NewsBloc>().add(const FetchVideoNews());
        }
      }
    });
  }

  void _onCategorySelected(CategoryModel category) {
    setState(() {
      _selectedIndex = 0;
      _selectedCategory = category.apiCategory;
      context.read<NewsBloc>().add(ChangeCategory(category.apiCategory));
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 1
              ? 'Video News'
              : _selectedIndex == 2
                  ? 'News Category'
                  : _selectedIndex == 3
                      ? ''
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
      ),
      backgroundColor: Colors.white,
      body: _getSelectedScreen(),
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
              icon: Icon(Icons.play_circle_outline),
              activeIcon: Icon(Icons.play_circle),
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

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 1:
        return VideoNewsScreen();
      case 2:
        return _buildCategoriesGrid();
      case 3:
        return ProfileScreen();
      default:
        return _buildNewsList();
    }
  }

  Widget _buildNewsList() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return Center(
            child: SpinKitCircle(
              size: 50,
              color: Color(0xFF9D8DDE),
            ),
          );
        } else if (state is NewsError) {
          return Center(
            child: Text('Error: ${state.message}'),
          );
        } else if (state is NewsLoaded) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: _buildHeadlinesList(state.news),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: _buildNewsTilesList(state.news),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _buildHeadlinesList(NewsChannelsHeadlinenModel news) {
    return ListView.builder(
      itemCount: news.articles?.length ?? 0,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var article = news.articles![index];
        return Container(
          width: MediaQuery.of(context).size.width * .8,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(
                    title: article.title ?? '',
                    description: article.description ?? '',
                    imageUrl: article.urlToImage ?? '',
                    author: article.author ?? '',
                    publishedAt: article.publishedAt ?? '',
                    source: article.source?.name ?? '',
                  ),
                ),
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage ?? '',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * .35,
                    width: MediaQuery.of(context).size.width * .8,
                    placeholder: (context, url) => Container(
                      child: spinKit2,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          article.source?.name ?? '',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNewsTilesList(NewsChannelsHeadlinenModel news) {
    return ListView.builder(
      itemCount: news.articles?.length ?? 0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var article = news.articles![index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetailScreen(
                  title: article.title ?? '',
                  description: article.description ?? '',
                  imageUrl: article.urlToImage ?? '',
                  author: article.author ?? '',
                  publishedAt: article.publishedAt ?? '',
                  source: article.source?.name ?? '',
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage ?? '',
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                    placeholder: (context, url) => Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error_outline),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 16, color: Colors.grey),
                          SizedBox(width: 4),
                          Text(
                            article.publishedAt?.substring(0, 10) ?? '',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Text(
                            article.source?.name ?? '',
                            style: TextStyle(
                              color: Color(0xFF9D8DDE),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  final spinKit2 = SpinKitFadingCircle(
    color: Color(0xFF9D8DDE),
    size: 50,
  );

  Widget _buildCategoriesGrid() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 160,
              crossAxisCount: 3,
              childAspectRatio: 1.1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) =>
                _buildCategoryCard(categories[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(CategoryModel category) {
    return GestureDetector(
      onTap: () => _onCategorySelected(category),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(category.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Text(
                  category.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(0, 1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
