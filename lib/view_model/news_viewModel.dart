import 'package:newsapp/models/news_channel_headlinesModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsViewModel {
  final String _apiKey = '923c817b721942a3a636e4eeea255626';
  final String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<NewsChannelsHeadlinenModel> fetchNewsChannelHeadlinesApi({String category = ''}) async {
    try {
      final queryParams = {
        'country': 'us',
        'apiKey': _apiKey,
        if (category.isNotEmpty && category.toLowerCase() != 'headlines') 
          'category': category.toLowerCase(),
      };

      final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParams);
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return NewsChannelsHeadlinenModel.fromJson(data);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}
