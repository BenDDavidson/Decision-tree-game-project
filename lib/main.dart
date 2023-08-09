import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'decision_map.dart';


late Box<DecisionMap> box;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();   //HIVE SETUP
  Hive.registerAdapter(DecisionMapAdapter());
  box = await Hive.openBox<DecisionMap>('decisionMap');

  String csv = "map.csv"; //path to csv file asset
  String fileData = await rootBundle.loadString(csv);
  //split csv file into list of rows
  List <String> rows = fileData.split("\n");

  //loop through rows, and put their data into a DecisionMap object which is then stored in a hive box
  for (int i = 0; i < rows.length; i++)  {

    String row = rows[i];
    List <String> itemInRow = row.split(",");
    DecisionMap decMap = DecisionMap()
      ..currentID = int.parse(itemInRow[0])
      ..option1ID = int.parse(itemInRow[1])
      ..option2ID = int.parse(itemInRow[2])
      ..description = itemInRow[3]
      ..option1Text = itemInRow[4]
      ..option2Text = itemInRow[5];

    int key = int.parse(itemInRow[0]);
    box.put(key,decMap);
  }

  runApp (
    const MaterialApp(
      home: MyFlutterApp(),
    ),
  );
}

class MyFlutterApp extends StatefulWidget {
  const MyFlutterApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyFlutterState();
  }
}

class MyFlutterState extends State<MyFlutterApp>{

  //WRITE VARIABLES AND EVENT HANDLERS HERE

  //queue of ids visited
  final idQueue = Queue<int>();


  late DecisionMap? aliveMap;
  late int currentID;
  late int option1ID;
  late int option2ID;
  String description = "";
  String option1Text = "";
  String option2Text = "";

  @override
  void initState() {
    super.initState();
    //PLACE CODE HERE TO INITIALISE SERVER OBJECTS

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {


        DecisionMap? aliveMap = box.get(0);

        idQueue.addFirst(0);

        currentID = aliveMap!.currentID;
        option1ID = aliveMap.option1ID;
        option2ID = aliveMap.option2ID;
        description = aliveMap.description;
        option1Text = aliveMap.option1Text;
        option2Text = aliveMap.option2Text;


      });
    });
  }

  void option1Handler() {
    setState(() {

      idQueue.addFirst(currentID);

      DecisionMap? aliveMap = box.get(option1ID);
      if(aliveMap != null) {
        currentID = aliveMap.currentID;
        option1ID = aliveMap.option1ID;
        option2ID = aliveMap.option2ID;
        description = aliveMap.description;
        option1Text = aliveMap.option1Text;
        option2Text = aliveMap.option2Text;
      }
    });
  }


  void option2Handler() {
    setState(() {

      idQueue.addFirst(currentID);

      DecisionMap? aliveMap = box.get(option2ID);
      if(aliveMap != null) {
        currentID = aliveMap.currentID;
        option1ID = aliveMap.option1ID;
        option2ID = aliveMap.option2ID;
        description = aliveMap.description;
        option1Text = aliveMap.option1Text;
        option2Text = aliveMap.option2Text;
      }


    });
  }

  void goBackHandler() {
    setState(() {
      DecisionMap? aliveMap = box.get(idQueue.first);

      if(currentID != 0) {
        idQueue.removeFirst();
      }

      if(aliveMap != null) {
        currentID = aliveMap.currentID;
        option1ID = aliveMap.option1ID;
        option2ID = aliveMap.option2ID;
        description = aliveMap.description;
        option1Text = aliveMap.option1Text;
        option2Text = aliveMap.option2Text;
      }


    });
  }

//ui stuff

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:
        Stack(
          alignment: Alignment.topLeft,
          children: [

            //image
            Image(
              image: const AssetImage("assets/night-forest.jpg"),
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              fit: BoxFit.cover,
            ),





            //title

            const Align(
              alignment: Alignment(0.0, -0.8),
              child: Text(
                "Ankers Wood",
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xffffffff),
                ),
              ),
            ),

            //column

            Align(
              alignment: const Alignment(0.0, 0.3),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    //description

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),

                    //row

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [


                          //option1


                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: MaterialButton(
                                onPressed: () {option1Handler();},
                                color: const Color(0xffffffff),
                                elevation: 100,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 16),
                                textColor: const Color(0xff000000),
                                height: 75,
                                minWidth: 125,
                                child: Text(option1Text,
                                  style: const TextStyle(fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  ),),
                              ),
                            ),
                          ),


                          //option2


                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: MaterialButton(
                                onPressed: () {option2Handler();},
                                color: const Color(0xffffffff),
                                elevation: 100,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: const BorderSide(
                                      color: Color(0xff808080), width: 1),
                                ),
                                padding: const EdgeInsets.all(16),
                                textColor: const Color(0xff000000),
                                height: 75,
                                minWidth: 125,
                                child: Text(
                                  option2Text, style: const TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),),
                              ),
                            ),
                          ),
                        ],),),


                    //go back


                    MaterialButton(
                      onPressed: () {goBackHandler();},
                      color: const Color(0xffffffff),
                      elevation: 100,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Color(0xff808080), width: 1),
                      ),
                      padding: const EdgeInsets.all(16),
                      textColor: const Color(0xff000000),
                      height: 40,
                      minWidth: 140,
                      child: const Text("Go Back", style: TextStyle(fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),),
                    ),
                  ],),),),
          ],),),
    )
    ;
  }
}