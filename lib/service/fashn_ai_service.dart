import 'package:flutter/material.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/models/product_model.dart';

import '../utils/stripe_config.dart';

/// Service for Fashn.AI Virtual Try-On API
/// Documentation: https://fashn.ai/api
class FashnAIService {
  static const String _baseUrl = 'https://api.fashn.ai/v1';
  static const String _runEndpoint = '/run';
  static const String _modelName = 'tryon-v1.6';

  static String? _apiKey;

  /// Initialize Fashn.AI service with API key
  /// Get your API key from: https://fashn.ai
  static void initialize({required String apiKey}) {
    _apiKey = apiKey;
    debugPrint('🚀 Fashn.AI Base URL: $_baseUrl');
    if (apiKey.isNotEmpty) {
      debugPrint(
        '🔑 Fashn.AI API Key: ${apiKey.substring(0, 3)}...${apiKey.substring(apiKey.length - 4)}',
      );
    } else {
      debugPrint('⚠️ Fashn.AI API Key is empty!');
    }
    debugPrint('✅ Fashn.AI service initialized');
  }

  /// Check if service is properly configured
  static bool isConfigured() {
    final key = _apiKey ?? StripeConfig.fashnAPIKey;
    return key.isNotEmpty;
  }

  /// Detect garment category from product
  static String detectCategory(Product product) {
    final name = (product.name ?? '').toLowerCase();

    // Detect category based on product name
    if (name.contains('dress') ||
        name.contains('jumpsuit') ||
        name.contains('romper')) {
      return 'one-pieces';
    } else if (name.contains('pant') ||
        name.contains('jean') ||
        name.contains('short') ||
        name.contains('skirt') ||
        name.contains('trouser')) {
      return 'bottoms';
    } else {
      // Default to tops (shirts, t-shirts, jackets, etc.)
      return 'tops';
    }
  }

  /// Get estimated processing time
  static String getEstimatedTime(int quality) {
    if (quality >= 90) {
      return '15-20 seconds';
    } else if (quality >= 70) {
      return '8-12 seconds';
    } else {
      return '5-8 seconds';
    }
  }
}
