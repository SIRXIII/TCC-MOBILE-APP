// models/refund_request_model.dart

import 'package:flutter/material.dart';

class RefundRequest {
  final String id;
  final String orderId;
  final String orderItem;
  final double amount;
  final RefundReason reason;
  final String description;
  final List<String> imageUrls;
  final RefundStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? adminNote;

  RefundRequest({
    required this.id,
    required this.orderId,
    required this.orderItem,
    required this.amount,
    required this.reason,
    required this.description,
    required this.imageUrls,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.adminNote,
  });

  String get statusText {
    switch (status) {
      case RefundStatus.pending:
        return 'Pending Review';
      case RefundStatus.approved:
        return 'Approved';
      case RefundStatus.rejected:
        return 'Rejected';
      case RefundStatus.processing:
        return 'Processing';
      case RefundStatus.completed:
        return 'Completed';
    }
  }

  Color get statusColor {
    switch (status) {
      case RefundStatus.pending:
        return Colors.orange;
      case RefundStatus.approved:
        return Colors.green;
      case RefundStatus.rejected:
        return Colors.red;
      case RefundStatus.processing:
        return Colors.blue;
      case RefundStatus.completed:
        return Colors.green;
    }
  }

  RefundRequest copyWith({
    String? id,
    String? orderId,
    String? orderItem,
    double? amount,
    RefundReason? reason,
    String? description,
    List<String>? imageUrls,
    RefundStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? adminNote,
  }) {
    return RefundRequest(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      orderItem: orderItem ?? this.orderItem,
      amount: amount ?? this.amount,
      reason: reason ?? this.reason,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      adminNote: adminNote ?? this.adminNote,
    );
  }
}

enum RefundStatus { pending, approved, rejected, processing, completed }

enum RefundReason {
  damagedItem,
  wrongItem,
  lateDelivery,
  qualityIssue,
  sizeIssue,
  colorIssue,
  changedMind,
  other,
}

extension RefundReasonExtension on RefundReason {
  String get displayText {
    switch (this) {
      case RefundReason.damagedItem:
        return 'Item Damaged';
      case RefundReason.wrongItem:
        return 'Wrong Item Received';
      case RefundReason.lateDelivery:
        return 'Late Delivery';
      case RefundReason.qualityIssue:
        return 'Quality Issues';
      case RefundReason.sizeIssue:
        return 'Size Doesn\'t Fit';
      case RefundReason.colorIssue:
        return 'Color Doesn\'t Match';
      case RefundReason.changedMind:
        return 'Changed My Mind';
      case RefundReason.other:
        return 'Other Reason';
    }
  }

  String get description {
    switch (this) {
      case RefundReason.damagedItem:
        return 'The item arrived damaged or broken';
      case RefundReason.wrongItem:
        return 'Received different item than ordered';
      case RefundReason.lateDelivery:
        return 'Delivery was significantly delayed';
      case RefundReason.qualityIssue:
        return 'Poor quality or defective product';
      case RefundReason.sizeIssue:
        return 'Size doesn\'t fit as expected';
      case RefundReason.colorIssue:
        return 'Color is different from description';
      case RefundReason.changedMind:
        return 'No longer need the item';
      case RefundReason.other:
        return 'Other reason not listed';
    }
  }
}
