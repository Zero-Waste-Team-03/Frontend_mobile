import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/sources/auth_local_data_source.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final AuthLocalDataSource _localDataSource;

  ThemeCubit(this._localDataSource) : super(ThemeMode.system) {
    _initFromCache();
  }

  Future<void> _initFromCache() async {
    try {
      final userModel = await _localDataSource.getCachedUserProfile();
      final appearance = userModel?.settings?.appearance;
      setFromAppearance(appearance);
    } catch (_) {
      // keep system as default
    }
  }

  void setThemeMode(ThemeMode mode) => emit(mode);

  void setFromAppearance(String? appearance) {
    if (appearance == null) return;
    final normalized = appearance.toUpperCase();
    switch (normalized) {
      case 'DARK':
        setThemeMode(ThemeMode.dark);
        break;
      case 'LIGHT':
        setThemeMode(ThemeMode.light);
        break;
      case 'SYSTEM':
      default:
        setThemeMode(ThemeMode.system);
        break;
    }
  }
}
