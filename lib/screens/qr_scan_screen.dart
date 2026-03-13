import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  final MobileScannerController _controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  bool _found = false;
  bool _isStarting = false;

  Future<void> _startScanner() async {
    if (_isStarting) return;
    setState(() => _isStarting = true);
    try {
      await _controller.start();
    } finally {
      if (mounted) {
        setState(() => _isStarting = false);
      }
    }
  }

  Future<void> _toggleTorch() async {
    await _controller.toggleTorch();
    if (mounted) setState(() {});
  }

  Future<void> _switchCamera() async {
    await _controller.switchCamera();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _enterCodeManually() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter QR code'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Class or session ID',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (!mounted) return;
    if (result != null && result.isNotEmpty) {
      Navigator.of(context).pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            onPressed: _toggleTorch,
            icon: ValueListenableBuilder<TorchState>(
              valueListenable: _controller.torchState,
              builder: (context, state, child) {
                return Icon(
                  state == TorchState.on ? Icons.flash_on : Icons.flash_off,
                );
              },
            ),
            tooltip: 'Toggle flash',
          ),
          IconButton(
            onPressed: _switchCamera,
            icon: ValueListenableBuilder<CameraFacing>(
              valueListenable: _controller.cameraFacingState,
              builder: (context, state, child) {
                return Icon(
                  state == CameraFacing.front
                      ? Icons.camera_front
                      : Icons.camera_rear,
                );
              },
            ),
            tooltip: 'Switch camera',
          ),
          IconButton(
            onPressed: _enterCodeManually,
            icon: const Icon(Icons.keyboard),
            tooltip: 'Enter code manually',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Icon(Icons.qr_code_scanner),
                SizedBox(width: 8),
                Expanded(
                  child: Text('Align the QR code inside the frame.'),
                ),
              ],
            ),
          ),
          Expanded(
            child: MobileScanner(
              controller: _controller,
              onDetect: (capture) {
                if (_found) return;
                final barcodes = capture.barcodes;
                if (barcodes.isEmpty) return;
                final value = barcodes.first.rawValue;
                if (value == null || value.isEmpty) return;
                _found = true;
                _controller.stop();
                Navigator.of(context).pop(value);
              },
              errorBuilder: (context, error, child) {
                return _ScannerError(
                  message:
                      'Camera not available. Please allow camera access and retry.',
                  onRetry: _startScanner,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: OutlinedButton.icon(
              onPressed: _enterCodeManually,
              icon: const Icon(Icons.edit),
              label: const Text('Enter code manually'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScannerError extends StatelessWidget {
  const _ScannerError({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning_amber, size: 48, color: Colors.orange),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry camera'),
            ),
          ],
        ),
      ),
    );
  }
}
