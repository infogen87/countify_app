// import 'package:countify/pages/edit_countpage.dart';
// import 'package:countify/providers/setting_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class DefaultStylePickerDialog extends StatefulWidget {
//   const DefaultStylePickerDialog({super.key});

//   @override
//   State<DefaultStylePickerDialog> createState() => _DefaultStylePickerDialogState();
// }

// class _DefaultStylePickerDialogState extends State<DefaultStylePickerDialog> {
//   @override
//   Widget build(BuildContext context) {
//     final selectedStyle = context.watch<SettingsProvider>().defaultCounterStyle;
//     return Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text("select default counter style", style: TextStyle()),
//               const SizedBox(height: 20),
//               SizedBox(
//                 height: 160,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: counterPageStyles.length,
//                   itemBuilder: (context, indexStyle) {
//                     final style = counterPageStyles[indexStyle];
//                     final isSelected = selectedStyle == style["key"];

//                     return GestureDetector(
//                       onTap: () {
//                         context.read<SettingsProvider>().setDefaultCounterStyle(
//                           style["key"]!
//                         );
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         width: 100,
//                         margin: const EdgeInsets.only(right: 15),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: isSelected
//                                 ? Colors.purple
//                                 : Colors.green,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.dashboard_customize,
//                               color: isSelected
//                                   ? Colors.purple
//                                   : Colors.green,
//                             ),
//                             const SizedBox(height: 6),
//                             Text(
//                               style["name"]!,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontWeight: isSelected
//                                     ? FontWeight.bold
//                                     : FontWeight.normal,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//   }

// }
