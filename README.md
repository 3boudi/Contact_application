# 📱 Contact Manager App

A secure, full-stack mobile contact management application built with Flutter and FastAPI. Manage your contacts with ease and make real phone calls directly from the app.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

## 🎯 Overview

Contact Manager is a modern mobile application that provides a secure way to store and manage your personal contacts. With JWT authentication, real-time search, and one-tap calling functionality, it offers a seamless experience for contact management.

## ✨ Features

- **🔐 User Authentication** - Secure registration and login with JWT tokens
- **📇 Contact Management** - Full CRUD operations (Create, Read, Update, Delete)
- **📞 One-Tap Calling** - Initiate real phone calls directly from the app
- **🔍 Real-Time Search** - Instantly filter contacts as you type
- **🌐 Offline Detection** - Connection monitoring with user feedback
- **💾 Persistent Storage** - Secure token storage for seamless sessions
- **🎨 Modern UI** - Clean Material Design 3 interface with dark/light mode
- **🔄 Pull-to-Refresh** - Update your contact list with a simple gesture

## 🛠️ Tech Stack

### Backend
- **FastAPI** - High-performance Python web framework
- **SQLModel** - Modern SQL databases with Python objects
- **PostgreSQL** - Powerful open-source database
- **JWT** - Secure authentication tokens
- **Argon2** - Industry-standard password hashing
- **ngrok** - Secure HTTP tunneling for mobile testing

### Frontend
- **Flutter** - Google's UI toolkit for cross-platform apps
- **Dart** - Client-optimized programming language
- **Provider** - State management solution
- **Material Design 3** - Modern design system
- **http** - API communication
- **url_launcher** - Phone calling integration

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- Python 3.8+
- Flutter SDK 3.0+
- PostgreSQL (or Neon account)
- ngrok account (free tier works)
- Android Studio / Xcode (for mobile development)

## 🚀 Getting Started

### Backend Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/contact-manager.git
   cd contact-manager/backend
   ```

2. **Create virtual environment**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install fastapi sqlmodel uvicorn python-jose passlib argon2-cffi pydantic psycopg2-binary
   ```

4. **Configure database**
   - Create a PostgreSQL database or use Neon
   - Update the `DATABASE_URL` in your `.env` file:
     ```
     DATABASE_URL=postgresql://user:password@localhost/contactmanager
     SECRET_KEY=your-secret-key-here
     ```

5. **Run the server**
   ```bash
   uvicorn main:app --reload
   ```

6. **Setup ngrok tunnel**
   ```bash
   ngrok http 8000
   ```
   Copy the HTTPS forwarding URL (e.g., `https://abc123.ngrok.io`)

### Frontend Setup

1. **Navigate to frontend directory**
   ```bash
   cd ../frontend
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Update API configuration**
   - Open `lib/config/config.dart`
   - Replace the base URL with your ngrok URL:
     ```dart
     static const String baseUrl = 'https://your-ngrok-url.ngrok.io';
     ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Supported Platforms

| Platform | Status | Notes |
|----------|--------|-------|
| Android | ✅ Full Support | Tested on Android 8.0+ |
| iOS | ✅ Full Support | Requires iOS 12.0+ |
| Web | ⚠️ Partial | CORS configuration needed |
| Desktop | ⚠️ Limited | Can compile but not optimized |

## 🔐 Security Features

- **JWT Authentication** - Secure token-based authentication
- **Password Hashing** - Argon2 algorithm for password security
- **HTTPS** - Encrypted communication via ngrok
- **Input Validation** - Client and server-side validation
- **SQL Injection Protection** - Parameterized queries with SQLModel

## 📦 Project Structure

```
contact-manager/
├── backend/
│   ├── main.py              # FastAPI application
│   ├── models.py            # Database models
│   ├── auth.py              # Authentication logic
│   ├── requirements.txt     # Python dependencies
│   └── .env                 # Environment variables
│
└── frontend/
    ├── lib/
    │   ├── config/          # Configuration files
    │   ├── models/          # Data models
    │   ├── services/        # API services
    │   ├── screens/         # UI screens
    │   └── widgets/         # Reusable widgets
    ├── pubspec.yaml         # Flutter dependencies
    └── android/             # Android configuration
```

## 🎨 Screenshots

| Login Screen | Contact List | Add Contact |
|-------------|--------------|-------------|
| ![Login](screenshots/login.png) | ![List](screenshots/list.png) | ![Add](screenshots/add.png) |

## 🔄 API Endpoints

### Authentication
- `POST /register` - Create new user account
- `POST /login` - Authenticate user

### Contacts
- `GET /contacts` - Retrieve all contacts
- `POST /contacts` - Create new contact
- `PUT /contacts/{id}` - Update existing contact
- `DELETE /contacts/{id}` - Delete contact

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**HALITIM Amin**
- 📧 Email: halitim.amim@univ-guelma.dz
- 🔗 GitHub: [@yourusername](https://github.com/yourusername)

Project Link: [https://github.com/yourusername/contact-manager](https://github.com/yourusername/contact-manager)

## 🙏 Acknowledgments

- [Flutter Documentation](https://flutter.dev/docs)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Material Design 3](https://m3.material.io/)
- [ngrok](https://ngrok.com/)

## 📧 Support

For support, email halitim.amim@univ-guelma.dz or open an issue in the GitHub repository.

---

⭐ Star this repo if you find it helpful!
