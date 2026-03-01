// // views/support_requests_list_view.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:travel_clothing_club_flutter/app_modules/support/model/support_request_model.dart';
// import 'package:travel_clothing_club_flutter/app_modules/support/views/create_support_request_view.dart';
// import '../controllers/support_controller.dart';
//
// class SupportRequestsListView extends StatelessWidget {
//   SupportRequestsListView({super.key});
//
//   final SupportController controller = Get.find<SupportController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Support Requests'),
//         backgroundColor: Colors.purple,
//         foregroundColor: Colors.white,
//         actions: [
//           Obx(() {
//             if (controller.openRequestsCount > 0) {
//               return Badge(
//                 label: Text(controller.openRequestsCount.toString()),
//                 child: IconButton(
//                   icon: const Icon(Icons.support_agent),
//                   onPressed: () {},
//                   tooltip: 'Open Requests',
//                 ),
//               );
//             }
//             return const SizedBox();
//           }),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return _buildLoadingState();
//         }
//
//         if (controller.supportRequests.isEmpty) {
//           return _buildEmptyState();
//         }
//
//         return _buildSupportRequestsList();
//       }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Get.to(() => CreateSupportRequestView()),
//         backgroundColor: Colors.purple,
//         foregroundColor: Colors.white,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   Widget _buildLoadingState() {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(),
//           SizedBox(height: 16),
//           Text(
//             'Loading support requests...',
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.support_agent, size: 80, color: Colors.grey.shade400),
//           const SizedBox(height: 20),
//           const Text(
//             'No Support Requests',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             'Create your first support request to get help',
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//           const SizedBox(height: 30),
//           ElevatedButton(
//             onPressed: () => Get.to(() => CreateSupportRequestView()),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.purple,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//             ),
//             child: const Text('Create Request'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSupportRequestsList() {
//     final openRequests = controller.openRequests;
//     final resolvedRequests = controller.resolvedRequests;
//
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         // Open Requests Section
//         if (openRequests.isNotEmpty) ...[
//           _buildSectionHeader('Active Requests', openRequests.length),
//           const SizedBox(height: 12),
//           ...openRequests.map((request) => _buildSupportRequestCard(request)),
//           const SizedBox(height: 24),
//         ],
//
//         // Resolved Requests Section
//         if (resolvedRequests.isNotEmpty) ...[
//           _buildSectionHeader('Resolved Requests', resolvedRequests.length),
//           const SizedBox(height: 12),
//           ...resolvedRequests.map(
//             (request) => _buildSupportRequestCard(request),
//           ),
//         ],
//       ],
//     );
//   }
//
//   Widget _buildSectionHeader(String title, int count) {
//     return Row(
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(width: 8),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade300,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Text(
//             count.toString(),
//             style: const TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: Colors.black87,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSupportRequestCard(SupportRequest request) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header with Category and Status
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       width: 32,
//                       height: 32,
//                       decoration: BoxDecoration(
//                         color: Colors.purple.withOpacity(0.1),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         request.category.icon,
//                         size: 16,
//                         color: Colors.purple,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       request.category.displayName,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: request.statusColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: request.statusColor),
//                   ),
//                   child: Text(
//                     request.statusText,
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w600,
//                       color: request.statusColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//
//             // Subject
//             Text(
//               request.subject,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 8),
//
//             // Description Preview
//             Text(
//               request.description,
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey,
//                 height: 1.4,
//               ),
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 12),
//
//             // Footer with Priority and Date
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 6,
//                         vertical: 2,
//                       ),
//                       decoration: BoxDecoration(
//                         color: request.priorityColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Text(
//                         request.priorityText,
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600,
//                           color: request.priorityColor,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       request.formattedDate,
//                       style: const TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//                 PopupMenuButton<String>(
//                   icon: const Icon(
//                     Icons.more_vert,
//                     size: 16,
//                     color: Colors.grey,
//                   ),
//                   onSelected: (value) => _handleRequestAction(value, request),
//                   itemBuilder: (context) => [
//                     if (request.status == SupportStatus.open)
//                       const PopupMenuItem(
//                         value: 'mark_in_progress',
//                         child: Row(
//                           children: [
//                             Icon(Icons.update, size: 16),
//                             SizedBox(width: 8),
//                             Text('Mark as In Progress'),
//                           ],
//                         ),
//                       ),
//                     if (request.status != SupportStatus.resolved &&
//                         request.status != SupportStatus.closed)
//                       const PopupMenuItem(
//                         value: 'mark_resolved',
//                         child: Row(
//                           children: [
//                             Icon(Icons.check_circle, size: 16),
//                             SizedBox(width: 8),
//                             Text('Mark as Resolved'),
//                           ],
//                         ),
//                       ),
//                     const PopupMenuItem(
//                       value: 'view_details',
//                       child: Row(
//                         children: [
//                           Icon(Icons.visibility, size: 16),
//                           SizedBox(width: 8),
//                           Text('View Details'),
//                         ],
//                       ),
//                     ),
//                     const PopupMenuItem(
//                       value: 'delete',
//                       child: Row(
//                         children: [
//                           Icon(Icons.delete, size: 16, color: Colors.red),
//                           SizedBox(width: 8),
//                           Text('Delete', style: TextStyle(color: Colors.red)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//
//             // Admin Response (if available)
//             if (request.adminResponse != null) ...[
//               const SizedBox(height: 12),
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.green.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.green.withOpacity(0.3)),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Support Response:',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.green,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       request.adminResponse!,
//                       style: const TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
