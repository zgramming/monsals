import 'package:equatable/equatable.dart';

class GlobalModel extends Equatable {
  const GlobalModel({
    this.isLoading = false,
    this.monthActivity,
    this.yearActivity,
    this.selectedCategoryProduct,
  });

  final bool isLoading;
  final int? monthActivity;
  final int? yearActivity;
  final int? selectedCategoryProduct;

  @override
  List get props {
    return [
      isLoading,
      monthActivity,
      yearActivity,
      selectedCategoryProduct,
    ];
  }

  @override
  bool get stringify => true;

  GlobalModel copyWith({
    bool? isLoading,
    int? monthActivity,
    int? yearActivity,
    int? selectedCategoryProduct,
  }) {
    return GlobalModel(
      isLoading: isLoading ?? this.isLoading,
      monthActivity: monthActivity ?? this.monthActivity,
      yearActivity: yearActivity ?? this.yearActivity,
      selectedCategoryProduct: selectedCategoryProduct ?? this.selectedCategoryProduct,
    );
  }
}
