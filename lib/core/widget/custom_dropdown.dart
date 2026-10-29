import 'package:flutter/material.dart';
import '../app_colors.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String hintText;
  final String? value;
  final List<String> items;
  final void Function(String?)? onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label di atas dropdown
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        // Dropdown kotak
        Container(
          height: 48, // Samakan tingginya dengan TextField
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.muted, size: 20),
              hint: Text(
                hintText,
                style: const TextStyle(fontSize: 13, color: AppColors.hint),
              ),
              style: const TextStyle(fontSize: 13, color: AppColors.textDark),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
