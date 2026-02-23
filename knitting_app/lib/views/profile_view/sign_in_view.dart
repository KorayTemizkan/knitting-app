import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/supabase_provider.dart';
import 'package:knitting_app/controllers/router.dart';
import 'package:knitting_app/main.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Şifre görünürlüğü için

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Hoş Geldiniz'),
      backgroundColor: const Color(0xFFE0F2F1),
      body: Column(
        children: [
          // 1. Üst Alan: Logo Alanı
          Expanded(
            flex: 4,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons
                          .auto_awesome_rounded, // Parlayan bir başlangıç ikonu
                      size: 90,
                      color: Color(0xFFFF5722),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Alt Alan: Giriş Formu
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                // Klavye açılınca taşmayı önler
                padding: const EdgeInsets.fromLTRB(32, 64, 32, 24),
                child: Column(
                  children: [
                    // Email Alanı
                    _buildTextField(
                      controller: _emailController,
                      label: 'E-mail',
                      icon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 20),

                    // Şifre Alanı
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Şifre',
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => context.go('/register'),
                        child: const Text(
                          'Şifremi Unuttum',
                          style: TextStyle(
                            color: Color(0xFFFF5722),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Giriş Butonu (Ana Aksiyon)
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () async{
                          final supabaseProvider = context
                              .read<SupabaseProvider>();
                          bool check = await supabaseProvider.signInUser(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );

                          if (check) {
                            context.go(AppRoutes.home);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5722),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Giriş Yap',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Kayıt Ol (İkincil Aksiyon)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Hesabın yok mu?"),
                        TextButton(
                          onPressed: () => context.go('/register'),
                          child: const Text(
                            'Hemen Kayıt Ol',
                            style: TextStyle(
                              color: Color(0xFFFF5722),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Textfieldları daha temiz yönetmek için yardımcı widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFFFF5722)),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () =>
                    setState(() => _isPasswordVisible = !_isPasswordVisible),
              )
            : null,
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
      ),
    );
  }
}
