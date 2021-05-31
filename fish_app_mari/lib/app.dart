// import 'package:flutter/material.dart';

// import 'package:fish_app_mari/screens/home/home_screen.dart';
// import 'package:fish_app_mari/screens/post_detail/post_detail.dart';

// class MariApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'fish app MARI',
//       onGenerateRoute: (settings) {
//         switch (settings.name) {
//           case PostDetailScreen.route:
//             final PostDetailScreenArguments arguments = settings.arguments;
//             return MaterialPageRoute(
//                 builder: (context) => PostDetailScreen(
//                       postId: arguments.id,
//                     ));
//             break;
//           default:
//             return MaterialPageRoute(builder: (context) => HomeScreen());
//         }
//       },
//     );
//   }
// }
