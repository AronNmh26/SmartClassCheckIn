import 'package:flutter/material.dart';

import '../models/check_in.dart';
import '../services/location_service.dart';
import '../services/storage_service.dart';
import '../widgets/mood_selector.dart';
import 'qr_scan_screen.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final _prevTopicController = TextEditingController();
  final _expectedTopicController = TextEditingController();
  final _storageService = StorageService();
  final _locationService = LocationService();

  String? _classId;
  double? _lat;
  double? _lng;
  int? _moodScore;
  bool _isLocating = false;
  bool _isSaving = false;

  @override
  void dispose() {
    _prevTopicController.dispose();
    _expectedTopicController.dispose();
    super.dispose();
  }

  Future<void> _scanQr() async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const QrScanScreen()),
    );
    if (!mounted) return;
    if (result != null && result.isNotEmpty) {
      setState(() => _classId = result);
    }
  }

  Future<void> _captureLocation() async {
    setState(() => _isLocating = true);
    try {
      final position = await _locationService.getCurrentPosition();
      if (!mounted) return;
      setState(() {
        _lat = position.latitude;
        _lng = position.longitude;
      });
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLocating = false);
      }
    }
  }

  Future<void> _submit() async {
    final prevTopic = _prevTopicController.text.trim();
    final expectedTopic = _expectedTopicController.text.trim();

    if (_classId == null || _classId!.isEmpty) {
      _showError('Please scan the class QR code.');
      return;
    }
    if (_lat == null || _lng == null) {
      _showError('Please capture your location.');
      return;
    }
    if (prevTopic.isEmpty || expectedTopic.isEmpty) {
      _showError('Please answer the topic questions.');
      return;
    }
    if (_moodScore == null) {
      _showError('Please select your mood.');
      return;
    }

    setState(() => _isSaving = true);
    final checkIn = CheckIn(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      classId: _classId!,
      timestamp: DateTime.now(),
      lat: _lat!,
      lng: _lng!,
      prevTopic: prevTopic,
      expectedTopic: expectedTopic,
      moodScore: _moodScore!,
    );

    try {
      await _storageService.saveCheckIn(checkIn);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check-in saved.')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      _showError('Failed to save check-in.');
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Check-in')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Before class',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          _SectionCard(
            title: 'Step 1: Confirm presence',
            icon: Icons.location_on,
            color: colorScheme.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton.icon(
                  onPressed: _isLocating ? null : _captureLocation,
                  icon: const Icon(Icons.gps_fixed),
                  label: Text(
                    _isLocating ? 'Capturing...' : 'Capture GPS Location',
                  ),
                ),
                const SizedBox(height: 8),
                _StatusTile(
                  icon: Icons.my_location,
                  label: _lat == null
                      ? 'Location not captured'
                      : 'Location: ${_lat!.toStringAsFixed(5)}, ${_lng!.toStringAsFixed(5)}',
                  isComplete: _lat != null,
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _scanQr,
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text('Scan Class QR Code'),
                ),
                const SizedBox(height: 8),
                _StatusTile(
                  icon: Icons.qr_code,
                  label: _classId == null ? 'QR not scanned' : 'QR: $_classId',
                  isComplete: _classId != null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Step 2: Pre-class reflection',
            icon: Icons.edit_note,
            color: colorScheme.secondaryContainer,
            child: Column(
              children: [
                TextField(
                  controller: _prevTopicController,
                  decoration: const InputDecoration(
                    labelText: 'Previous class topic',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.history),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _expectedTopicController,
                  decoration: const InputDecoration(
                    labelText: 'Expected topic today',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.school),
                  ),
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Mood before class'),
                ),
                MoodSelector(
                  value: _moodScore,
                  onChanged: (value) => setState(() => _moodScore = value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _isSaving ? null : _submit,
            icon: const Icon(Icons.check_circle),
            label: Text(_isSaving ? 'Saving...' : 'Submit Check-in'),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: color,
                  child: Icon(icon, size: 18, color: Colors.black87),
                ),
                const SizedBox(width: 8),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  const _StatusTile({
    required this.icon,
    required this.label,
    required this.isComplete,
  });

  final IconData icon;
  final String label;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isComplete ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isComplete ? Colors.green.shade700 : Colors.orange.shade700,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(label)),
          Icon(
            isComplete ? Icons.check_circle : Icons.hourglass_empty,
            size: 18,
            color: isComplete ? Colors.green.shade700 : Colors.orange.shade700,
          ),
        ],
      ),
    );
  }
}
