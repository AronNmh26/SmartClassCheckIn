import 'package:flutter/material.dart';

import '../services/storage_service.dart';
import 'checkin_screen.dart';
import 'finish_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _storageService = StorageService();
  late Future<_Counts> _countsFuture;

  @override
  void initState() {
    super.initState();
    _countsFuture = _loadCounts();
  }

  Future<_Counts> _loadCounts() async {
    final checkIns = await _storageService.getCheckInCount();
    final checkOuts = await _storageService.getCheckOutCount();
    return _Counts(checkIns: checkIns, checkOuts: checkOuts);
  }

  Future<void> _openCheckIn() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CheckInScreen()),
    );
    if (!mounted) return;
    setState(() => _countsFuture = _loadCounts());
  }

  Future<void> _openFinish() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const FinishScreen()),
    );
    if (!mounted) return;
    setState(() => _countsFuture = _loadCounts());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Class Check-in')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary,
                  colorScheme.primaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.school, color: Colors.white, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Check in before class and reflect after class.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder<_Counts>(
                future: _countsFuture,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  final checkIns = data?.checkIns ?? 0;
                  final checkOuts = data?.checkOuts ?? 0;
                  return Row(
                    children: [
                      Expanded(
                        child: _CountTile(
                          icon: Icons.how_to_reg,
                          label: 'Check-ins',
                          value: checkIns,
                          color: colorScheme.primaryContainer,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _CountTile(
                          icon: Icons.fact_check,
                          label: 'Completions',
                          value: checkOuts,
                          color: colorScheme.secondaryContainer,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Check-in'),
              subtitle: const Text('Record location, scan QR, and mood'),
              trailing: const Icon(Icons.chevron_right),
              onTap: _openCheckIn,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Finish Class'),
              subtitle: const Text('Scan QR and submit reflection'),
              trailing: const Icon(Icons.chevron_right),
              onTap: _openFinish,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountTile extends StatelessWidget {
  const _CountTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelMedium),
              Text(
                value.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Counts {
  _Counts({required this.checkIns, required this.checkOuts});

  final int checkIns;
  final int checkOuts;
}
