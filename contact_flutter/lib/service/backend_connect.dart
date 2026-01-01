import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '/models/contact_model.dart';
import 'config.dart';

class BackendConnect extends ChangeNotifier {
  String _token = '';
  List<ContactModel> _contacts = [];
  bool _isLoading = false;
  bool _isConnected = true;

  String newContactName = '';
  String newContactPhone = '';

  List<ContactModel> get contacts => _contacts;
  bool get isLoading => _isLoading;
  bool get isConnected => _isConnected;

  BackendConnect() {
    _loadToken();
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _isConnected = connectivityResult != ConnectivityResult.none;
    notifyListeners();
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _isConnected = result != ConnectivityResult.none;
    notifyListeners();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    if (_token.isNotEmpty) {
      await fetchContacts();
    }
    notifyListeners();
  }

  Future<void> _saveToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    notifyListeners();
  }

  Future<void> _clearToken() async {
    _token = '';
    _contacts.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }

  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      if (_token.isNotEmpty) 'Authorization': 'Bearer $_token',
    };
  }

  // Auth methods
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(Config.loginEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _saveToken(data['access_token']);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String email, String name, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(Config.registerEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'name': name,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // After registration, login automatically
        await login(email, password);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'Registration failed');
      }
    } catch (e) {
      throw Exception('Registration failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _clearToken();
  }

  // Contact methods
  Future<void> fetchContacts() async {
    if (_token.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('${Config.contactsEndpoint}/'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _contacts = data.map((json) => ContactModel.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        await _clearToken();
        throw Exception('Session expired. Please login again.');
      }
    } catch (e) {
      throw Exception('Failed to fetch contacts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createContact(String name, String phoneNumber) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('${Config.contactsEndpoint}/'),
        headers: _getHeaders(),
        body: jsonEncode({
          'name': name,
          'phone_number': phoneNumber,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final newContact = ContactModel.fromJson(data);
        _contacts.add(newContact);

        // Reset form fields
        newContactName = '';
        newContactPhone = '';
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'Failed to create contact');
      }
    } catch (e) {
      throw Exception('Failed to create contact: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateContact(
      ContactModel contact, String name, String phoneNumber) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse('${Config.contactsEndpoint}/${contact.id}'),
        headers: _getHeaders(),
        body: jsonEncode({
          'name': name,
          'phone_number': phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final updatedContact = ContactModel.fromJson(data);

        final index = _contacts.indexWhere((c) => c.id == contact.id);
        if (index != -1) {
          _contacts[index] = updatedContact;
        }
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'Failed to update contact');
      }
    } catch (e) {
      throw Exception('Failed to update contact: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteContact(int contactId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.delete(
        Uri.parse('${Config.contactsEndpoint}/$contactId'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 204) {
        _contacts.removeWhere((contact) => contact.id == contactId);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'Failed to delete contact');
      }
    } catch (e) {
      throw Exception('Failed to delete contact: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
