import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breed/Models/get_physical_attributes_list.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
class LearnBreedPhysivalAttributes extends StatefulWidget {
  List<Data> breedPhysicalAttributesList;
  LearnBreedPhysivalAttributes(this.breedPhysicalAttributesList, {Key? key}) : super(key: key);

  @override
  _LearnBreedPhysivalAttributesState createState() => _LearnBreedPhysivalAttributesState(breedPhysicalAttributesList);
}

class _LearnBreedPhysivalAttributesState extends State<LearnBreedPhysivalAttributes> {

  List<Data> breedPhysicalAttributesList;
  _LearnBreedPhysivalAttributesState(this.breedPhysicalAttributesList);
  TextEditingController controller = new TextEditingController();

  List<Data>? foundList;


  @override
  void initState(){
    super.initState();
    foundList =breedPhysicalAttributesList;

    setState(() {
      FirebaseAnalytics.instance.logEvent(name: 'Learn_Breed_Physical_Attributes',parameters: {
        'note':"Learn_Breed_Physical_Attributes",
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Dog Physical Attributes'),
        centerTitle: true,
        backgroundColor: Color(0xff233f4b),
      ),
      body: Container(
        color: Color(0xff233f4b),
        child: Column(
          children: <Widget> [
            Padding(padding: EdgeInsets.all(12),
              child:Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search breed', border: InputBorder.none
                    ),
                    onChanged: (value) {
                      if(value==null){
                        foundList =breedPhysicalAttributesList;
                      }
                      _runFilter(value);
                    },
                  ),
                ),
              ), ),

            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.fromLTRB(10, 5, 15, 10),
                  itemCount: null == foundList ?0 : foundList!.length,
                  itemBuilder: (context, index){
                    Data data = foundList![index];
                    return Card(
                      color: Colors.white,
                      elevation: 20,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                        title: Text(data.breedName.toString(),
                          style: TextStyle(color: Color(0xff118173),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.normal,
                              fontSize: 16),),
                        subtitle: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 2)),
                            Row(
                              children: [
                                Text("Life Time  ",style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12
                                )),
                                Text(data.lifeSpan!.first.toString(),style: TextStyle(
                                    color: Colors.black45,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Weight  ",style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12
                                )),
                                Text(data.idealWeight!.first.toString(),style: TextStyle(
                                    color: Colors.black45,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Height  ",style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12
                                )),
                                Text(data.idealHeight!.first.toString(),style: TextStyle(
                                    color: Colors.black45,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12
                                )),
                              ],
                            )
                          ],
                        ),
                        leading: buildImage(data),
                        onTap: (){
                          if(data==null){
                            print("null data found");
                          }else{
                            /*getList(data.name.toString());*/
                            /*Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BreedListDetails(list: [data],)));*/
                          }
                        },
                      ),

                    );
                  }),)

          ],
        ),
      ),
    );
  }

  void _runFilter (String enteredKeyword) {
    List<Data>? result = [];
    /*List<Map<String,dynamic>> result = [];*/
    if(enteredKeyword.isEmpty){
      result = breedPhysicalAttributesList;
    }else{
      result = breedPhysicalAttributesList.where((user) => user.breedName!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();

    }

    setState(() {
      foundList = result!;
      print(result.length);
    });
  }

  Widget buildImage(Data data) => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: CachedNetworkImage(
      imageUrl: data.thumbnail.toString(),
      height: 60,
      width: 60,
      fit: BoxFit.cover,
    ),

  );
}
