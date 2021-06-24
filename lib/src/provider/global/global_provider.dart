import 'package:flutter_riverpod/flutter_riverpod.dart';

// final isLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);

// final monthActivity = StateProvider.autoDispose<int>((ref) => DateTime.now().month);
// final yearActivity = StateProvider.autoDispose<int>((ref) => DateTime.now().year);

final selectedIdProduct = StateProvider.autoDispose<int?>((ref) => null);

final selectedCategoryProduct = StateProvider.autoDispose<int?>((ref) => null);

final selectedYearActivity = StateProvider.autoDispose<int>((ref) => DateTime.now().year);

final selectedMonthActivity = StateProvider.autoDispose<int>((ref) => DateTime.now().month);

final isLoading = StateProvider.autoDispose<bool>((ref) => false);

/// Penjualan
final totalPenjualan = StateProvider.autoDispose<int>((ref) => 0);
