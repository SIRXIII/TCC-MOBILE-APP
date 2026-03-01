
import '../../../../utils/app_imports.dart';

enum OrderStatus {
  pending,
  approved,
  processing,
  shipped,
  delivered,
  cancelled,
  returned,
  refunded,
  active,
  refund_requested,
  return_requested;
  // pending,approved,processing,shipped,delivered,cancelled,returned,refunded
  // return_requested, returned, refund_requested, refunded

  // 🔸 Return enum value as string
  String get value {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.approved:
        return 'Approved';
      case OrderStatus.active:
        return 'Active';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
      case OrderStatus.returned:
        return 'Returned';
      case OrderStatus.refund_requested:
        return 'Refund requested';
      case OrderStatus.return_requested:
        return 'Return requested';
      case OrderStatus.refunded:
        return 'Refunded';
    }
  }

  // 🔸 Convert string to enum (from API)
  static OrderStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return OrderStatus.pending;
      case 'approved':
        return OrderStatus.approved;
      case 'active':
        return OrderStatus.active;
      case 'processing':
        return OrderStatus.processing;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      case 'returned':
        return OrderStatus.returned;
      case 'refunded':
        return OrderStatus.refunded;

      case 'Refund_requested':
        return OrderStatus.refund_requested;
      case 'Return_requested':
        return OrderStatus.return_requested;
      default:
        return OrderStatus.pending;
    }
  }

  // Get status color
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.blue;
      case 'processing':
        return Colors.amber;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'returned':
        return Colors.deepOrange;
      case 'refunded':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  static String getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'approved':
        return 'Approved';
      case 'processing':
        return 'Processing';
      case 'shipped':
        return 'Shipped';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      case 'returned':
        return 'Returned';
      case 'refunded':
        return 'Refunded';
      case 'return_requested':
        return 'Return requested';
      case 'refund_requested':
        return 'Refund requested';
      default:
        return 'Unknown';
    }
  }
}
