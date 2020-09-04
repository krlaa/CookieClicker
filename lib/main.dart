import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

int bites = 0;
int _selectedPage = 0;
int coins = 0;
int itemFactor = 0;

bool grandma = false;
bool wolf = false;
bool cookieMonster = false;
bool goldilocks = false;

File jsonFile;
Directory dir;
String fileName = "myFile.json";
bool fileExists = false;
Map<String, dynamic> fileContent;

Image image1;
Image image2;
Image image3;
Image image4;
Image image5;
Image image6;
Image image7;

List<Image> imageList = [
  image1,
  image2,
  image3,
  image4,
  image5,
  image6,
  image7
];

//Snack bars for error handling
final snackBar = SnackBar(content: Text('This has already been purchased'));
final snackBar2 = SnackBar(content: Text('Not enough coins'));
void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: TabController(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(backgroundColor: Colors.lightBlue),
    );
  }
}

class TabController extends StatefulWidget {
  @override
  _TabControllerState createState() => _TabControllerState();
}

//Creates file to store game state/info
void createFile(Map<String, dynamic> content, Directory dir, String fileName) {
  print("Creating file!");
  File file = new File(dir.path + "/" + fileName);
  file.createSync();
  fileExists = true;
  file.writeAsStringSync(json.encode(content));
}

class _TabControllerState extends State<TabController> {
  final _pageOptions = [Clicked(), Store()];
  //init for tab controler gets items with getItems()
  @override
  void initState() {
    super.initState();
    getItems();
  }

