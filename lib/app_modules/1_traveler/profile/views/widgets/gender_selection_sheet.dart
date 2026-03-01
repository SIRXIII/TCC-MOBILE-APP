// widgets/gender_selection_sheet.dart
import 'package:flutter/material.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';

class GenderSelectionSheet extends StatefulWidget {
  final String selectedGender;
  final Function(String) onGenderSelected;

  const GenderSelectionSheet({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  State<GenderSelectionSheet> createState() => _GenderSelectionSheetState();
}

class _GenderSelectionSheetState extends State<GenderSelectionSheet> {
  late String _tempSelectedGender;

  final List<Map<String, dynamic>> _genders = [
    {'value': 'Male', 'icon': Icons.male, 'color': AppColors.PRIMARY_COLOR},

    {'value': 'Female', 'icon': Icons.female, 'color': AppColors.PRIMARY_COLOR},
    {
      'value': 'Other',
      'icon': Icons.transgender,
      'color': AppColors.PRIMARY_COLOR,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tempSelectedGender = widget.selectedGender;
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
                  text: 'Select Gender',
                  size: AppDimensions.FONT_SIZE_16,
                  fontFamily: 'Roboto',
                  color: AppColors.BLACK,
                  fontWeight: FontWeight.bold,
                ),

                // const Text(
                //   'Select Gender',
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    widget.onGenderSelected(_tempSelectedGender);
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

          // Gender Options
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: _genders.map((gender) {
                return _buildGenderOption(
                  value: gender['value'],
                  icon: gender['icon'],
                  color: gender['color'],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGenderOption({
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = _tempSelectedGender == value;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: isSelected ? 1 : 0,
      color: isSelected ? AppColors.WHITE.withOpacity(0.7) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? color : AppColors.BLACK.withValues(alpha: 0.4),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: appTextView(
          text: value,
          size: AppDimensions.FONT_SIZE_16,
          fontFamily: 'Roboto',
          color: isSelected ? color : AppColors.BLACK.withValues(alpha: 0.6),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),

        trailing: isSelected
            ? Icon(Icons.check_circle, color: color)
            : const SizedBox(width: 24),
        onTap: () {
          setState(() {
            _tempSelectedGender = value;
          });
        },
      ),
    );
  }
}
