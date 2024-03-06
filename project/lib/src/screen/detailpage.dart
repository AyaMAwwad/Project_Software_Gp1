import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/src/screen/categorylist.dart';

class DetailPage extends StatefulWidget {
  final String   categoryName;
  final List<String> imagePaths;

  DetailPage({required this.categoryName, required this.imagePaths});
  //Category.name = categoryName;
  String get catoryname => categoryName;
  @override
  _DetailPageState createState() => _DetailPageState();


  
}

class _DetailPageState extends State<DetailPage> {
  int selectedDotIndex = 0;
//String name = DetailPage.getname() ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  widget.imagePaths[selectedDotIndex],
                  fit: BoxFit.cover,
                  height: 400,
                ),
              ),
            ),
            SizedBox(height: 5),
           // Text('hiiiiiiiii'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.imagePaths.length,
                (index) => DotWidget(
                  dotIndex: index,
                  isSelected: index == selectedDotIndex,
                  onTap: () {
                    setState(() {
                      selectedDotIndex = index;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
             // child: Padding(padding: padding)
             // Text(''),
             // Padding(padding: EdgeInsets.all(10),
             // Text(''),
              
              textjacket(),
              
             // ),
              
              ],
              
              
              //Text('hghgghghh'),
              ),
            
          ],
        ),
      ),
      //Text(),
    );
  }

  ///
  
textjacket(){
  String rr = widget.catoryname;
  return Padding(padding: EdgeInsets.all(10.0),
  child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    //  Padding(
     //   padding: EdgeInsets.all(18.0),
       // child: ClipRRect(
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          '$rr',
          style: TextStyle(
            color: Color.fromARGB(255, 101, 27, 27),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        
        
        
        ),
         ),
         SizedBox(height: 5,),
         Padding(padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Text('Color same as picture', style: TextStyle(fontSize: 16
        ),
        
        ),
         ),
         SizedBox(height: 5,),
         Padding(padding: EdgeInsets.symmetric(horizontal: 5.0),
        child:
        Text('The jacket is light and sweet',style: TextStyle(fontSize: 16),),),
        ],
        ),
    
      //),
    ],
  ),
  );
}
}

class DotWidget extends StatelessWidget {
  final int dotIndex;
  final bool isSelected;
  final VoidCallback onTap;

  DotWidget({
    required this.dotIndex,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.grey,
          shape: BoxShape.circle,
        ),
        margin: EdgeInsets.symmetric(horizontal: 5),
      ),
    );
  }
}
