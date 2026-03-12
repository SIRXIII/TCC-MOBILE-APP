# Travel Clothing Club (TCC) - Mobile App

Mobile app for travelers and riders on the Travel Clothing Club platform. TCC enables travelers to browse, try on, and rent premium apparel with rider-assisted local delivery.

## Key Features

- **AI Virtual Try-On**: Powered by Fashn.AI, users can upload a photo and see how garments look on them before renting.
- **Product Browsing & Filtering**: Discover catalog-grade apparel with filters for brand, color, material, fit, and more.
- **Real-Time Chat**: Firebase-backed messaging between travelers, riders, and support, including order-specific conversations.
- **Order Tracking**: End-to-end order lifecycle from placement through delivery and return, with live status updates.
- **Rider Delivery Management**: Riders receive delivery assignments, track earnings, and manage pickups/drop-offs.
- **Stripe Payments**: Secure payment processing with Stripe, including deposits and rental fee calculations.
- **Push Notifications**: Firebase Cloud Messaging for delivery updates, chat messages, and order status changes.
- **Location Services**: Geo-based rental availability using device GPS and geocoding.

## Tech Stack

| Layer              | Technology                                                |
| :----------------- | :-------------------------------------------------------- |
| **Framework**      | Flutter (SDK ^3.9.2), Dart                                |
| **State Mgmt**     | GetX (dependency injection, routing, reactive state)      |
| **Backend**        | Firebase (Auth, Firestore, Cloud Messaging)               |
| **Payments**       | Stripe (flutter_stripe)                                   |
| **Real-Time**      | Pusher Channels (chat & status), Firebase Firestore       |
| **AI Try-On**      | Fashn.AI API (virtual garment fitting)                    |
| **Networking**     | Dio, http                                                 |
| **Local Storage**  | SQLite (sqflite), SharedPreferences                       |
| **Auth**           | Firebase Auth (Google Sign-In, Apple Sign-In, email)      |

## Project Structure

```
lib/
├── app_modules/
│   ├── 1_traveler/       # Traveler features (browse, cart, orders, chat, refunds)
│   ├── 2_rider/          # Rider features (deliveries, earnings, support)
│   ├── auth/             # Authentication (login, signup, profile setup)
│   ├── chat/             # Order-based chat (Firebase Firestore)
│   ├── location/         # Location permission and geocoding
│   ├── on_boarding/      # Onboarding screens
│   ├── pusher/           # Pusher-based real-time chat
│   ├── select_account_type/  # Traveler vs Rider selection
│   ├── splash/           # Splash screen and initialization
│   └── feedback/         # Order feedback and ratings
├── data/                 # Models, user data, preferences, API constants
├── repositories/         # Data repositories
├── routes/               # GetX route definitions
├── service/              # API clients (Stripe, Fashn.AI, FCM, Pusher, location)
└── stripe/               # Payment controller
```

## Setup & Run

### Prerequisites

- Flutter SDK 3.9.2 or later
- Android Studio or VS Code with Flutter plugin
- A Firebase project (with Auth, Firestore, and Cloud Messaging enabled)
- Stripe account (for payment processing)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/SIRXIII/TCC-MOBILE-APP.git
   cd TCC-MOBILE-APP
   ```

2. **Create a `.env` file** in the project root with your keys:

   ```env
   STRIPE_PUBLISHABLE_KEY=pk_test_...
   STRIPE_SECRET_KEY=sk_test_...
   FASHN_API_KEY=fa-...
   PUSHER_APP_KEY=...
   API_BASE_URL=https://your-api-domain.com/api
   ```

3. **Install dependencies**

   ```bash
   flutter pub get
   ```

4. **Configure Firebase**

   - Place your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) in the appropriate directories.
   - Run `flutterfire configure` if needed.

5. **Run the app**

   ```bash
   flutter run
   ```

## Related Repositories

- [TCC-Admin-BACK](https://github.com/SIRXIII/TCC-Admin-BACK) - Backend API (Laravel)
- [TCC-Admin-FRONT](https://github.com/SIRXIII/TCC-Admin-FRONT) - Admin dashboard (Next.js)
