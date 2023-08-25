import 'package:er_front/screens/hospital_join_screen.dart';
import 'package:er_front/screens/join_screen.dart';
import 'package:er_front/screens/patient_join_screen.dart';
import 'package:flutter/material.dart';
import 'package:er_front/screens/detail_screen.dart';
import 'package:er_front/screens/login_screen.dart';
import 'package:er_front/screens/map_screen.dart';
import 'package:er_front/screens/reservation_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login_screen',
      routes: {
        '/login_screen': (context) => const LoginScreen(),
        '/join_screen': (context) => const JoinScreen(),
        '/patient_join_screen': (context) => const PatientJoinScreen(),
        '/hospital_join_screen': (context) => const HospitalJoinScreen(),
        '/detail_screen': (context) => const DetailScreen(),
        '/map_screen': (context) => const MapScreen(),
        '/reservation_screen': (context) => const ReservationScreen(),
      },
      title: 'ER',
    );
  }
}
