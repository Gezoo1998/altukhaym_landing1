import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;
import 'dart:async';
import 'dart:math' as math;

void main() {
  runApp(const LuxuryRealEstateApp());
}

class LuxuryRealEstateApp extends StatelessWidget {
  const LuxuryRealEstateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الطخيم العالمية للعقارات',
      theme: ThemeData(primarySwatch: Colors.amber, fontFamily: 'Arial'),
      home: const LuxuryLandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LuxuryLandingPage extends StatefulWidget {
  const LuxuryLandingPage({super.key});

  @override
  State<LuxuryLandingPage> createState() => _LuxuryLandingPageState();
}

class _LuxuryLandingPageState extends State<LuxuryLandingPage>
    with TickerProviderStateMixin {
  bool _showPopup = false;
  String _popupMessage = '';
  bool _showBackToTop = false;
  bool _isArabic = true; // Language state - true for Arabic, false for English
  late AnimationController _animationController;
  late AnimationController _particleController;
  late Animation<double> _fadeAnimation;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _particleController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >= 400) {
      if (!_showBackToTop) {
        setState(() {
          _showBackToTop = true;
        });
      }
    } else {
      if (_showBackToTop) {
        setState(() {
          _showBackToTop = false;
        });
      }
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _toggleLanguage() {
    setState(() {
      _isArabic = !_isArabic;
    });
  }

  Map<String, String> _getTexts() {
    if (_isArabic) {
      return {
        'companyName': 'الطخيم العالمية للعقارات',
        'slogan': 'نحو مستقبل عقاري آمن',
        'villa_title': 'فيلات فاخرة',
        'villa_desc': 'فيلات حديثة بأرقى التصاميم',
        'apartment_title': 'شقق سكنية',
        'apartment_desc': 'شقق عصرية بمواصفات عالية',
        'commercial_title': 'أبراج تجارية',
        'commercial_desc': 'مكاتب ومحلات في أفضل المواقع',
        'building_title': 'عمارات و اراضي',
        'building_desc': 'عمارات سكنية وأراضي استثمارية مميزة',
        'whatsapp_title': 'تواصل مع مستشار العقارات',
        'consultant1': 'أ. مقرن - مستشار عقاري أول',
        'consultant2': 'أ. عبدالله الطخيم - مستشار الفيلات الفاخرة',
        'consultant3': 'علي العطاس - مستشار الأبراج التجارية',
        'contact_phone_title': 'اتصل بنا',
        'contact_phone_desc': 'متاح 24/7',
        'contact_email_title': 'راسلنا',
        'contact_email_desc': 'رد سريع خلال ساعة',
        'contact_location_title': 'زورنا',
        'contact_location_value':
            'الرياض، طريق الملك فهد تقاطع التحليه برج فردان الدور الثامن مكتب رقم 802-801.',
        'contact_location_desc': 'المملكة العربية السعودية',
      };
    } else {
      return {
        'companyName': 'Al-Takheem Global Real Estate',
        'slogan': 'Towards a Secure Real Estate Future',
        'villa_title': 'Luxury Villas',
        'villa_desc': 'Modern villas with finest designs',
        'apartment_title': 'Residential Apartments',
        'apartment_desc': 'Contemporary apartments with high specifications',
        'commercial_title': 'Commercial Towers',
        'commercial_desc': 'Offices and shops in prime locations',
        'building_title': 'Buildings & Lands',
        'building_desc': 'Residential buildings and premium investment lands',
        'whatsapp_title': 'Contact Real Estate Consultant',
        'consultant1': 'Ahmed Al-Malki - Senior Real Estate Consultant',
        'consultant2': 'Sarah Al-Otaibi - Luxury Villas Consultant',
        'consultant3': 'Mohammed Al-Shehri - Commercial Towers Consultant',
        'contact_phone_title': 'Call Us',
        'contact_phone_desc': 'Available 24/7',
        'contact_email_title': 'Email Us',
        'contact_email_desc': 'Quick response within an hour',
        'contact_location_title': 'Visit Us',
        'contact_location_value': 'Riyadh, King Fahd District',
        'contact_location_desc': 'Kingdom of Saudi Arabia',
      };
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _particleController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _showContactPopup(String message, String whatsappUrl) {
    setState(() {
      _showPopup = true;
      _popupMessage = message;
    });

    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _showPopup = false;
      });
      html.window.open(whatsappUrl, '_blank');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Language Radio Toggle Button
          Positioned(
            top: 20,
            right: 20,
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xFFFFD700), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: const Color(0xFFFFD700).withOpacity(0.4),
                      blurRadius: 25,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Arabic Option
                    GestureDetector(
                      onTap: () {
                        if (!_isArabic) _toggleLanguage();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: _isArabic
                              ? const Color(0xFFFFD700)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: _isArabic
                              ? [
                                  BoxShadow(
                                    color: const Color(
                                      0xFFFFD700,
                                    ).withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _isArabic
                                      ? const Color(0xFF2C1810)
                                      : Colors.grey.shade400,
                                  width: 2,
                                ),
                              ),
                              child: _isArabic
                                  ? Container(
                                      margin: const EdgeInsets.all(3),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF2C1810),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'عربي',
                              style: TextStyle(
                                color: _isArabic
                                    ? const Color(0xFF2C1810)
                                    : Colors.grey.shade600,
                                fontWeight: _isArabic
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // English Option
                    GestureDetector(
                      onTap: () {
                        if (_isArabic) _toggleLanguage();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: !_isArabic
                              ? const Color(0xFFFFD700)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: !_isArabic
                              ? [
                                  BoxShadow(
                                    color: const Color(
                                      0xFFFFD700,
                                    ).withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: !_isArabic
                                      ? const Color(0xFF2C1810)
                                      : Colors.grey.shade400,
                                  width: 2,
                                ),
                              ),
                              child: !_isArabic
                                  ? Container(
                                      margin: const EdgeInsets.all(3),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF2C1810),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'English',
                              style: TextStyle(
                                color: !_isArabic
                                    ? const Color(0xFF2C1810)
                                    : Colors.grey.shade600,
                                fontWeight: !_isArabic
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Animated Background
          AnimatedBuilder(
            animation: _particleController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF1A1A2E), // Dark navy
                      const Color(0xFF16213E), // Deep blue
                      const Color(0xFF0F3460), // Rich blue
                      const Color(0xFF1A1A2E), // Dark navy
                    ],
                    stops: [
                      0.0,
                      0.3 +
                          0.2 *
                              math.sin(_particleController.value * 2 * math.pi),
                      0.7 +
                          0.2 *
                              math.cos(_particleController.value * 2 * math.pi),
                      1.0,
                    ],
                  ),
                ),
                child: CustomPaint(
                  painter: ParticlesPainter(_particleController.value),
                  size: Size.infinite,
                ),
              );
            },
          ),
          // Golden overlay pattern
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topRight,
                    radius: 1.8,
                    colors: [
                      const Color(
                        0xFFFFD700,
                      ).withOpacity(0.25 * _fadeAnimation.value),
                      const Color(
                        0xFFFFA500,
                      ).withOpacity(0.15 * _fadeAnimation.value),
                      const Color(
                        0xFFFF6B35,
                      ).withOpacity(0.08 * _fadeAnimation.value),
                      Colors.transparent,
                    ],
                  ),
                ),
              );
            },
          ),
          // Main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Header section
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 80,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      // Logo
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Image.asset(
                          'assets/images/logo2.png',
                          height: MediaQuery.of(context).size.width > 600
                              ? 180
                              : 120,
                          width: MediaQuery.of(context).size.width > 600
                              ? 180
                              : 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                      // Company name with golden effect
                      AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                Color(0xFFfec76f), // Custom gold
                                Color(0xFFfec76f), // Custom gold
                                Color(0xFFfec76f), // Custom gold
                              ],
                            ).createShader(bounds),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFFFFD700,
                                    ).withOpacity(0.2),
                                    blurRadius: 30,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Text(
                                _getTexts()['companyName']!,
                                style: GoogleFonts.cairo(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 600
                                      ? 64
                                      : 48,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 2.0,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(0, 0),
                                      blurRadius: 5,
                                      color: const Color(
                                        0xFFFFD700,
                                      ).withOpacity(0.3),
                                    ),
                                    Shadow(
                                      offset: const Offset(1, 1),
                                      blurRadius: 3,
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      // Slogan
                      Text(
                        _getTexts()['slogan']!,
                        style: GoogleFonts.cairo(
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? 26
                              : 20,
                          color: const Color(0xFF8B4513),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              offset: const Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 100,
                        height: 2,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // WhatsApp buttons section
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        'تواصل مع مستشارينا العقاريين',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? 34
                              : 28,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF2C1810),
                          shadows: [
                            Shadow(
                              offset: const Offset(0, 0),
                              blurRadius: 15,
                              color: const Color(0xFFFFD700).withOpacity(0.6),
                            ),
                            Shadow(
                              offset: const Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 80),
                      // WhatsApp buttons
                      _buildLuxuryWhatsAppButton(
                        context,
                        _getTexts()['whatsapp_title']!,
                        _getTexts()['consultant1']!,
                        SvgPicture.asset(
                          'assets/images/whatsapp_icon.svg',
                          width: 32,
                          height: 32,
                        ),
                        'https://wa.me/966563559911',
                      ),
                      const SizedBox(height: 25),
                      _buildLuxuryWhatsAppButton(
                        context,
                        _getTexts()['whatsapp_title']!,
                        _getTexts()['consultant2']!,
                        SvgPicture.asset(
                          'assets/images/whatsapp_icon.svg',
                          width: 32,
                          height: 32,
                        ),
                        'https://wa.me/966535695919',
                      ),
                      const SizedBox(height: 25),
                      _buildLuxuryWhatsAppButton(
                        context,
                        _getTexts()['whatsapp_title']!,
                        _getTexts()['consultant3']!,
                        SvgPicture.asset(
                          'assets/images/whatsapp_icon.svg',
                          width: 32,
                          height: 32,
                        ),
                        'https://wa.me/966541431657',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                // Property showcase section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        'خدماتنا العقارية المتميزة',
                        style: GoogleFonts.cairo(
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? 34
                              : 28,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF2C1810),
                          shadows: [
                            Shadow(
                              offset: const Offset(0, 0),
                              blurRadius: 12,
                              color: const Color(0xFFFFD700).withOpacity(0.5),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      // Property cards
                      MediaQuery.of(context).size.width > 800
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: _buildPropertyCard(
                                    Icons.home,
                                    const Color(0xFF4CAF50),
                                    _getTexts()['villa_title']!,
                                    _getTexts()['villa_desc']!,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: _buildPropertyCard(
                                    Icons.apartment,
                                    const Color(0xFF2196F3),
                                    _getTexts()['building_title']!,
                                    _getTexts()['building_desc']!,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: _buildPropertyCard(
                                    Icons.bed,
                                    const Color(0xFFFF9800),
                                    _getTexts()['apartment_title']!,
                                    _getTexts()['apartment_desc']!,
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              height: 280,
                              child: PageView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: _buildPropertyCard(
                                      Icons.home,
                                      const Color(0xFF4CAF50),
                                      _getTexts()['villa_title']!,
                                      _getTexts()['villa_desc']!,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: _buildPropertyCard(
                                      Icons.business,
                                      const Color(0xFF9C27B0),
                                      _getTexts()['commercial_title']!,
                                      _getTexts()['commercial_desc']!,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: _buildPropertyCard(
                                      Icons.bed,
                                      const Color(0xFFFF9800),
                                      _getTexts()['apartment_title']!,
                                      _getTexts()['apartment_desc']!,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                // Company description
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.95),
                        const Color(0xFFFFFDF5).withOpacity(0.98),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFFFFD700).withOpacity(0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFD700).withOpacity(0.2),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'عن شركة الطخيم العالمية للعقارات',
                        style: GoogleFonts.cairo(
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? 30
                              : 24,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF2C1810),
                          shadows: [
                            Shadow(
                              offset: const Offset(0, 0),
                              blurRadius: 10,
                              color: const Color(0xFFFFD700).withOpacity(0.6),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      Text(
                        'نحن شركة رائدة في مجال العقارات، نقدم خدمات متميزة في بيع وشراء وتأجير العقارات الفاخرة. نفخر بخبرتنا الواسعة في السوق العقاري السعودي ونسعى لتحقيق أحلام عملائنا في الحصول على العقار المثالي. فريقنا من المستشارين المحترفين يضمن لك تجربة عقارية استثنائية تتميز بالشفافية والمصداقية.',
                        style: GoogleFonts.cairo(
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? 19
                              : 17,
                          color: const Color(0xFF5D4E37),
                          height: 1.9,
                          letterSpacing: 0.6,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                // Contact information - Enhanced Design
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Contact section title
                      Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        child: Column(
                          children: [
                            Text(
                              'تواصل معنا',
                              style: GoogleFonts.cairo(
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                    ? 32
                                    : 26,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF2C1810),
                                shadows: [
                                  Shadow(
                                    offset: const Offset(0, 0),
                                    blurRadius: 12,
                                    color: const Color(
                                      0xFFFFD700,
                                    ).withOpacity(0.5),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 3,
                              width: 80,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFFD700),
                                    Color(0xFFFFA500),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Contact cards grid
                      MediaQuery.of(context).size.width > 800
                          ? Row(
                              children: [
                                Expanded(
                                  child: _buildEnhancedContactCard(
                                    Icons.phone_rounded,
                                    _getTexts()['contact_phone_title']!,
                                    '+966 53 569 5919',
                                    _getTexts()['contact_phone_desc']!,
                                    const Color(0xFF4CAF50),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: _buildEnhancedContactCard(
                                    Icons.email_rounded,
                                    _getTexts()['contact_email_title']!,
                                    'altukhaymglobal@gmail.com',
                                    _getTexts()['contact_email_desc']!,
                                    const Color(0xFF2196F3),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: _buildEnhancedContactCard(
                                    Icons.location_on_rounded,
                                    _getTexts()['contact_location_title']!,
                                    _getTexts()['contact_location_value']!,
                                    _getTexts()['contact_location_desc']!,
                                    const Color(0xFFFF9800),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildEnhancedContactCard(
                                  Icons.phone_rounded,
                                  _getTexts()['contact_phone_title']!,
                                  '+966 11 456 7890',
                                  _getTexts()['contact_phone_desc']!,
                                  const Color(0xFF4CAF50),
                                ),
                                const SizedBox(height: 20),
                                _buildEnhancedContactCard(
                                  Icons.email_rounded,
                                  _getTexts()['contact_email_title']!,
                                  'info@altakheem-realestate.com',
                                  _getTexts()['contact_email_desc']!,
                                  const Color(0xFF2196F3),
                                ),
                                const SizedBox(height: 20),
                                _buildEnhancedContactCard(
                                  Icons.location_on_rounded,
                                  _getTexts()['contact_location_title']!,
                                  _getTexts()['contact_location_value']!,
                                  _getTexts()['contact_location_desc']!,
                                  const Color(0xFFFF9800),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                // Footer
                Container(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    '© 2025 حقوق الطبع محفوظة لشركة الطخيم العالمية للعقارات',
                    style: TextStyle(
                      color: const Color(0xFFFFD700).withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          // Golden glow popup overlay
          if (_showPopup) ...[
            Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1A1A1A), Color(0xFF2D2D2D)],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFFFFD700),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFD700).withOpacity(0.5),
                        blurRadius: 30,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                          ),
                        ),
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.black,
                          ),
                          strokeWidth: 3,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        _popupMessage,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFD700),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Floating Back to Top Button
            if (_showBackToTop)
              Positioned(
                bottom: 30,
                right: 20,
                child: AnimatedOpacity(
                  opacity: _showBackToTop ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: FloatingActionButton(
                    onPressed: _scrollToTop,
                    backgroundColor: const Color(0xFFFFD700),
                    foregroundColor: const Color(0xFF2C1810),
                    elevation: 8,
                    mini: false,
                    child: const Icon(Icons.keyboard_arrow_up, size: 28),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildLuxuryWhatsAppButton(
    BuildContext context,
    String title,
    String subtitle,
    Widget icon,
    String whatsappUrl,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width > 600 ? 500 : double.infinity,
      child: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _showContactPopup(
                'جارٍ تحويلك إلى مستشارنا العقاري...',
                whatsappUrl,
              ),
              borderRadius: BorderRadius.circular(25),
              child: Container(
                constraints: const BoxConstraints(minHeight: 44, minWidth: 44),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Color(0xFFFFFDF5)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFD700).withOpacity(0.4),
                      blurRadius: 20 * _fadeAnimation.value,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  border: Border.all(color: const Color(0xFFFFD700), width: 2),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF25D366).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFF25D366).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: SizedBox(width: 32, height: 32, child: icon),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.cairo(
                              color: const Color(0xFF2C1810),
                              fontSize: MediaQuery.of(context).size.width > 600
                                  ? 20
                                  : 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            subtitle,
                            style: GoogleFonts.cairo(
                              color: const Color(0xFF5D4E37),
                              fontSize: MediaQuery.of(context).size.width > 600
                                  ? 16
                                  : 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF2C1810),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPropertyCard(
    IconData iconData,
    Color iconColor,
    String title,
    String description,
  ) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            // Property card tap action - could navigate to details
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('تم النقر على $title'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Container(
            constraints: const BoxConstraints(minHeight: 44, minWidth: 44),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.95),
                  const Color(0xFFFFFDF5).withOpacity(0.98),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: const Color(0xFFFFD700).withOpacity(0.6),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(
                    0xFFFFD700,
                  ).withOpacity(0.3 * _fadeAnimation.value),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(iconData, size: 50, color: iconColor),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 600 ? 24 : 20,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF2C1810),
                    shadows: const [
                      Shadow(
                        offset: Offset(0, 0),
                        blurRadius: 8,
                        color: Color(0xFFFFD700),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 600 ? 17 : 15,
                    color: const Color(0xFF5D4E37),
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactInfo(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.black, size: 24),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFFD700),
                  fontSize: MediaQuery.of(context).size.width > 600 ? 16 : 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: MediaQuery.of(context).size.width > 600 ? 16 : 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedContactCard(
    IconData icon,
    String title,
    String value,
    String subtitle,
    Color accentColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, const Color(0xFFFFFDF5).withOpacity(0.95)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon with animated background
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accentColor.withOpacity(0.1),
                  accentColor.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: accentColor.withOpacity(0.3), width: 1),
            ),
            child: Icon(icon, color: accentColor, size: 32),
          ),
          const SizedBox(height: 20),
          // Title
          Text(
            title,
            style: GoogleFonts.cairo(
              fontSize: MediaQuery.of(context).size.width > 600 ? 18 : 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2C1810),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Value
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: MediaQuery.of(context).size.width > 600 ? 15 : 14,
              fontWeight: FontWeight.w600,
              color: accentColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          // Subtitle
          Text(
            subtitle,
            style: GoogleFonts.cairo(
              fontSize: MediaQuery.of(context).size.width > 600 ? 13 : 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ParticlesPainter extends CustomPainter {
  final double animationValue;

  ParticlesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.4)
      ..style = PaintingStyle.fill;

    // Draw floating golden particles
    for (int i = 0; i < 12; i++) {
      final x =
          (size.width * (i * 0.08 + 0.1)) +
          60 * math.sin(animationValue * 1.5 * math.pi + i);
      final y =
          (size.height * (i * 0.04 + 0.1)) +
          40 * math.cos(animationValue * 1.8 * math.pi + i * 0.7);

      // Add glow effect to particles
      final glowPaint = Paint()
        ..color = const Color(0xFFFFD700).withOpacity(0.2)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(x % size.width, y % size.height),
        3.0 + math.sin(animationValue * 3 * math.pi + i) * 1.5,
        glowPaint,
      );

      canvas.drawCircle(
        Offset(x % size.width, y % size.height),
        1.5 + math.sin(animationValue * 3 * math.pi + i) * 0.8,
        paint,
      );
    }

    // Draw floating stars
    for (int i = 0; i < 8; i++) {
      final starX =
          size.width * (0.1 + i * 0.06) +
          80 * math.cos(animationValue * 0.9 * math.pi + i * 0.4);
      final starY =
          size.height * (0.15 + i * 0.05) +
          50 * math.sin(animationValue * 1.1 * math.pi + i * 0.6);

      _drawStar(
        canvas,
        Offset(starX % size.width, starY % size.height),
        12.0 + math.sin(animationValue * 2 * math.pi + i) * 3,
      );
    }

    // Draw floating diamonds
    for (int i = 0; i < 4; i++) {
      final diamondX =
          size.width * (0.2 + i * 0.12) +
          70 * math.sin(animationValue * 0.7 * math.pi + i * 0.8);
      final diamondY =
          size.height * (0.4 + i * 0.07) +
          45 * math.cos(animationValue * 1.3 * math.pi + i * 0.5);

      _drawDiamond(
        canvas,
        Offset(diamondX % size.width, diamondY % size.height),
        15.0 + math.cos(animationValue * 2.5 * math.pi + i) * 4,
      );
    }

    // Draw floating currency symbols
    for (int i = 0; i < 3; i++) {
      final currencyX =
          size.width * (0.8 + i * 0.03) +
          60 * math.cos(animationValue * 1.4 * math.pi + i * 1.1);
      final currencyY =
          size.height * (0.1 + i * 0.15) +
          35 * math.sin(animationValue * 1.7 * math.pi + i * 0.7);

      _drawCurrencySymbol(
        canvas,
        Offset(currencyX % size.width, currencyY % size.height),
      );
    }

    // Draw floating geometric shapes
    for (int i = 0; i < 6; i++) {
      final shapeX =
          size.width * (0.05 + i * 0.09) +
          55 * math.sin(animationValue * 1.6 * math.pi + i * 0.9);
      final shapeY =
          size.height * (0.7 + i * 0.03) +
          30 * math.cos(animationValue * 2.1 * math.pi + i * 0.3);

      if (i % 3 == 0) {
        _drawHexagon(
          canvas,
          Offset(shapeX % size.width, shapeY % size.height),
          18.0 + math.sin(animationValue * 3 * math.pi + i) * 5,
        );
      } else if (i % 3 == 1) {
        _drawTriangle(
          canvas,
          Offset(shapeX % size.width, shapeY % size.height),
          20.0 + math.cos(animationValue * 2.8 * math.pi + i) * 4,
        );
      } else {
        _drawPentagon(
          canvas,
          Offset(shapeX % size.width, shapeY % size.height),
          16.0 + math.sin(animationValue * 2.3 * math.pi + i) * 3,
        );
      }
    }

    // Real Estate Objects
    final buildingPaint = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw animated buildings
    for (int i = 0; i < 3; i++) {
      final baseX =
          size.width * (0.1 + i * 0.15) +
          80 * math.sin(animationValue * 0.8 * math.pi + i * 0.5);
      final baseY = size.height * (0.3 + i * 0.1);

      // Building base
      final buildingRect = Rect.fromLTWH(
        baseX % size.width,
        baseY,
        35 + i * 5,
        60 + i * 15,
      );
      canvas.drawRect(buildingRect, buildingPaint);
      canvas.drawRect(buildingRect, outlinePaint);

      // Building windows
      final windowPaint = Paint()
        ..color = const Color(0xFFFFA500).withOpacity(0.7)
        ..style = PaintingStyle.fill;

      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 2; col++) {
          final windowRect = Rect.fromLTWH(
            baseX % size.width + 8 + col * 12,
            baseY + 10 + row * 15,
            6,
            8,
          );
          canvas.drawRect(windowRect, windowPaint);
        }
      }
    }

    // Draw animated house icons
    for (int i = 0; i < 2; i++) {
      final houseX =
          size.width * (0.2 + i * 0.2) +
          70 * math.cos(animationValue * 1.2 * math.pi + i);
      final houseY =
          size.height * (0.6 + i * 0.08) +
          30 * math.sin(animationValue * 1.5 * math.pi + i * 0.8);

      _drawHouse(
        canvas,
        Offset(houseX % size.width, houseY % size.height),
        25.0,
      );
    }

    // Draw animated key icons
    for (int i = 0; i < 2; i++) {
      final keyX =
          size.width * (0.7 + i * 0.1) +
          50 * math.sin(animationValue * 2 * math.pi + i * 1.2);
      final keyY =
          size.height * (0.2 + i * 0.2) +
          25 * math.cos(animationValue * 1.8 * math.pi + i);

      _drawKey(canvas, Offset(keyX % size.width, keyY % size.height), 15.0);
    }

    // Draw property percentage symbols
    for (int i = 0; i < 3; i++) {
      final symbolX =
          size.width * (0.05 + i * 0.18) +
          40 * math.sin(animationValue * 1.3 * math.pi + i * 0.6);
      final symbolY =
          size.height * (0.8 + i * 0.03) +
          20 * math.cos(animationValue * 1.6 * math.pi + i * 0.4);

      _drawPercentSymbol(
        canvas,
        Offset(symbolX % size.width, symbolY % size.height),
      );
    }
  }

  void _drawHouse(Canvas canvas, Offset center, double size) {
    final housePaint = Paint()
      ..color = const Color(0xFFFF6B35).withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // House base
    final houseRect = Rect.fromCenter(
      center: center,
      width: size,
      height: size * 0.8,
    );
    canvas.drawRect(houseRect, housePaint);
    canvas.drawRect(houseRect, outlinePaint);

    // Roof (triangle)
    final roofPath = Path();
    roofPath.moveTo(center.dx - size / 2, center.dy - size * 0.4);
    roofPath.lineTo(center.dx, center.dy - size * 0.8);
    roofPath.lineTo(center.dx + size / 2, center.dy - size * 0.4);
    roofPath.close();

    canvas.drawPath(roofPath, housePaint);
    canvas.drawPath(roofPath, outlinePaint);

    // Door
    final doorRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy + size * 0.2),
      width: size * 0.3,
      height: size * 0.4,
    );
    canvas.drawRect(doorRect, outlinePaint);
  }

  void _drawKey(Canvas canvas, Offset center, double size) {
    final keyPaint = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    // Key shaft
    canvas.drawLine(
      Offset(center.dx - size / 2, center.dy),
      Offset(center.dx + size / 3, center.dy),
      keyPaint,
    );

    // Key head (circle)
    canvas.drawCircle(
      Offset(center.dx - size / 2, center.dy),
      size * 0.2,
      keyPaint,
    );

    // Key teeth
    canvas.drawLine(
      Offset(center.dx + size / 3, center.dy),
      Offset(center.dx + size / 3, center.dy - size * 0.15),
      keyPaint,
    );
    canvas.drawLine(
      Offset(center.dx + size / 4, center.dy),
      Offset(center.dx + size / 4, center.dy - size * 0.1),
      keyPaint,
    );
  }

  void _drawPercentSymbol(Canvas canvas, Offset center) {
    final symbolPaint = Paint()
      ..color = const Color(0xFFFFA500).withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Draw % symbol
    canvas.drawCircle(Offset(center.dx - 6, center.dy - 4), 2, symbolPaint);
    canvas.drawCircle(Offset(center.dx + 6, center.dy + 4), 2, symbolPaint);
    canvas.drawLine(
      Offset(center.dx - 8, center.dy + 6),
      Offset(center.dx + 8, center.dy - 6),
      symbolPaint,
    );
  }

  void _drawStar(Canvas canvas, Offset center, double size) {
    final starPaint = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = const Color(0xFFFFA500).withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();
    final outerRadius = size / 2;
    final innerRadius = outerRadius * 0.4;

    for (int i = 0; i < 10; i++) {
      final angle = (i * math.pi) / 5;
      final radius = i.isEven ? outerRadius : innerRadius;
      final x = center.dx + radius * math.cos(angle - math.pi / 2);
      final y = center.dy + radius * math.sin(angle - math.pi / 2);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, starPaint);
    canvas.drawPath(path, outlinePaint);
  }

  void _drawDiamond(Canvas canvas, Offset center, double size) {
    final diamondPaint = Paint()
      ..color = const Color(0xFF00BCD4).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = const Color(0xFF0097A7).withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();
    path.moveTo(center.dx, center.dy - size / 2); // Top
    path.lineTo(center.dx + size / 3, center.dy); // Right
    path.lineTo(center.dx, center.dy + size / 2); // Bottom
    path.lineTo(center.dx - size / 3, center.dy); // Left
    path.close();

    canvas.drawPath(path, diamondPaint);
    canvas.drawPath(path, outlinePaint);
  }

  void _drawCurrencySymbol(Canvas canvas, Offset center) {
    final currencyPaint = Paint()
      ..color = const Color(0xFF4CAF50).withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    // Draw $ symbol
    canvas.drawLine(
      Offset(center.dx, center.dy - 8),
      Offset(center.dx, center.dy + 8),
      currencyPaint,
    );

    // S curves
    final path = Path();
    path.moveTo(center.dx + 4, center.dy - 6);
    path.quadraticBezierTo(
      center.dx - 4,
      center.dy - 6,
      center.dx - 4,
      center.dy - 2,
    );
    path.quadraticBezierTo(
      center.dx + 4,
      center.dy - 2,
      center.dx + 4,
      center.dy + 2,
    );
    path.quadraticBezierTo(
      center.dx - 4,
      center.dy + 2,
      center.dx - 4,
      center.dy + 6,
    );

    canvas.drawPath(path, currencyPaint);
  }

  void _drawHexagon(Canvas canvas, Offset center, double size) {
    final hexPaint = Paint()
      ..color = const Color(0xFF9C27B0).withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = const Color(0xFF7B1FA2).withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * math.pi) / 3;
      final x = center.dx + (size / 2) * math.cos(angle);
      final y = center.dy + (size / 2) * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, hexPaint);
    canvas.drawPath(path, outlinePaint);
  }

  void _drawTriangle(Canvas canvas, Offset center, double size) {
    final trianglePaint = Paint()
      ..color = const Color(0xFFFF5722).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = const Color(0xFFD84315).withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();
    path.moveTo(center.dx, center.dy - size / 2); // Top
    path.lineTo(center.dx - size / 2, center.dy + size / 3); // Bottom left
    path.lineTo(center.dx + size / 2, center.dy + size / 3); // Bottom right
    path.close();

    canvas.drawPath(path, trianglePaint);
    canvas.drawPath(path, outlinePaint);
  }

  void _drawPentagon(Canvas canvas, Offset center, double size) {
    final pentagonPaint = Paint()
      ..color = const Color(0xFFE91E63).withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = const Color(0xFFC2185B).withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    final path = Path();
    for (int i = 0; i < 5; i++) {
      final angle = (i * 2 * math.pi) / 5 - math.pi / 2;
      final x = center.dx + (size / 2) * math.cos(angle);
      final y = center.dy + (size / 2) * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, pentagonPaint);
    canvas.drawPath(path, outlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
