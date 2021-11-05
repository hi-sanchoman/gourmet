
// import 'package:esentai/utils/themes/default.dart';
// import 'package:esentai/widgets/default_input_field_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AddNewAddressScreen extends StatefulWidget {
//   AddNewAddressScreen({Key? key}) : super(key: key);

//   @override
//   _AddNewAaddressScreenWidgetState createState() =>
//       _AddNewAaddressScreenWidgetState();
// }

// class _AddNewAaddressScreenWidgetState
//     extends State<AddNewAddressScreen> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Color(0xFFFCFCFC),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             ListView(
//               padding: EdgeInsets.zero,
//               scrollDirection: Axis.vertical,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 24,
//                   child: Stack(
//                     alignment: AlignmentDirectional(0, 0),
//                     children: [
//                       Align(
//                         alignment: AlignmentDirectional(-1, 0),
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
//                           child: Icon(
//                             Icons.close_rounded,
//                             color: Colors.black,
//                             size: 24,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         'Добавить новую карту',
//                         textAlign: TextAlign.center,
//                         style: DefaultAppTheme.title2.override(
//                           fontFamily: 'Gilroy',
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(16, 50, 16, 0),
//                   child: DefaultInputFieldWidget(
//                     label: 'Номер карты',
//                     hint: '**** — **** — **** — ****',
//                     color: Color(0x00000000),
//                     errorColor: Color(0x00000000),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(16, 50, 16, 0),
//                   child: DefaultInputFieldWidget(
//                     label: 'Срок действия',
//                     hint: 'мм/гг',
//                     color: Color(0x00000000),
//                     errorColor: Color(0x00000000),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(16, 50, 16, 0),
//                   child: DefaultInputFieldWidget(
//                     label: 'Код с обратной стороны карты',
//                     hint: 'cvv/cvc',
//                     color: Color(0x00000000),
//                     errorColor: Color(0x00000000),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
