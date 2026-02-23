import 'package:flutter/material.dart';

class TripleSegmentButton extends StatelessWidget {
  final List<String> titles; // Tip güvenliği için String ekledik
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const TripleSegmentButton({
    super.key,
    required this.titles,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: SizedBox(
        width: double.infinity,
        child: SegmentedButton<int>(
          style: SegmentedButton.styleFrom(
            selectedBackgroundColor: const Color(0xFFFF5722),
            selectedForegroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          segments: List.generate(titles.length, (index) {
            return ButtonSegment<int>(
              value: index,
              label: Text(
                titles[index],
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            );
          }),
          selected: {selectedIndex},
          onSelectionChanged: (Set<int> newSelection) {
            onChanged(newSelection.first);
          },
          showSelectedIcon: false,
        ),
      ),
      
    );
  }
}
