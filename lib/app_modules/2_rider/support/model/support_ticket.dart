
import 'package:flutter/material.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/support/model/support_message.dart';

class SupportTicket {
  String? id;
  String subject;
  String description;
  TicketCategory category;
  TicketPriority priority;
  TicketStatus status;
  List<String> attachments;
  DateTime createdAt;
  DateTime updatedAt;
  List<SupportMessage> messages;
  String? adminName;
  String? adminImage;
  bool isResolved;

  SupportTicket({
    this.id,
    required this.subject,
    required this.description,
    required this.category,
    this.priority = TicketPriority.medium,
    this.status = TicketStatus.open,
    this.attachments = const [],
    required this.createdAt,
    required this.updatedAt,
    this.messages = const [],
    this.adminName,
    this.adminImage,
    this.isResolved = false,
  });

  factory SupportTicket.fromJson(Map<String, dynamic> json) {
    return SupportTicket(
      id: json['id'],
      subject: json['subject'],
      description: json['description'],
      category: TicketCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => TicketCategory.general,
      ),
      priority: TicketPriority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => TicketPriority.medium,
      ),
      status: TicketStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TicketStatus.open,
      ),
      attachments: List<String>.from(json['attachments'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      messages: List<SupportMessage>.from(
        (json['messages'] ?? []).map((x) => SupportMessage.fromJson(x)),
      ),
      adminName: json['adminName'],
      adminImage: json['adminImage'],
      isResolved: json['isResolved'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'description': description,
      'category': category.name,
      'priority': priority.name,
      'attachments': attachments,
    };
  }

  SupportTicket copyWith({
    String? id,
    String? subject,
    String? description,
    TicketCategory? category,
    TicketPriority? priority,
    TicketStatus? status,
    List<String>? attachments,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<SupportMessage>? messages,
    String? adminName,
    String? adminImage,
    bool? isResolved,
  }) {
    return SupportTicket(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      attachments: attachments ?? this.attachments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      messages: messages ?? this.messages,
      adminName: adminName ?? this.adminName,
      adminImage: adminImage ?? this.adminImage,
      isResolved: isResolved ?? this.isResolved,
    );
  }
}

enum TicketCategory {
  general,
  order,
  delivery,
  payment,
  clothing,
  travel,
  refund,
  account,
  technical,
}

enum TicketPriority { low, medium, high, urgent }

enum TicketStatus { open, inProgress, resolved, closed }

extension TicketCategoryExtension on TicketCategory {
  String get displayName {
    switch (this) {
      case TicketCategory.order:
        return 'Order Issue';
      case TicketCategory.delivery:
        return 'Delivery';
      case TicketCategory.payment:
        return 'Payment';
      case TicketCategory.clothing:
        return 'Clothing';
      case TicketCategory.travel:
        return 'Travel';
      case TicketCategory.refund:
        return 'Refund';
      case TicketCategory.account:
        return 'Account';
      case TicketCategory.technical:
        return 'Technical';
      default:
        return 'General Inquiry';
    }
  }

  IconData get icon {
    switch (this) {
      case TicketCategory.order:
        return Icons.shopping_bag;
      case TicketCategory.delivery:
        return Icons.local_shipping;
      case TicketCategory.payment:
        return Icons.payment;
      case TicketCategory.clothing:
        return Icons.checkroom;
      case TicketCategory.travel:
        return Icons.flight_takeoff;
      case TicketCategory.refund:
        return Icons.money_off;
      case TicketCategory.account:
        return Icons.person;
      case TicketCategory.technical:
        return Icons.computer;
      default:
        return Icons.help_outline;
    }
  }
}

extension TicketPriorityExtension on TicketPriority {
  Color get color {
    switch (this) {
      case TicketPriority.low:
        return Colors.green;
      case TicketPriority.medium:
        return Colors.orange;
      case TicketPriority.high:
        return Colors.red;
      case TicketPriority.urgent:
        return Colors.purple;
    }
  }

  String get displayName {
    switch (this) {
      case TicketPriority.low:
        return 'Low';
      case TicketPriority.medium:
        return 'Medium';
      case TicketPriority.high:
        return 'High';
      case TicketPriority.urgent:
        return 'Urgent';
    }
  }
}

extension TicketStatusExtension on TicketStatus {
  Color get color {
    switch (this) {
      case TicketStatus.open:
        return Colors.blue;
      case TicketStatus.inProgress:
        return Colors.orange;
      case TicketStatus.resolved:
        return Colors.green;
      case TicketStatus.closed:
        return Colors.grey;
    }
  }

  String get displayName {
    switch (this) {
      case TicketStatus.open:
        return 'Open';
      case TicketStatus.inProgress:
        return 'In Progress';
      case TicketStatus.resolved:
        return 'Resolved';
      case TicketStatus.closed:
        return 'Closed';
    }
  }
}
