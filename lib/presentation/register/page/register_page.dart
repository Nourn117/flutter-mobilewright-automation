import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/core/di/injection.dart';
import 'package:mobilewright_demo_app/core/state/submit_state.dart';
import 'package:mobilewright_demo_app/core/testing/test_ids.dart';
import 'package:mobilewright_demo_app/core/utils/validators.dart';
import 'package:mobilewright_demo_app/core/widgets/test_id.dart';
import 'package:mobilewright_demo_app/presentation/common/widgets/error_banner.dart';
import 'package:mobilewright_demo_app/presentation/register/cubit/register_cubit.dart';

/// Pops with the registered email so the login page can pre-fill it.
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterCubit>(),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    context.read<RegisterCubit>().register(
          name: _name.text,
          email: _email.text,
          password: _password.text,
        );
  }

  Future<void> _showSuccess() async {
    final email = _email.text.trim();
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => TestId(
        TestIds.registerSuccessDialog,
        child: AlertDialog(
          icon: const Icon(Icons.check_circle_rounded,
              size: 48, color: Color(0xFF10B981)),
          title: const Text('Account created'),
          content: Text('You can now log in with $email.',
              textAlign: TextAlign.center),
          actions: [
            SizedBox(
              width: double.infinity,
              child: TestId(
                TestIds.registerSuccessOk,
                child: FilledButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Go to Login'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    if (mounted) Navigator.of(context).pop(email);
  }

  Widget _field({
    required String id,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    bool obscure = false,
    TextInputType? keyboard,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TestId(
        id,
        child: TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboard,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
          ),
          validator: validator,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return BlocConsumer<RegisterCubit, SubmitState>(
      listenWhen: (prev, curr) => prev != curr,
      listener: (context, state) {
        if (state is SubmitSuccess) _showSuccess();
      },
      builder: (context, state) {
        final loading = state is SubmitLoading;
        return Scaffold(
          appBar: AppBar(title: const Text('Create account')),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Join us and start shopping in seconds.',
                        style: text.bodyLarge
                            ?.copyWith(color: scheme.onSurfaceVariant)),
                    const SizedBox(height: 24),
                    _field(
                      id: TestIds.registerName,
                      controller: _name,
                      label: 'Full name',
                      icon: Icons.person_outline_rounded,
                      validator: Validators.name,
                    ),
                    _field(
                      id: TestIds.registerEmail,
                      controller: _email,
                      label: 'Email',
                      icon: Icons.mail_outline_rounded,
                      validator: Validators.email,
                      keyboard: TextInputType.emailAddress,
                    ),
                    _field(
                      id: TestIds.registerPassword,
                      controller: _password,
                      label: 'Password',
                      icon: Icons.lock_outline_rounded,
                      validator: Validators.newPassword,
                      obscure: true,
                    ),
                    _field(
                      id: TestIds.registerConfirmPassword,
                      controller: _confirm,
                      label: 'Confirm password',
                      icon: Icons.lock_reset_rounded,
                      obscure: true,
                      validator: (v) =>
                          Validators.confirmPassword(v, _password.text),
                    ),
                    if (state case SubmitFailure(:final message)) ...[
                      ErrorBanner(id: TestIds.registerError, message: message),
                      const SizedBox(height: 16),
                    ],
                    const SizedBox(height: 8),
                    TestId(
                      TestIds.registerButton,
                      child: FilledButton(
                        onPressed: loading ? null : _submit,
                        child: loading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2.5),
                              )
                            : const Text('Create account'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
