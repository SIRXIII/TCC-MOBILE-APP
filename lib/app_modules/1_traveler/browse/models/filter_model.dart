// models/filter_model.dart
class FilterModel {
  bool browse;
  bool search;
  String rentalDuration;
  List<String> selectedBrands;
  double minRating;
  String size;
  double minPrice;
  double maxPrice;

  @override
  String toString() {
    return 'FilterModel{browse: $browse, search: $search, rentalDuration: $rentalDuration, selectedBrands: $selectedBrands, minRating: $minRating, size: $size, minPrice: $minPrice, maxPrice: $maxPrice}';
  }

  FilterModel({
    this.browse = false,
    this.search = true,
    this.rentalDuration = '',
    this.selectedBrands = const [],
    this.minRating = 0.0,
    this.size = '',
    this.minPrice = 5.0,
    this.maxPrice = 500.0,
  });

  FilterModel copyWith({
    bool? browse,
    bool? search,
    String? rentalDuration,
    List<String>? selectedBrands,
    double? minRating,
    String? size,
    double? minPrice,
    double? maxPrice,
  }) {
    return FilterModel(
      browse: browse ?? this.browse,
      search: search ?? this.search,
      rentalDuration: rentalDuration ?? this.rentalDuration,
      selectedBrands: selectedBrands ?? this.selectedBrands,
      minRating: minRating ?? this.minRating,
      size: size ?? this.size,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  int getDaysFromString() {
    // Use RegExp to extract the first number in the string
    final match = RegExp(r'\d+').firstMatch(rentalDuration);
    if (match != null) {
      return int.parse(match.group(0)!);
    }
    return 0; // default if no number found
  }
}
