// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:quran_app/core/widgets/app_bar.dart';
//
// import 'view_with_data.dart';
// import 'view_without_data.dart';
//
// class QiblahView extends StatefulWidget {
//   const QiblahView({Key? key}) : super(key: key);
//
//   @override
//   State<QiblahView> createState() => _QiblahViewState();
// }
//
// class _QiblahViewState extends State<QiblahView> {
//   bool hasPermission = false;
//
//   Future getPermission() async {
//     if (await Permission.location.serviceStatus.isEnabled) {
//       var status = await Permission.location.status;
//       if (status.isGranted) {
//         hasPermission = true;
//       } else {
//         Permission.location.request().then((value) {
//           setState(() {
//             hasPermission = (value == PermissionStatus.granted);
//           });
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(
//         text: "القبلة",
//         withLeading: false,
//         withActions: false,
//       ),
//       body: FutureBuilder(
//         future: getPermission(),
//         builder: (context, snapshot) {
//           if (hasPermission) {
//             return const QiblahViewWithData();
//           } else {
//             return const QiblahViewWithoutData();
//           }
//         },
//       ),
//     );
//   }
// }