  //looks for the file if it exiitsts
  getItems() {
    return getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) {
        print(fileExists);
        setState(() {
          fileContent = json.decode(jsonFile.readAsStringSync());
          bites = fileContent["bites"];

          coins = fileContent["coins"];
          itemFactor = fileContent["itemFactor"];
          grandma = fileContent["grandma"];
          wolf = fileContent["wolf"];
          cookieMonster = fileContent["cookieMonster"];
          goldilocks = fileContent["goldilocks"];
        });
      }
    });
  }

  //writes game state/info to file if it doesnt exist then creates file with createFile
  void writeToFile(String key, dynamic value) {
    print("Writing to file!");
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile({
        "bites": bites,
        "coins": coins,
        "itemFactor": itemFactor,
        "grandma": grandma,
        "wolf": wolf,
        "cookieMonster": cookieMonster,
        "goldilocks": goldilocks,
      }, dir, fileName);
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    print(fileContent);
  }

  //condensed function to write all the info to file
  writeMultiple() {
    writeToFile("bites", bites);
    writeToFile("coins", coins);
    writeToFile("itemFactor", itemFactor);
    writeToFile("grandma", grandma);
    writeToFile("wolf", wolf);
    writeToFile("cookieMonster", cookieMonster);
    writeToFile("goldilocks", goldilocks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedPage],
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            writeMultiple();
            _selectedPage = index;
          });
        },
        backgroundColor: Colors.lightBlue,
        currentIndex: _selectedPage,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              "assets/images/cookie1.png",
              scale: 3,
            ),
            icon: Image.asset(
              "assets/images/cookie1.png",
              color: Colors.grey[800],
              colorBlendMode: BlendMode.modulate,
              scale: 3,
            ),
            title: Text(
              'Cookie Home',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          BottomNavigationBarItem(
              activeIcon: Image.asset("assets/images/store.png", scale: 3),
              icon: Image.asset("assets/images/unselectStore.png", scale: 3),
              title: Text(
                'Store',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}

class Clicked extends StatefulWidget {
  @override
  _ClickedState createState() => _ClickedState();
}

class _ClickedState extends State<Clicked> {
  void writeToFile(String key, dynamic value) {
    print("Writing to file!");
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile({
        "bites": bites,
        "_selectedPage": _selectedPage,
        "coins": coins,
        "itemFactor": itemFactor,
        "grandma": grandma,
        "wolf": wolf,
        "cookieMonster": cookieMonster,
        "goldilocks": goldilocks,
      }, dir, fileName);
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    print(fileContent);
  }

  writeMultiple() {
    writeToFile("bites", bites);
    writeToFile("_selectedPage", _selectedPage);
    writeToFile("coins", coins);
    writeToFile("itemFactor", itemFactor);
    writeToFile("grandma", grandma);
    writeToFile("wolf", wolf);
    writeToFile("cookieMonster", cookieMonster);
    writeToFile("goldilocks", goldilocks);
  }

  @override
  void initState() {
    super.initState();
    image1 = Image.asset("assets/images/cookie1.png");
    image2 = Image.asset("assets/images/cookie2.png");
    image3 = Image.asset("assets/images/cookie3.png");
    image4 = Image.asset("assets/images/cookie4.png");
    image5 = Image.asset("assets/images/cookie5.png");
    image6 = Image.asset("assets/images/cookie6.png");
    image7 = Image.asset("assets/images/cookie7.png");
    getitems();
  }

  getitems() {
    return getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) {
        print(fileExists);
        setState(() {
          fileContent = json.decode(jsonFile.readAsStringSync());
          bites = fileContent["bites"];

          coins = fileContent["coins"];
          itemFactor = fileContent["itemFactor"];
          grandma = fileContent["grandma"];
          wolf = fileContent["wolf"];
          cookieMonster = fileContent["cookieMonster"];
          goldilocks = fileContent["goldilocks"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //caches images so there is no visible flicker when cookie changes
    precacheImage(image1.image, context);
    precacheImage(image2.image, context);
    precacheImage(image3.image, context);
    precacheImage(image4.image, context);
    precacheImage(image5.image, context);
    precacheImage(image6.image, context);
    precacheImage(image7.image, context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/coin.gif",
                  scale: 2.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Text(
                      coins.toString(),
                      style: TextStyle(
                          color: Colors.white, fontFamily: "Fun", fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Bites: " + bites.toString(),
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.white, fontSize: 50, fontFamily: "Fun"),
          ),
          Padding(
            padding: EdgeInsets.all(30),
          ),
          InkWell(
            child: img(bites),
            hoverColor: Colors.lightBlue,
            focusColor: Colors.lightBlue,
            splashColor: Colors.lightBlue,
            highlightColor: Colors.lightBlue,
            onTap: () {
              writeMultiple();
              setState(() {
                bites++;
                if (itemFactor == 0) {
                  coins = coins + 1 + itemFactor;
                  writeMultiple();
                } else {
                  coins = coins + itemFactor;
                  writeMultiple();
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

Widget img(number) {
  int count = number % 6;
  print(count = number % 6);
  if (count == 0) {
    count++;
  } else
    count += 1;
  return Container(
      child: Column(
    children: <Widget>[imageList[count - 1]],
  ));
}

class Store extends StatefulWidget {
  @override
  StoreState createState() => StoreState();
}

class StoreState extends State<Store> {
  @override
  void initState() {
    super.initState();
    getitems();
  }

  getitems() {
    return getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) {
        print(fileExists);
        setState(() {
          fileContent = json.decode(jsonFile.readAsStringSync());
          bites = fileContent["bites"];

          coins = fileContent["coins"];
          itemFactor = fileContent["itemFactor"];
          grandma = fileContent["grandma"];
          wolf = fileContent["wolf"];
          cookieMonster = fileContent["cookieMonster"];
          goldilocks = fileContent["goldilocks"];
        });
      }
    });
  }

  void writeToFile(String key, dynamic value) {
    print("Writing to file!");
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile({
        "bites": bites,
        "coins": coins,
        "itemFactor": itemFactor,
        "grandma": grandma,
        "wolf": wolf,
        "cookieMonster": cookieMonster,
        "goldilocks": goldilocks,
      }, dir, fileName);
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    print(fileContent);
  }

  writeMultiple() {
    writeToFile("bites", bites);

    writeToFile("coins", coins);
    writeToFile("itemFactor", itemFactor);
    writeToFile("grandma", grandma);
    writeToFile("wolf", wolf);
    writeToFile("cookieMonster", cookieMonster);
    writeToFile("goldilocks", goldilocks);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/coin.gif",
                scale: 2.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Text(
                    coins.toString(),
                    style: TextStyle(
                        color: Colors.white, fontFamily: "Fun", fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(children: <Widget>[
              InkWell(
                onTap: () {
                  if (!grandma) {
                    if (coins >= 100) {
                      setState(() {
                        coins = coins - 100;
                        itemFactor = itemFactor + 10;
                        grandma = true;
                      });
                      writeMultiple();
                    } else {
                      Scaffold.of(context).showSnackBar(snackBar2);
                    }
                    writeMultiple();
                  } else
                    Scaffold.of(context).showSnackBar(snackBar);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "grandma " + "100",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Fun"),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          "assets/images/coin.gif",
                          scale: 4,
                        )
                      ],
                    ),
                    Text(
                      "10 coins per bite",
                      style: TextStyle(
                          color: Colors.white, fontSize: 15, fontFamily: "Fun"),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      "assets/images/grandma.gif",
                      color: grandma ? Colors.grey[900] : null,
                      colorBlendMode: BlendMode.modulate,
                      scale: 1.5,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (!goldilocks) {
                    if (coins >= 1000) {
                      setState(() {
                        coins = coins - 1000;
                        itemFactor = itemFactor + 40;
                        goldilocks = true;
                      });
                      writeMultiple();
                    } else {
                      Scaffold.of(context).showSnackBar(snackBar2);
                    }
                    writeMultiple();
                  } else
                    Scaffold.of(context).showSnackBar(snackBar);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "goldilocks " + "1K",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Fun"),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          "assets/images/coin.gif",
                          scale: 4,
                        )
                      ],
                    ),
                    Text(
                      "50 coins per bite",
                      style: TextStyle(
                          color: Colors.white, fontSize: 15, fontFamily: "Fun"),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      "assets/images/goldilocks.gif",
                      color: goldilocks ? Colors.grey[900] : null,
                      colorBlendMode: BlendMode.modulate,
                      scale: 1.5,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (!wolf) {
                    if (coins >= 10000) {
                      setState(() {
                        coins = coins - 10000;
                        itemFactor = itemFactor + 50;
                        wolf = true;
                      });
                      writeMultiple();
                    } else {
                      Scaffold.of(context).showSnackBar(snackBar2);
                    }
                    writeMultiple();
                  } else
                    Scaffold.of(context).showSnackBar(snackBar);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Big Bad Wolf " + "10K",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Fun"),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          "assets/images/coin.gif",
                          scale: 4,
                        )
                      ],
                    ),
                    Text(
                      "100 coins per bite",
                      style: TextStyle(
                          color: Colors.white, fontSize: 15, fontFamily: "Fun"),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      "assets/images/wolf.gif",
                      color: wolf ? Colors.grey[900] : null,
                      colorBlendMode: BlendMode.modulate,
                      scale: 1.5,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (!cookieMonster) {
                    if (coins >= 100000) {
                      setState(() {
                        coins = coins - 100000;
                        itemFactor = itemFactor + 100;
                        cookieMonster = true;
                      });
                      writeMultiple();
                    } else {
                      Scaffold.of(context).showSnackBar(snackBar2);
                    }
                    writeMultiple();
                  } else
                    Scaffold.of(context).showSnackBar(snackBar);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Cookie Monster " + "100k",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Fun"),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          "assets/images/coin.gif",
                          scale: 4,
                        )
                      ],
                    ),
                    Text(
                      "1000 coins per bite",
                      style: TextStyle(
                          color: Colors.white, fontSize: 15, fontFamily: "Fun"),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      "assets/images/cookieMonster.gif",
                      color: cookieMonster ? Colors.grey[900] : null,
                      colorBlendMode: BlendMode.modulate,
                      scale: 1.5,
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
