import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class DropdownWithTI extends StatefulWidget {
  final text;
  final bool expanded;
  const DropdownWithTI(this.text,this.expanded,{super.key});

  @override
  State<DropdownWithTI> createState() => _DropdownWithTIState();
}

class _DropdownWithTIState extends State<DropdownWithTI> {
   String dropdownValue = 'One';
   List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  @override
  Widget build(BuildContext context) {
    return Container(
                  
          padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 0),
            
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          
          ),
          child: DropdownButton<String>(
                  isExpanded: widget.expanded,
                    
                  value:dropdownValue,
                  icon:  const Icon(Icons.arrow_drop_down),
                  
                  elevation: 16,
                  style: const TextStyle(color: blackTypeColor,fontWeight: FontWeight.w500),
                
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      value = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
            );
  }
}