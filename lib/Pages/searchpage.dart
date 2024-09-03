import 'package:bookstore/Pages/BooksSearchViewComp.dart';
import 'package:bookstore/global/common/AppbarComp.dart';
import 'package:bookstore/global/common/ColorPalet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  TextEditingController _searchContoler = TextEditingController();
  List<String> suggetions= [];
  OutlineInputBorder borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.grey, width: 1));
      @override
  void initState() {
    // TODO: implement initState
      getsugetions();
    super.initState();
  }
  void getsugetions()async{
    SharedPreferences _sp = await SharedPreferences.getInstance();
    suggetions = (await _sp.getStringList('suggetions'))??[];
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbarcomp(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10, right: 15),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                 BoxShadow(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      )
                    
              ]),
              child: TextField(
                controller: _searchContoler,
                cursorColor: Colors.grey,

                decoration: InputDecoration(
                  hintText: 'Search....',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: borderStyle,
                  focusedBorder: borderStyle,
                  suffixIcon:
                      IconButton(onPressed: () async{
                          SharedPreferences _sp = await SharedPreferences.getInstance();
                          if (suggetions.length >= 4  ) {
                            suggetions.removeLast();
                          }
                            suggetions.insert(0 ,_searchContoler.text);
                            await _sp.setStringList('suggetions', suggetions);
                           Navigator.push(context, MaterialPageRoute(builder: (context) => Bookssearchviewcomp(result: _searchContoler.text),));
                      }, icon: Icon(Icons.search)),
                ),
              ),
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(boxShadow: [BoxShadow(color: const Color.fromARGB(145, 158, 158, 158), spreadRadius: 1,blurRadius: 1)],color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                splashColor: brown.withOpacity(0.5),
                tileColor: Colors.white,
                onLongPress: () async{
                  SharedPreferences _sp = await SharedPreferences.getInstance();
                  suggetions.removeAt(index);
                  await _sp.setStringList('suggetions', suggetions);
                  setState(() {
                    
                  });
                },
                onTap: () {
                  _searchContoler.value = TextEditingValue(text: suggetions[index]);
                },
                title: Text(suggetions[index]),
                trailing: Icon(Icons.arrow_outward),
              ),
            ),
            itemCount: suggetions?.length,
          )
        ],
      ),
    );
  }
}
