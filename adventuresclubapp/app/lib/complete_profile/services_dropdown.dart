import 'package:app/models/services_cost.dart';
import 'package:flutter/material.dart';

class ServicesDropdown extends StatefulWidget {
  final List<ServicesCost> services;
  final ValueChanged<ServicesCost?> onChanged;
  final String? hintText;

  const ServicesDropdown({
    required this.services,
    required this.onChanged,
    this.hintText,
    super.key,
  });

  @override
  _ServicesDropdownState createState() => _ServicesDropdownState();
}

class _ServicesDropdownState extends State<ServicesDropdown> {
  ServicesCost? _selectedService;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 250), // Max width constraint
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ServicesCost>(
          isExpanded: true, // Takes available width
          hint: Text(widget.hintText ?? 'Select a service'),
          value: _selectedService,
          items: widget.services.map((ServicesCost service) {
            return DropdownMenuItem<ServicesCost>(
              value: service,
              child: Text(
                service.description,
                overflow: TextOverflow.ellipsis, // Handle long text
              ),
            );
          }).toList(),
          onChanged: (ServicesCost? newValue) {
            setState(() {
              _selectedService = newValue;
            });
            widget.onChanged(newValue);
          },
        ),
      ),
    );
  }
}
