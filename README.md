# 🧶 Travel Clothing Club (TCC)

### _Revolutionizing the Way Travelers Dress for the World_

[![Flutter Version](https://img.shields.io/badge/Flutter-%5E3.9.2-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![GetX](https://img.shields.io/badge/State_Management-GetX-purple?style=for-the-badge)](https://pub.dev/packages/get)
[![Stripe](https://img.shields.io/badge/Payments-Stripe-6762a6?style=for-the-badge&logo=stripe)](https://stripe.com)
[![Firebase](https://img.shields.io/badge/Backend-Firebase-ffca28?style=for-the-badge&logo=firebase)](https://firebase.google.com)

**Travel Clothing Club** is a premium ecosystem that bridges the gap between style and convenience for global travelers. Built with a focus on high-end aesthetics and seamless functionality, TCC allows users to browse catalog-grade apparel, experiment with high-fidelity AI try-on experiences, and manage rentals with local rider-assisted deliveries.

---

## 🌟 Visionary Features

### ✨ The AI Fitting Room

Experience the future of fashion. Our **AI Try-On** module utilizes machine learning to visualize apparel on user-provided photos, reducing sizing uncertainty and enhancing trust.

- **Instant Visualization**: Real-time mask application of garments.
- **Smart Sizing**: Automatic recommendations based on biometric data (Chest/Height).

### 🛍️ Traveler's Boutique

- **Premium Discovery**: Multi-faceted filtering (Brand, Color, Material, Fit).
- **Dynamic Logistics**: Real-time rental availability and automated price calculation for varying durations.
- **Secure Transactions**: Fully integrated **Stripe** payment gateway with deposit handling and late-fee calculations.

### � Logistics Engine (Rider App)

- **Live Dispatch**: Real-time push notification system for delivery assignments.
- **Earnings Analytics**: Visual dashboards for performance tracking.
- **Route Optimization**: Integrated location services for rapid door-to-door fulfillment.

---

## 🛠 Engineering & Tech Stack

| Domain           | Technolgies                                                      |
| :--------------- | :--------------------------------------------------------------- |
| **Framework**    | Flutter (SDK ^3.9.2), Dart                                       |
| **Architecture** | GetX State Management, Dependency Injection & Navigation         |
| **Networking**   | Dio (Interceptors, Base Models, Error Handling)                  |
| **Persistence**  | SQLite (sqflite), Shared Preferences                             |
| **Real-time**    | Pusher Channels (Chat & Status Tracking)                         |
| **Security**     | Firebase Auth (Google, Apple, Phone), .env Encryption            |
| **Theming**      | Dynamic Color Systems (AppColors), Google Fonts (Roboto/Poppins) |

---

## � Architecture Overview

The codebase is engineered with a **Modular Feature-Based Architecture**, ensuring high scalability and ease of testing.

```text
lib/
├── app_modules/          # Feature domains (Auth, Traveler, Rider, etc.)
│   ├── 1_traveler/       # Core consumer features
│   │   ├── home/         # Product discovery & AI Try-On
│   │   ├── cart/         # Rental management
│   │   └── orders/       # Order history & status
│   └── 2_rider/          # Delivery professional features
├── data/                 # Shared models, UserData, & Preferences
├── routes/               # GetX Route configuration
├── service/              # API Clients & Firebase Services
└── utils/                # Design tokens, Mixins, & Low-level widgets
```

---

## 🏁 Installation & Setup

### Prerequisites

- Flutter SDK (v3.9.2+)
- Android Studio / VS Code
- Firebase Project setup

### Local Configuration

1. **Clone the Project**

   ```bash
   git clone https://github.com/asim1cva/travel_clothing_club_flutter.git
   ```

2. **Environment Assets**
   Create a `.env` file in the root and populate your keys:

   ```env
   STRIPE_PUBLISHABLE_KEY=pk_test_...
   PUSHER_APP_KEY=...
   API_BASE_URL=https://api.tcc.com/v1/
   ```

3. **Initialize Dependencies**

   ```bash
   flutter pub get
   ```

4. **Launch Application**
   ```bash
   flutter run
   ```

---

## � Security & Optimization

- **Proguard/R8**: Obfuscated builds for production releases.
- **Null-Safety**: 100% Sound Null-Safety for crash-free execution.
- **Image Optimization**: Custom `AppCacheImageView` utilizing `cached_network_image` for minimal data usage and high FPS.

---

## 🤝 Contributing

We welcome developers from all over the world to contribute.

1. Fork the Project.
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`).
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the Branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

---

## 📧 Contact & Support

- **Support**: support@travelclothingclub.com
- **Website**: [www.travelclothingclub.com](https://www.travelclothingclub.com)

---

_Developed with ❤️ by the TCC Engineering Team._
