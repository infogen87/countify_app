// import 'package:countify/providers/count_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class FlipTallyStyle extends StatelessWidget {
//   final CounterItem item;
//   final int index;

//   const FlipTallyStyle({super.key, required this.index, required this.item});

//   // Helper function for the Retro Style
//   Widget _buildMetalButton(IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.grey[400],
//           gradient: LinearGradient(
//             colors: [Colors.grey[300]!, Colors.grey[600]!],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.5),
//               offset: const Offset(2, 2),
//               blurRadius: 4,
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.black87),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController countValueController = TextEditingController(
//       text: item.value.toString(),
//     );
//     return Container(
//       color: const Color(0xFF1A1A1A), // Dark Background
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // The "Mechanical" Number Card
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey[800]!, width: 2),
//               ),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (dialogContext) {
//                           return AlertDialog(
//                             title: Text("Set Value"),
//                             content: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text("set the initial number of your count"),
//                                 TextField(
//                                   keyboardType: TextInputType.number,
//                                   controller: countValueController,
//                                   decoration: const InputDecoration(
//                                     border: OutlineInputBorder(),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   int? newValue = int.tryParse(
//                                     countValueController.text,
//                                   );

//                                   if (newValue != null) {
//                                     context
//                                         .read<CountProvider>()
//                                         .setInitialValue(newValue, index);
//                                     Navigator.pop(dialogContext);
//                                     countValueController.clear();
//                                   }
//                                 },
//                                 child: Text("Set"),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(dialogContext);
//                                 },
//                                 child: Text("Close"),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     child: Text(
//                       item.value.toString(),
//                       // item.value.toString().padLeft(3, '0'), // 001, 002...
//                       style: const TextStyle(
//                         fontSize: 100,
//                         color: Colors.white,
//                         fontFamily: 'Courier', // Or any Monospace font
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   // The "Flip" Line
//                   Container(height: 2, width: 200, color: Colors.white10),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 50),
//             // Small Metal-style Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildMetalButton(
//                   Icons.remove,
//                   () => context.read<CountProvider>().decrementCount(index),
//                 ),
//                 _buildMetalButton(
//                   Icons.add,
//                   () => context.read<CountProvider>().incrementCount(index),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:countify/providers/count_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class FlipTallyStyle extends StatelessWidget {
//   final CounterItem item;
//   final int index;

//   const FlipTallyStyle({super.key, required this.index, required this.item});

//   // Helper function for the Brushed Metal Button (Light Theme Variant)
//   Widget _buildMetalButton(IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.grey[200],
//           gradient: LinearGradient(
//             colors: [Colors.white, Colors.grey[400]!],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.2),
//               offset: const Offset(2, 4),
//               blurRadius: 6,
//             ),
//             BoxShadow(
//               color: Colors.white,
//               offset: const Offset(-2, -2),
//               blurRadius: 4,
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.black87),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController countValueController = TextEditingController(
//       text: item.value.toString(),
//     );
//     return Container(
//       color: const Color(0xFFECEFF1), // Light, clean backdrop background
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // The "Mechanical" Number Card (Maintains high contrast dark card)
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF151515), // Deep matte black card
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey[400]!, width: 2),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.15),
//                     offset: const Offset(0, 8),
//                     blurRadius: 16,
//                   ),
//                 ],
//               ),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (dialogContext) {
//                           return AlertDialog(
//                             title: const Text("Set Value"),
//                             content: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Text("set the initial number of your count"),
//                                 const SizedBox(height: 10),
//                                 TextField(
//                                   keyboardType: TextInputType.number,
//                                   controller: countValueController,
//                                   decoration: const InputDecoration(
//                                     border: OutlineInputBorder(),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   int? newValue = int.tryParse(
//                                     countValueController.text,
//                                   );

//                                   if (newValue != null) {
//                                     context
//                                         .read<CountProvider>()
//                                         .setInitialValue(newValue, index);
//                                     Navigator.pop(dialogContext);
//                                     countValueController.clear();
//                                   }
//                                 },
//                                 child: const Text("Set"),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(dialogContext);
//                                 },
//                                 child: const Text("Close"),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     child: Text(
//                       item.value.toString(),
//                       style: const TextStyle(
//                         fontSize: 100,
//                         color: Colors.white, // High contrast text match
//                         fontFamily: 'Courier', 
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   // The "Flip" Mechanical Split Line
//                   Container(height: 2, width: 200, color: Colors.white24),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 50),
//             // Brushed Silver Control Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildMetalButton(
//                   Icons.remove,
//                   () => context.read<CountProvider>().decrementCount(index),
//                 ),
//                 _buildMetalButton(
//                   Icons.add,
//                   () => context.read<CountProvider>().incrementCount(index),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
