// widgets/size_selection_sheet.dart
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';

class SizeSelectionSheet extends StatefulWidget {
  final String selectedSize;
  final Function(String) onSizeSelected;

  const SizeSelectionSheet({
    super.key,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  State<SizeSelectionSheet> createState() => _SizeSelectionSheetState();
}

class _SizeSelectionSheetState extends State<SizeSelectionSheet> {
  late String _tempSelectedSize;

  final List<Map<String, dynamic>> _sizes = [
    {'value': 'XS', 'description': 'Extra Small'},
    {'value': 'S', 'description': 'Small'},
    {'value': 'M', 'description': 'Medium'},
    {'value': 'L', 'description': 'Large'},
    {'value': 'XL', 'description': 'Extra Large'},
    {'value': 'XXL', 'description': 'Double Extra Large'},
  ];

  @override
  void initState() {
    super.initState();
    _tempSelectedSize = widget.selectedSize;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8),
                appTextView(
                  text: 'Select Clothing Size',
                  size: AppDimensions.FONT_SIZE_16,
                  fontFamily: 'Roboto',
                  color: AppColors.BLACK,
                  fontWeight: FontWeight.bold,
                ),

                const Spacer(),
                TextButton(
                  onPressed: () {
                    widget.onSizeSelected(_tempSelectedSize);
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Size Guide
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.PRIMARY_COLOR.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.PRIMARY_COLOR.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.PRIMARY_COLOR,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: appTextView(
                      text:
                          'This helps us recommend better fitting clothes for rental',
                      size: AppDimensions.FONT_SIZE_14,
                      fontFamily: 'Roboto',
                      color: AppColors.PRIMARY_COLOR,
                      // fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Size Options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: _sizes.length,
              itemBuilder: (context, index) {
                final size = _sizes[index];
                return _buildSizeOption(
                  value: size['value'],
                  description: size['description'],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSizeOption({
    required String value,
    required String description,
  }) {
    final isSelected = _tempSelectedSize == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _tempSelectedSize = value;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.PRIMARY_COLOR : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.PRIMARY_COLOR : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.PRIMARY_COLOR.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appTextView(
              text: value,
              size: AppDimensions.FONT_SIZE_16,
              fontFamily: 'Roboto',
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),

            const SizedBox(height: 4),

            appTextView(
              text: description,
              size: AppDimensions.FONT_SIZE_12,
              fontFamily: 'Roboto',
              textAlign: TextAlign.center,
              color: isSelected
                  ? Colors.white.withOpacity(0.8)
                  : Colors.grey.shade600,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }
}
