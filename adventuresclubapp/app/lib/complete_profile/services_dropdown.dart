import 'package:app/models/services_cost.dart';
import 'package:flutter/material.dart';

class ServicesDropdown extends StatelessWidget {
  final List<ServicesCost> services;
  final ValueChanged<ServicesCost?> onChanged;
  final String? hintText;
  final ServicesCost? selectedService;
  final double? width;

  const ServicesDropdown({
    required this.services,
    required this.onChanged,
    this.hintText,
    this.selectedService,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final uniqueServices = services.toSet().toList();
    return Container(
      width: width,
      constraints: width == null ? const BoxConstraints(maxWidth: 250) : null,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ServicesCost>(
          isExpanded: true,
          hint: Text(hintText ?? 'Select a service'),
          value: selectedService,
          items: uniqueServices.map((ServicesCost service) {
            return DropdownMenuItem<ServicesCost>(
              value: service,
              child: Text(
                service.description,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
