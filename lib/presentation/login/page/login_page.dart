import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/core/di/injection.dart';
import 'package:mobilewright_demo_app/core/state/submit_state.dart';
import 'package:mobilewright_demo_app/core/testing/test_ids.dart';
import 'package:mobilewright_demo_app/core/utils/validators.dart';
import 'package:mobilewright_demo_app/core/widgets/test_id.dart';
import 'package:mobilewright_demo_app/presentation/common/cubit/session_cubit.dart';
import 'package:mobilewright_demo_app/presentation/common/widgets/error_banner.dart';
import 'package:mobilewright_demo_app/presentation/home/cubit/home_tab_cubit.dart';
import 'package:mobilewright_demo_app/presentation/home/page/home_page.dart';
import 'package:mobilewright_demo_app/presentation/login/cubit/login_cubit.dart';
import 'package:mobilewright_demo_app/presentation/register/page/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    context.read<LoginCubit>().login(_email.text, _password.text);
  }

  Future<void> _openRegister() async {
    final email = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const RegisterPage()),
    );
    if (email != null && mounted) {
      _email.text = email;
      _password.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return BlocConsumer<LoginCubit, SubmitState>(
      listenWhen: (prev, curr) => prev != curr,
      listener: (context, state) {
        if (state is SubmitSuccess) {
          context.read<SessionCubit>().refresh();
          context.read<HomeTabCubit>().select(HomeTab.products);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(builder: (_) => const HomePage()),
          );
        }
      },
      builder: (context, state) {
        final loading = state is SubmitLoading;
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: scheme.primaryContainer,
                          child: Icon(Icons.shopping_bag_rounded,
                              size: 40, color: scheme.primary),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text('Welcome back',
                          textAlign: TextAlign.center,
                          style: text.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      Text('Log in to continue shopping',
                          textAlign: TextAlign.center,
                          style: text.bodyLarge
                              ?.copyWith(color: scheme.onSurfaceVariant)),
                      const SizedBox(height: 32),
                      TestId(
                        TestIds.loginEmail,
                        child: TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                          ),
                          validator: Validators.email,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TestId(
                        TestIds.loginPassword,
                        child: TextFormField(
                          controller: _password,
                          obscureText: _obscure,
                          onFieldSubmitted: (_) => _submit(),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            suffixIcon: TestId(
                              TestIds.loginPasswordToggle,
                              child: IconButton(
                                tooltip: _obscure
                                    ? 'Show password'
                                    : 'Hide password',
                                icon: Icon(_obscure
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                              ),
                            ),
                          ),
                          validator: Validators.loginPassword,
                        ),
                      ),
                      if (state case SubmitFailure(:final message)) ...[
                        const SizedBox(height: 16),
                        ErrorBanner(id: TestIds.loginError, message: message),
                      ],
                      const SizedBox(height: 24),
                      TestId(
                        TestIds.loginButton,
                        child: FilledButton(
                          onPressed: loading ? null : _submit,
                          child: loading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.5),
                                )
                              : const Text('Log in'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TestId(
                            TestIds.loginGoToRegister,
                            child: TextButton(
                              onPressed: loading ? null : _openRegister,
                              child: const Text('Register'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
