import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
    TextEditingController controller = TextEditingController();
    String dropdownValue = 'Change Language';
 List<String> list = <String>['Change Language', 'Two', 'Three', 'Four'];
     String dropdownValue1 = 'Country Location';
 List<String> list1 = <String>['Country Location', 'Two', 'Three', 'Four'];
List text = ['Privacy','Terms and Conditions','Contact us'];
bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        leading: IconButton(
            onPressed:  () => Navigator.pop(context),
            icon: Image.asset(
             'images/backArrow.png',
              height: 20,
            ),
          ),
          title: MyText(text: 'Settings',color: bluishColor,),
      
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
            children:[
              SwitchListTile(
                contentPadding: EdgeInsets.symmetric(horizontal:10),
                value: value, onChanged: (bool? value1){
                return setState(() {
                  value = value1!;
                });
              },
              title: MyText(text: 'App Notificaton',color: blackTypeColor,weight: FontWeight.w500,),
              ),
              Container(
                    
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical:0),
              
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                      isExpanded: true,
                        
                      value:dropdownValue1,
                      icon: Row(
                        children: [
                          MyText(text: 'Oman',color: blackTypeColor1,),
                           const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      elevation: 16,
                      style: const TextStyle(color: blackTypeColor,fontWeight: FontWeight.w500,fontSize: 16),
                    
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          value = value!;
                        });
                      },
                      items: list1.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
            ),
              ),
              
            const Divider(),
              Container(
                    
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
              
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                      isExpanded: true,
                        
                      value:dropdownValue,
                      icon: Row(
                        children: [
                          MyText(text: 'Eng',color: blackTypeColor1,),
                           const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      elevation: 16,
                      style: const TextStyle(color: blackTypeColor,fontWeight: FontWeight.w500,fontSize: 16),
                    
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
            ),
              ),
              
            const Divider(),
              Container(
                    
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
              
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                      isExpanded: true,
                        
                      value:dropdownValue,
                      icon: Row(
                        children: [
                          MyText(text: '\$',color: blackTypeColor1,),
                           const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      elevation: 16,
                      style: const TextStyle(color: blackTypeColor,fontWeight: FontWeight.w500,fontSize: 16),
                    
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
            ),
              ),
            const Divider(),
              Wrap(children: 
              List.generate(3, (index) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal:10,vertical: 0),
                      leading: MyText(text: text[index],color: blackTypeColor1,weight: FontWeight.w500,size: 16,),
                      
                    ),
                    const Divider()
                  ],
                );
              }),)
            ]
          ),
      ),
    );
  }
}