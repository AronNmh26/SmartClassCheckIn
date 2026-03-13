import 'package:flutter/material.dart';

class MoodSelector extends StatelessWidget {
  const MoodSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final int? value;
  final ValueChanged<int?> onChanged;

  static const _options = <_MoodOption>[
    _MoodOption(1, '😡', 'Very negative', Color(0xFFFFCDD2)),
    _MoodOption(2, '🙁', 'Negative', Color(0xFFFFE0B2)),
    _MoodOption(3, '😐', 'Neutral', Color(0xFFFFF9C4)),
    _MoodOption(4, '🙂', 'Positive', Color(0xFFC8E6C9)),
    _MoodOption(5, '😄', 'Very positive', Color(0xFFB3E5FC)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _options
          .map(
            (option) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: option.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: RadioListTile<int>(
                title: Text('${option.emoji}  ${option.label}'),
                value: option.score,
                groupValue: value,
                onChanged: onChanged,
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _MoodOption {
  const _MoodOption(this.score, this.emoji, this.label, this.color);

  final int score;
  final String emoji;
  final String label;
  final Color color;
}
