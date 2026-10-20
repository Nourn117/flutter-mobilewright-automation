import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeTab { products, cart, profile }

/// Selected bottom-navigation tab. Lives at app level so any screen can switch tabs.
class HomeTabCubit extends Cubit<HomeTab> {
  HomeTabCubit() : super(HomeTab.products);

  void select(HomeTab tab) => emit(tab);
}
