# 📱 Contract Risk Analyzer

A Flutter application to manage recurring contracts (internet, subscriptions, insurance, etc.) and analyze their financial risk based on duration, renewal cycles, and notice periods.

Built with **Clean Architecture**, **Riverpod**, and **Drift (SQLite)**.

---

## 🚀 Features

- Add contracts with cost, category, duration & renewal details
- View yearly cost breakdown
- Risk tagging (LOW / MEDIUM / HIGH)
- Long-press delete with instant UI refresh
- Offline-first (local SQLite database)

---

## 🧠 Architecture

This project follows **Clean Architecture** principles:

lib/
├── domain/ # Business logic (entities, repositories, services)
├── data/ # Database & repository implementations (Drift)
├── presentation/ # UI & state management (Riverpod)
├── core/ # Shared utilities & constants

yaml
Copy code

### Why this architecture?
- Clear separation of concerns
- Testable business logic
- Scalable for real production apps
- Matches industry best practices

---

## 🛠 Tech Stack

- **Flutter**
- **Dart**
- **Riverpod** – State management
- **Drift (SQLite)** – Local database
- **Build Runner** – Code generation
- **Git** – Version control

---

## 📸 Screenshots
_(Coming soon)_

---

## 🧪 Key Technical Highlights

- Async state handling with `AsyncValue`
- Repository pattern (domain → data separation)
- Auto-refresh using provider invalidation
- Proper DB schema management with Drift
- Error-safe UI states (loading / empty / error)

---

## 📦 Setup & Run

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run

👨‍💻 Author
Dhruv
MSc IT Project Management | Mobile Application Developer
Focused on Flutter, Android, and scalable app architecture
