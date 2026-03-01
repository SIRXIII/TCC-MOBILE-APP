// widgets/refund_reason_selection_sheet.dart
import 'package:flutter/material.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/models/refund_request_model.dart';

class RefundReasonSelectionSheet extends StatefulWidget {
  final RefundReason selectedReason;
  final Function(RefundReason) onReasonSelected;

  const RefundReasonSelectionSheet({
    super.key,
    required this.selectedReason,
    required this.onReasonSelected,
  });

  @override
  State<RefundReasonSelectionSheet> createState() =>
      _RefundReasonSelectionSheetState();
}

class _RefundReasonSelectionSheetState
    extends State<RefundReasonSelectionSheet> {
  late RefundReason _tempSelectedReason;

  final List<RefundReason> _reasons = RefundReason.values;

  @override
  void initState() {
    super.initState();
    _tempSelectedReason = widget.selectedReason;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12), // Adjust radius as needed
          topRight: Radius.circular(12), // Adjust radius as needed
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
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Select Refund Reason',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    widget.onReasonSelected(_tempSelectedReason);
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Reason Options
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: _reasons.map((reason) {
                  return _buildReasonOption(reason);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonOption(RefundReason reason) {
    final isSelected = _tempSelectedReason == reason;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isSelected ? 2 : 0,
      color: isSelected ? Colors.blue.withOpacity(0.05) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getReasonColor(reason).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getReasonIcon(reason),
            size: 20,
            color: _getReasonColor(reason),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reason.displayText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.blue : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              reason.description,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? Colors.blue.withOpacity(0.8)
                    : Colors.grey.shade600,
                height: 1.3,
              ),
            ),
          ],
        ),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.blue)
            : const SizedBox(width: 24),
        onTap: () {
          setState(() {
            _tempSelectedReason = reason;
          });
        },
      ),
    );
  }

  Color _getReasonColor(RefundReason reason) {
    switch (reason) {
      case RefundReason.damagedItem:
        return Colors.red;
      case RefundReason.wrongItem:
        return Colors.orange;
      case RefundReason.lateDelivery:
        return Colors.purple;
      case RefundReason.qualityIssue:
        return Colors.amber;
      case RefundReason.sizeIssue:
        return Colors.blue;
      case RefundReason.colorIssue:
        return Colors.pink;
      case RefundReason.changedMind:
        return Colors.green;
      case RefundReason.other:
        return Colors.grey;
    }
  }

  IconData _getReasonIcon(RefundReason reason) {
    switch (reason) {
      case RefundReason.damagedItem:
        return Icons.breakfast_dining;
      case RefundReason.wrongItem:
        return Icons.wrong_location;
      case RefundReason.lateDelivery:
        return Icons.access_time;
      case RefundReason.qualityIssue:
        return Icons.ac_unit;
      case RefundReason.sizeIssue:
        return Icons.straighten;
      case RefundReason.colorIssue:
        return Icons.palette;
      case RefundReason.changedMind:
        return Icons.psychology;
      case RefundReason.other:
        return Icons.more_horiz;
    }
  }
}
