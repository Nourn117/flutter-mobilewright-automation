
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/core/di/injection.dart';
import 'package:mobilewright_demo_app/core/theme/app_theme.dart';
import 'package:mobilewright_demo_app/core/theme/theme_cubit.dart';
import 'package:mobilewright_demo_app/presentation/cart/cubit/cart_cubit.dart';
import 'package:mobilewright_demo_app/presentation/common/cubit/session_cubit.dart';
import 'package:mobilewright_demo_app/presentation/home/cubit/home_tab_cubit.dart';
import 'package:mobilewright_demo_app/presentation/login/page/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeCubit>()),
        BlocProvider(create: (_) => sl<SessionCubit>()),
        BlocProvider(create: (_) => sl<CartCubit>()),
        BlocProvider(create: (_) => sl<HomeTabCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
          title: 'ShopQA',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: mode,
          home: const LoginPage(),
          builder: (context, child) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () =>
                FocusManager.instance.primaryFocus?.unfocus(),
            child: child,
          ),
        ),
      ),
    );
  }
}
