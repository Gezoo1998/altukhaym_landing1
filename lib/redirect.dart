import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:async';

class WhatsAppRedirectPage extends StatefulWidget {
  const WhatsAppRedirectPage({Key? key}) : super(key: key);

  @override
  State<WhatsAppRedirectPage> createState() => _WhatsAppRedirectPageState();
}

class _WhatsAppRedirectPageState extends State<WhatsAppRedirectPage> {
  String? _phoneNumber;
  bool _isRedirecting = false;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _initializeRedirect();
  }

  void _initializeRedirect() {
    // Parse phone parameter from URL
    final uri = Uri.parse(html.window.location.href);
    final phoneParam = uri.queryParameters['phone'];
    
    if (phoneParam != null && phoneParam.isNotEmpty) {
      // Clean and format phone number
      String cleanPhone = phoneParam.replaceAll(RegExp(r'[^0-9+]'), '');
      
      // Ensure it starts with + for international format
      if (!cleanPhone.startsWith('+')) {
        cleanPhone = '+$cleanPhone';
      }
      
      // Validate Saudi phone number format
      if (RegExp(r'^\+966[0-9]{9}$').hasMatch(cleanPhone)) {
        _phoneNumber = cleanPhone;
        _startRedirect();
      } else {
        setState(() {
          _message = 'رقم الهاتف غير صحيح';
        });
      }
    } else {
      setState(() {
        _message = 'No phone number provided';
      });
    }
  }

  void _startRedirect() {
    setState(() {
      _isRedirecting = true;
      _message = 'جاري تحويلك إلى الواتساب...';
    });

    // Wait 2 seconds then redirect
    Timer(const Duration(seconds: 2), () {
      final whatsappUrl = 'https://api.whatsapp.com/send?phone=$_phoneNumber';
      html.window.location.href = whatsappUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isRedirecting) ...
              [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
                ),
                const SizedBox(height: 30),
              ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFFFD700)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  _message,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (_phoneNumber != null && _isRedirecting) ...
              [
                const SizedBox(height: 20),
                Text(
                  'رقم الهاتف: $_phoneNumber',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
          ],
        ),
      ),
    );
  }
}

class WhatsAppRedirectApp extends StatelessWidget {
  const WhatsAppRedirectApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Redirect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      home: const WhatsAppRedirectPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  runApp(const WhatsAppRedirectApp());
}