import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista de pacientes de ejemplo con diferentes nombres
  final List<Map<String, String>> pacientesDemo = [
    {
      'nombre': 'Luis Torres',
      'motivo': 'Control de presión',
      'fecha': '2025-09-30',
    },
    {
      'nombre': 'Camila Ortiz',
      'motivo': 'Chequeo dental',
      'fecha': '2025-08-30',
    },
    {
      'nombre': 'Andrés Navarro',
      'motivo': 'Consulta de rutina',
      'fecha': '2025-10-01',
    },
    {
      'nombre': 'Paula Medina',
      'motivo': 'Dolor abdominal',
      'fecha': '2025-10-02',
    },
    {
      'nombre': 'Roberto Díaz',
      'motivo': 'Control médico',
      'fecha': '2025-10-03',
    },
    {
      'nombre': 'Fernanda Silva',
      'motivo': 'Chequeo anual',
      'fecha': '2025-10-04',
    },
    {
      'nombre': 'Jorge Castillo',
      'motivo': 'Seguimiento tratamiento',
      'fecha': '2025-10-05',
    },
    {
      'nombre': 'Natalia Vega',
      'motivo': 'Consulta especializada',
      'fecha': '2025-10-06',
    },
    {
      'nombre': 'Sebastián Rojas',
      'motivo': 'Exámenes de laboratorio',
      'fecha': '2025-10-07',
    },
    {
      'nombre': 'Gabriela Flores',
      'motivo': 'Terapia psicológica',
      'fecha': '2025-10-08',
    },
    {
      'nombre': 'Ricardo Moreno',
      'motivo': 'Consulta prenatal',
      'fecha': '2025-10-09',
    },
  ];

  Future<void> _guardaCitasDemo(BuildContext context) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final batch = firestore.batch(); // Usamos batch para múltiples escrituras

      // Crear referencias para cada documento
      for (final paciente in pacientesDemo) {
        final docRef = firestore.collection('DocApp').doc();
        batch.set(docRef, {
          'paciente': paciente['nombre'],
          'motivo': paciente['motivo'],
          'fecha': paciente['fecha'],
          'creadoEn': FieldValue.serverTimestamp(),
        });
      }

      // Ejecutar el batch (todas las escrituras en una sola operación)
      await batch.commit();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('10 citas demo guardadas exitosamente')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al guardar citas: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Firebase')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _guardaCitasDemo(context),
          child: const Text('Guardar cita demo'),
        ),
      ),
    );
  }
}
