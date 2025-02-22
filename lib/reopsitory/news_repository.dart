import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/news_channel_headlinesModel.dart';

class NewsRepository {
  Future<NewsChannelsHeadlinenModel> fetchNewsChannelHeadlinesApi() async {
    try {
      String url =
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=923c817b721942a3a636e4eeea255626';
      final response = await http.get(Uri.parse(url));
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return NewsChannelsHeadlinenModel.fromJson(body);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

}
