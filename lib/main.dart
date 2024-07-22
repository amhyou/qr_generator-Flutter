import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const QRGeneratorApp());
}

class QRGeneratorApp extends StatelessWidget {
  const QRGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QRGeneratorHomePage(),
    );
  }
}

class QRGeneratorHomePage extends StatefulWidget {
  const QRGeneratorHomePage({super.key});

  @override
  QRGeneratorHomePageState createState() => QRGeneratorHomePageState();
}

class QRGeneratorHomePageState extends State<QRGeneratorHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _qrData = '';
  String _errorMessage = '';

  void _generateQRCode() {
    setState(() {
      if (_controller.text.isEmpty) {
        _errorMessage = 'Please enter some text or URL';
        _qrData = '';
      } else {
        _errorMessage = '';
        _qrData = _controller.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter text or URL',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateQRCode,
              child: const Text('Generate QR Code'),
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            if (_qrData.isNotEmpty)
              Center(
                child: QrImageView(
                  data: _qrData,
                  version: QrVersions.auto,
                  size: 250.0,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
              )
          ],
        ),
      ),
    );
  }
}
