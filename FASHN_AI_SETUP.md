# Fashn.AI Virtual Try-On Integration Guide

## 🎨 Overview

This project uses **Fashn.AI** - a professional AI-powered virtual try-on API that generates photorealistic images of clothing on people. It's a REST API service that provides industry-leading results for fashion e-commerce.

## ✨ Features

- **Photorealistic Results**: State-of-the-art AI generates highly realistic try-on images
- **Fast Processing**: 5-17 seconds depending on quality settings
- **REST API**: Simple HTTP integration, works with any programming language
- **Category Support**: Tops, bottoms, and one-pieces
- **Quality Control**: Adjustable quality settings (0-100)
- **No SDK Required**: Pure REST API - lightweight and flexible

## 🚀 Quick Start

### 1. Get API Key

1. Visit [https://fashn.ai](https://fashn.ai)
2. Sign up for an account
3. Navigate to API Dashboard
4. Copy your API key

### 2. Add to Environment

Add to your `.env` file:

```env
FASHN_API_KEY=your_api_key_here
```

### 3. Initialize in App

In your `main.dart`:

```dart
import 'package:travel_clothing_club_flutter/utils/stripe_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables and configuration (Required for Fashn.AI)
  await StripeConfig.initialize();

  runApp(MyApp());
}
```

## 📡 API Details

### Endpoint

```
POST https://api.fashn.ai/v1/run
```

### Request Format

```json
{
  "model_name": "tryon-v1.6",
  "inputs": {
    "model_image": "data:image/jpeg;base64,...",
    "garment_image": "https://...",
    "category": "tops"
  },
  "config": {
    "quality": 85,
    "num_samples": 1
  }
}
```

### Response Format

```json
{
  "id": "prediction_id",
  "status": "processing",
  "output": ["https://generated-image-url.png"]
}
```

## 🎯 Usage

### Basic Try-On (File based)

```dart
final result = await FashnAIService.generateTryOn(
  modelImage: userPhotoFile,
  productImageUrl: 'https://example.com/product.jpg',
  category: 'tops',
  quality: 85,
);
```

### Try-On with URLs (Matching Provided Curl)

```dart
final result = await FashnAIService.tryOnWithUrls(
  modelImageUrl: 'http://example.com/path/to/model.jpg',
  garmentImageUrl: 'http://example.com/path/to/garment.jpg',
  category: 'tops',
  quality: 85,
);
```

### Category Detection

The service automatically detects garment categories:

```dart
final category = FashnAIService.detectCategory(product);
// Returns: 'tops', 'bottoms', or 'one-pieces'
```

### Quality Settings

| Quality | Processing Time | Use Case                        |
| ------- | --------------- | ------------------------------- |
| 60-70   | 5-8 seconds     | Quick previews                  |
| 75-85   | 8-12 seconds    | **Recommended**                 |
| 90-100  | 15-20 seconds   | High-quality publishable images |

## 🔄 How It Works

1. **User uploads photo** → Converted to base64
2. **Product image URL** → Sent to API
3. **Category detection** → Automatically determined
4. **API processing** → Async with polling
5. **Result download** → Saved to temp directory
6. **Display** → Shown in before/after preview

## 📊 API Response Flow

```
Request Sent
    ↓
Status: "starting"
    ↓
Status: "processing" (poll every 2s)
    ↓
Status: "succeeded"
    ↓
Download generated image
    ↓
Display result
```

## 🎨 Supported Categories

### Tops

- T-shirts
- Shirts
- Blouses
- Jackets
- Sweaters
- Hoodies

### Bottoms

- Pants
- Jeans
- Shorts
- Skirts
- Trousers

### One-Pieces

- Dresses
- Jumpsuits
- Rompers

## 💡 Best Practices

### Image Requirements

**Model Image (User Photo):**

- Clear, well-lit photo
- Person facing camera
- Full body or upper body visible
- Recommended: 1080x1920px or similar
- Format: JPEG/PNG

**Product Image:**

- High-quality product photo
- Flat-lay, ghost mannequin, or on-model
- Clear view of garment
- Good lighting
- Format: JPEG/PNG via URL

### Optimization Tips

1. **Compress images** before upload (already done at 80% quality)
2. **Use CDN URLs** for product images for faster processing
3. **Cache results** to avoid re-processing same combinations
4. **Handle errors gracefully** with fallback to custom compositor

## 🐛 Troubleshooting

### "Fashn.AI not configured"

- Check that `FASHN_API_KEY` is in your `.env` file
- Ensure `FashnAIService.initialize()` is called in `main.dart`
- Verify API key is valid

### "API request failed"

- Check your API key is correct
- Verify you have credits remaining
- Check internet connection
- Review API dashboard for errors

### "Processing timeout"

- Increase `maxAttempts` in `_pollForResult()`
- Check API status at [fashn.ai](https://fashn.ai)
- Try with lower quality setting

### Fallback Behavior

If Fashn.AI is not configured or fails, the app automatically uses the custom image compositor as fallback.

## 📈 Pricing

Visit [https://fashn.ai/pricing](https://fashn.ai/pricing) for current pricing.

Typical plans include:

- **Free Tier**: Limited credits for testing
- **Pay-as-you-go**: Per-image pricing
- **Enterprise**: Custom pricing for high volume

## 🔗 Resources

- **Official Website**: [https://fashn.ai](https://fashn.ai)
- **API Documentation**: [https://fashn.ai/api](https://fashn.ai/api)
- **API Playground**: Interactive testing environment
- **Support**: Contact via website

## 🎯 Implementation Details

### Service Location

`lib/service/fashn_ai_service.dart`

### Controller Integration

`lib/app_modules/1_traveler/home/controllers/ai_try_on_controller.dart`

### Key Methods

- `initialize()` - Setup API key
- `generateTryOn()` - Main try-on function
- `detectCategory()` - Auto-detect garment type
- `isConfigured()` - Check if ready to use

## 🔐 Security

- **API Key**: Stored in `.env` (never commit to git)
- **HTTPS Only**: All API calls use secure connections
- **No Data Storage**: Images processed in real-time, not stored by Fashn.AI

## 📝 Notes

- Processing is **asynchronous** - results take 5-20 seconds
- **Progress tracking** shows real-time status
- **Automatic fallback** to custom compositor if API unavailable
- **Category auto-detection** based on product name

---

**Ready to use!** Just add your API key to `.env` and the feature will automatically activate. 🚀
