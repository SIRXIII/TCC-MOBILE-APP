// // models/support_request_model.dart
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class SupportRequest {
//   final String id;
//   final String subject;
//   final String description;
//   final DateTime createdAt;
//   final DateTime? updatedAt;
//   final SupportStatus status;
//   final SupportPriority priority;
//   final String? adminResponse;
//   final String category;
//
//   SupportRequest({
//     required this.id,
//     required this.subject,
//     required this.description,
//     required this.createdAt,
//     this.updatedAt,
//     required this.status,
//     required this.priority,
//     this.adminResponse,
//     required this.category,
//   });
//
//   String get formattedDate {
//     final now = DateTime.now();
//     final difference = now.difference(createdAt);
//
//     if (difference.inMinutes < 1) return 'Just now';
//     if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
//     if (difference.inHours < 24) return '${difference.inHours}h ago';
//     if (difference.inDays < 7) return '${difference.inDays}d ago';
//     return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
//   }
//
//   Color get statusColor {
//     switch (status) {
//       case SupportStatus.open:
//         return Colors.blue;
//       case SupportStatus.inProgress:
//         return Colors.orange;
//       case SupportStatus.resolved:
//         return Colors.green;
//       case SupportStatus.closed:
//         return Colors.grey;
//     }
//   }
//
//   Color get priorityColor {
//     switch (priority) {
//       case SupportPriority.low:
//         return Colors.green;
//       case SupportPriority.medium:
//         return Colors.orange;
//       case SupportPriority.high:
//         return Colors.red;
//       case SupportPriority.urgent:
//         return Colors.purple;
//     }
//   }
//
//   String get statusText {
//     switch (status) {
//       case SupportStatus.open:
//         return 'Open';
//       case SupportStatus.inProgress:
//         return 'In Progress';
//       case SupportStatus.resolved:
//         return 'Resolved';
//       case SupportStatus.closed:
//         return 'Closed';
//     }
//   }
//
//   String get priorityText {
//     switch (priority) {
//       case SupportPriority.low:
//         return 'Low';
//       case SupportPriority.medium:
//         return 'Medium';
//       case SupportPriority.high:
//         return 'High';
//       case SupportPriority.urgent:
//         return 'Urgent';
//     }
//   }
//
//   SupportRequest copyWith({
//     String? id,
//     String? subject,
//     String? description,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     SupportStatus? status,
//     SupportPriority? priority,
//     String? adminResponse,
//     String? category,
//   }) {
//     return SupportRequest(
//       id: id ?? this.id,
//       subject: subject ?? this.subject,
//       description: description ?? this.description,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       status: status ?? this.status,
//       priority: priority ?? this.priority,
//       adminResponse: adminResponse ?? this.adminResponse,
//       category: category ?? this.category,
//     );
//   }
// }
//
// enum SupportStatus { open, inProgress, resolved, closed }
//
// enum SupportPriority { low, medium, high, urgent }

//
// extension SupportCategoryExtension on String {
//   String get displayName {
//     switch (this) {
//       case 'account':
//         return 'Account Issues';
//       case 'billing':
//         return 'Billing & Payments';
//       case 'technical':
//         return 'Technical Support';
//       case 'rental':
//         return 'Rental Issues';
//       case 'delivery':
//         return 'Delivery Problems';
//       case 'refund':
//         return 'Refund Requests';
//       case 'other':
//         return 'Other Issues';
//       default:
//         return 'General Support';
//     }
//   }
//
//   IconData get icon {
//     switch (this) {
//       case 'account':
//         return Icons.person;
//       case 'billing':
//         return Icons.payment;
//       case 'technical':
//         return Icons.settings;
//       case 'rental':
//         return Icons.shopping_bag;
//       case 'delivery':
//         return Icons.local_shipping;
//       case 'refund':
//         return Icons.money_off;
//       case 'other':
//         return Icons.help;
//       default:
//         return Icons.support;
//     }
//   }
// }
