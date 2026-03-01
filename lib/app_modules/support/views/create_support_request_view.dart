// // views/create_support_request_view.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:travel_clothing_club_flutter/app_modules/support/model/support_request_model.dart';
// import '../controllers/support_controller.dart';
//
// class CreateSupportRequestView extends StatefulWidget {
//   const CreateSupportRequestView({super.key});
//
//   @override
//   State<CreateSupportRequestView> createState() =>
//       _CreateSupportRequestViewState();
// }
//
// class _CreateSupportRequestViewState extends State<CreateSupportRequestView> {
//   final SupportController controller = Get.find<SupportController>();
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _subjectController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//
//   String _selectedCategory = 'account';
//   SupportPriority _selectedPriority = SupportPriority.medium;
//
//   @override
//   void dispose() {
//     _subjectController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('New Support Request'),
//         backgroundColor: Colors.purple,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Category Selection
//               _buildSectionHeader('Category'),
//               const SizedBox(height: 12),
//               _buildCategorySelection(),
//               const SizedBox(height: 24),
//
//               // Priority Selection
//               _buildSectionHeader('Priority'),
//               const SizedBox(height: 12),
//               _buildPrioritySelection(),
//               const SizedBox(height: 24),
//
//               // Subject
//               _buildSectionHeader('Subject *'),
//               const SizedBox(height: 12),
//               _buildSubjectField(),
//               const SizedBox(height: 24),
//
//               // Description
//               _buildSectionHeader('Description *'),
//               const SizedBox(height: 12),
//               _buildDescriptionField(),
//               const SizedBox(height: 32),
//
//               // Submit Button
//               Obx(() => _buildSubmitButton()),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//         color: Colors.black87,
//       ),
//     );
//   }
//
//   Widget _buildCategorySelection() {
//     return Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children: controller.categories.map((category) {
//         return FilterChip(
//           label: Text(category.displayName),
//           selected: _selectedCategory == category,
//           onSelected: (selected) {
//             setState(() {
//               _selectedCategory = category;
//             });
//           },
//           selectedColor: Colors.purple.withOpacity(0.2),
//           checkmarkColor: Colors.purple,
//           labelStyle: TextStyle(
//             color: _selectedCategory == category
//                 ? Colors.purple
//                 : Colors.black87,
//             fontWeight: FontWeight.w500,
//           ),
//           avatar: Icon(
//             category.icon,
//             size: 16,
//             color: _selectedCategory == category ? Colors.purple : Colors.grey,
//           ),
//           shape: StadiumBorder(
//             side: BorderSide(
//               color: _selectedCategory == category
//                   ? Colors.purple
//                   : Colors.grey.shade300,
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildPrioritySelection() {
//     return Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children: SupportPriority.values.map((priority) {
//         return FilterChip(
//           label: Text(priority.name.toUpperCase()),
//           selected: _selectedPriority == priority,
//           onSelected: (selected) {
//             setState(() {
//               _selectedPriority = priority;
//             });
//           },
//           selectedColor: _getPriorityColor(priority).withOpacity(0.2),
//           checkmarkColor: _getPriorityColor(priority),
//           labelStyle: TextStyle(
//             color: _selectedPriority == priority
//                 ? _getPriorityColor(priority)
//                 : Colors.black87,
//             fontWeight: FontWeight.w500,
//             fontSize: 12,
//           ),
//           shape: StadiumBorder(
//             side: BorderSide(
//               color: _selectedPriority == priority
//                   ? _getPriorityColor(priority)
//                   : Colors.grey.shade300,
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Color _getPriorityColor(SupportPriority priority) {
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
//   Widget _buildSubjectField() {
//     return TextFormField(
//       controller: _subjectController,
//       decoration: InputDecoration(
//         hintText: 'Briefly describe your issue...',
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         prefixIcon: const Icon(Icons.subject),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter a subject';
//         }
//         if (value.length < 5) {
//           return 'Subject must be at least 5 characters';
//         }
//         return null;
//       },
//     );
//   }
//
//   Widget _buildDescriptionField() {
//     return TextFormField(
//       controller: _descriptionController,
//       maxLines: 6,
//       decoration: InputDecoration(
//         hintText: 'Please provide detailed information about your issue...',
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         alignLabelWithHint: true,
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please describe your issue';
//         }
//         if (value.length < 20) {
//           return 'Please provide more details (at least 20 characters)';
//         }
//         return null;
//       },
//     );
//   }
//
//   Widget _buildSubmitButton() {
//     if (controller.isSubmitting.value) {
//       return Container(
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         decoration: BoxDecoration(
//           color: Colors.grey.shade100,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 20,
//               height: 20,
//               child: CircularProgressIndicator(strokeWidth: 2),
//             ),
//             SizedBox(width: 12),
//             Text(
//               'Submitting Request...',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         // onPressed: _submitRequest,
//         onPressed: () {  },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.purple,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//
//         child: const Text(
//           'Submit Support Request',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//       ),
//     );
//   }
//
//   // void _submitRequest() {
//   //   if (_formKey.currentState!.validate()) {
//   //     controller.submitSupportRequest(
//   //       subject: _subjectController.text.trim(),
//   //       description: _descriptionController.text.trim(),
//   //       category: _selectedCategory,
//   //       priority: _selectedPriority,
//   //     );
//   //   }
//   // }
// }
