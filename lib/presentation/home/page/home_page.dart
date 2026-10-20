import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/core/testing/test_ids.dart';
import 'package:mobilewright_demo_app/core/widgets/test_id.dart';
import 'package:mobilewright_demo_app/presentation/cart/cubit/cart_cubit.dart';
import 'package:mobilewright_demo_app/presentation/cart/page/cart_page.dart';
import 'package:mobilewright_demo_app/presentation/home/cubit/home_tab_cubit.dart';
import 'package:mobilewright_demo_app/presentation/products/page/products_page.dart';
import 'package:mobilewright_demo_app/presentation/profile/page/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _tabs = <Widget>[
    ProductsPage(),
    CartPage(),
    ProfilePage(),
  ];

  /// Same test id for the normal and selected icon, so the id always exists.
  Widget _navIcon(String id, IconData icon, {int badge = 0}) {
    Widget child = Icon(icon);
    if (id == TestIds.navCart) {
      child = Badge(
        isLabelVisible: badge > 0,
        label: TestId(TestIds.cartBadge, child: Text('$badge', semanticsLabel: 'Cart items: $badge')),
        child: child,
      );
    }
    return TestId(id, child: child);
  }

  @override
  Widget build(BuildContext context) {
    final tab = context.watch<HomeTabCubit>().state;
    final count = context.select((CartCubit c) => c.state.count);

    return Scaffold(
      body: IndexedStack(index: tab.index, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab.index,
        onDestinationSelected: (i) =>
            context.read<HomeTabCubit>().select(HomeTab.values[i]),
        destinations: [
          NavigationDestination(
            icon: _navIcon(TestIds.navProducts, Icons.storefront_outlined),
            selectedIcon:
                _navIcon(TestIds.navProducts, Icons.storefront_rounded),
            label: 'Shop',
          ),
          NavigationDestination(
            icon: _navIcon(TestIds.navCart, Icons.shopping_cart_outlined,
                badge: count),
            selectedIcon: _navIcon(TestIds.navCart, Icons.shopping_cart_rounded,
                badge: count),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: _navIcon(TestIds.navProfile, Icons.person_outline_rounded),
            selectedIcon: _navIcon(TestIds.navProfile, Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
