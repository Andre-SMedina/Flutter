import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  final List<CameraDescription> cameras;
  const CameraApp({super.key, required this.cameras});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;
  Uint8List? capturedImage;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    try {
      if (!controller.value.isInitialized) {
        print('A câmera não está inicializada');
        return;
      }

      if (controller.value.isTakingPicture) {
        // Se já estiver tirando uma foto, saia
        return;
      }

      final XFile imageFile = await controller.takePicture();
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('capturedImage', base64Image);

      setState(() {
        capturedImage = bytes;
      });
    } catch (e) {
      print('Erro ao capturar a imagem: $e');
    }
  }

  /// **Função para mostrar a imagem capturada**
  Future<void> _showCapturedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final base64Image = prefs.getString('capturedImage');

    if (base64Image != null) {
      final bytes = base64Decode(base64Image);
      setState(() {
        capturedImage = bytes;
      });
    } else {
      print('Nenhuma imagem capturada encontrada.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Capturar Imagem pela Câmera'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (controller.value.isInitialized)
                Container(
                  height: 400, // Definindo a altura explicitamente
                  width: 400, // Definindo a largura explicitamente
                  child: CameraPreview(controller),
                )
              else
                const Center(
                  child: CircularProgressIndicator(),
                ),
              if (capturedImage != null)
                Container(
                    margin: const EdgeInsets.only(top: 15),
                    height: 400,
                    width: 400,
                    child: Image.memory(
                      capturedImage!,
                      fit: BoxFit.cover,
                    )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _captureImage,
                  child: const Text('Capturar Imagem'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _showCapturedImage,
                  child: const Text('Mostrar Imagem Capturada'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
