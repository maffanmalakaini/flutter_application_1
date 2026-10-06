import 'package:flutter/material.dart';
import 'package:rumah_sehat/core/constants.dart';
import 'package:rumah_sehat/services/api_service.dart';
import 'package:rumah_sehat/widgets/logo.dart';
import 'package:rumah_sehat/widgets/reveal.dart';

class F {
  final String label;
  final IconData icon;
  final bool pass;
  final TextInputType type;
  const F(this.label, this.icon, {this.pass = false, this.type = TextInputType.text});
}

/// Satu form dipakai untuk Login & Register.
class AuthForm extends StatefulWidget {
  final String title, subtitle, button, footer, footerAction, footerRoute;
  final List<F> fields;
  final bool isRegister;
  const AuthForm._(this.title, this.subtitle, this.button, this.footer, this.footerAction, this.footerRoute, this.fields,
      {this.isRegister = false});

  factory AuthForm.login() => const AuthForm._(
        'Masuk', 'Selamat datang kembali di Rumah Sehat', 'Masuk', 'Belum punya akun? ', 'Daftar', '/register', [
        F('Email', Icons.email_outlined, type: TextInputType.emailAddress),
        F('Password', Icons.lock_outline, pass: true),
      ]);

  factory AuthForm.register() => const AuthForm._(
        'Daftar', 'Buat akun untuk mulai menggunakan layanan', 'Daftar', 'Sudah punya akun? ', 'Masuk', '/login', [
        F('Nama Lengkap', Icons.person_outline),
        F('Email', Icons.email_outlined, type: TextInputType.emailAddress),
        F('No. HP', Icons.phone_outlined, type: TextInputType.phone),
        F('Password', Icons.lock_outline, pass: true),
        F('Konfirmasi Password', Icons.lock_reset, pass: true),
      ], isRegister: true);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _key = GlobalKey<FormState>();
  late final _ctl = List.generate(widget.fields.length, (_) => TextEditingController());
  late final _hide = List.generate(widget.fields.length, (_) => true);
  bool _loading = false;

  String? _validate(int i, String? v) {
    final f = widget.fields[i];
    if (v == null || v.trim().isEmpty) return '${f.label} wajib diisi';
    if (f.label == 'Email' && !v.contains('@')) return 'Email tidak valid';
    if (f.label == 'Password' && v.length < 6) return 'Minimal 6 karakter';
    if (f.label.startsWith('Konfirmasi') && v != _ctl[i - 1].text) return 'Password tidak sama';
    return null;
  }

  Future<void> _submit() async {
    if (!_key.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      if (widget.isRegister) {
        await ApiService.register(
          name: _ctl[0].text.trim(),
          email: _ctl[1].text.trim(),
          noHp: _ctl[2].text.trim(),
          password: _ctl[3].text,
          confirm: _ctl[4].text,
        );
      } else {
        await ApiService.login(_ctl[0].text.trim(), _ctl[1].text);
      }
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    } on ApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message), backgroundColor: Colors.red, behavior: SnackBarBehavior.floating),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    for (final c in _ctl) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext c) {
    final w = widget;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFBBD6F8), Colors.white],
            stops: [0, .45],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(28, 40, 28, 24),
            child: Form(
              key: _key,
              child: Column(children: [
                const Hero(tag: 'logo', child: Material(color: Colors.transparent, child: Logo(size: 64))),
                const SizedBox(height: 28),
                Reveal(delay: 100, child: Text(w.title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: kBlue))),
                const SizedBox(height: 4),
                Reveal(delay: 200, child: Text(w.subtitle, style: const TextStyle(color: Colors.black54))),
                const SizedBox(height: 28),
                for (var i = 0; i < w.fields.length; i++)
                  Reveal(
                    delay: 300 + i * 100,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TextFormField(
                        controller: _ctl[i],
                        keyboardType: w.fields[i].type,
                        obscureText: w.fields[i].pass && _hide[i],
                        validator: (v) => _validate(i, v),
                        decoration: InputDecoration(
                          labelText: w.fields[i].label,
                          prefixIcon: Icon(w.fields[i].icon),
                          suffixIcon: w.fields[i].pass
                              ? IconButton(
                                  icon: Icon(_hide[i] ? Icons.visibility_off : Icons.visibility),
                                  onPressed: () => setState(() => _hide[i] = !_hide[i]),
                                )
                              : null,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                Reveal(
                  delay: 300 + w.fields.length * 100,
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: kBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: _loading ? null : _submit,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: _loading
                            ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                            : Text(w.button, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Reveal(
                  delay: 400 + w.fields.length * 100,
                  child: GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, w.footerRoute),
                    child: Text.rich(TextSpan(text: w.footer, style: const TextStyle(color: Colors.black54), children: [
                      TextSpan(text: w.footerAction, style: const TextStyle(color: kBlue, fontWeight: FontWeight.w800)),
                    ])),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
