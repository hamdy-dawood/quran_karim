// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:quran_app/core/theming/colors.dart';
//
// class QiblahViewWithoutData extends StatelessWidget {
//   const QiblahViewWithoutData({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Center(
//           child: Text(
//             'Please Allow Location',
//             style: TextStyle(
//               fontSize: 22,
//               color: Theme.of(context).textTheme.bodyLarge?.color,
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 30,
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: ColorManager.orangeColor,
//             elevation: 0.0,
//           ),
//           onPressed: () {
//             openAppSettings();
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Allow',
//               style: TextStyle(color: ColorManager.white, fontSize: 20),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
