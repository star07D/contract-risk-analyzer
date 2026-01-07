# 📱 Contract Risk Analyzer

Contract Risk Analyzer is a Flutter application designed to manage recurring contracts
such as subscriptions, internet plans, insurance, and service agreements.  
The app helps users **store contracts locally**, **calculate yearly costs**, and
**assess risk levels** based on renewal cycles, notice periods, and contract duration.

This project is built with **production-grade architecture**, focusing on
scalability, maintainability, and real-world Flutter development practices.

---

## 🚀 Features

- Add and manage recurring contracts
- Automatic yearly cost calculation
- Risk classification (Low / Medium / High)
- Long-press delete with database synchronization
- Local persistence using SQLite
- Smooth loading & error handling
- Reactive UI updates using Riverpod

---

## 🧠 Architecture Overview

This project follows **Clean Architecture**, ensuring a clear separation of concerns
and long-term maintainability.

lib/
├── core/ # Shared constants and utilities
├── domain/ # Business logic (entities, repository contracts, services)
├── data/ # Data layer (Drift database, repository implementations)
│ ├── database/
│ └── repositories/
├── presentation/ # UI layer (screens, widgets, Riverpod providers)
└── main.dart

yaml
Copy code

### Why Clean Architecture?
- Business logic is independent of UI and database
- Easy to test and extend
- Matches real-world enterprise Flutter projects
- Highly valued by recruiters and engineering teams

---

## 🧪 Technical Highlights

- Flutter & Dart
- Clean Architecture (Domain / Data / Presentation)
- Riverpod for state management
- Drift (SQLite) for type-safe local database
- Repository pattern
- Async UI handling with `AsyncValue`
- Automatic UI refresh via provider invalidation
- Strong error handling and null safety

---

## 🗄️ Data Persistence

The app uses **Drift (SQLite)** for local storage:
- Type-safe queries
- Compile-time validation
- Reliable offline access
- Structured database schema

All contracts are stored locally and reflected instantly in the UI.

---

## 🛠️ Tools & Technologies

- Flutter
- Dart
- Riverpod
- Drift (SQLite)
- Android Studio
- Git & GitHub

---

## 📌 Future Enhancements

- Edit existing contracts
- Contract analytics & charts
- Cloud sync (Firebase)
- Contract reminders & notifications
- Multi-language support

---

## 👨‍💻 About the Developer

**Dhruv**  
MSc IT Project Management  
Mobile Application Developer (Flutter & Android)

Focused on building scalable, maintainable mobile applications using modern
Flutter architecture patterns and industry-standard tools.

---

## 📄 License

This project is for educational and portfolio purposes.
