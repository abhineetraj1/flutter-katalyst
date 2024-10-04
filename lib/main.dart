import 'package:flutter/material.dart';
import 'package:katalyst/database.dart';

void main() {
  runApp(const MyApp());
}

var Name = "";
var Email = "";
var Password = "";
var userID;
var events;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Index(),
    );
  }
}

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height*0.8,
              decoration: BoxDecoration(
                color: Colors.indigo[700],
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/icon.jpg", width: MediaQuery.sizeOf(context).width*0.4,),
                    Text("Katalyst", style: TextStyle(color: Colors.white, fontSize: 20),)
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height*0.20,
              decoration: BoxDecoration(
                color: Colors.indigo[700]
              ),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height*0.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50))
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20,),
                    SizedBox(width: MediaQuery.sizeOf(context).width*0.8 ,child: ElevatedButton(onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {return SignUp();}));
                    }, style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo[700], foregroundColor: Colors.white), child: Text("Sign Up"))),
                    SizedBox(width: MediaQuery.sizeOf(context).width*0.8 ,child: ElevatedButton(onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Login();}));
                    }, style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo[700], foregroundColor: Colors.white), child: Text("Sign In")))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Login extends StatelessWidget {
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = new TextEditingController();
    TextEditingController password = new TextEditingController();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo[700],
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              width: MediaQuery.sizeOf(context).width*0.85,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Login", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      controller: password,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(onPressed: () {
                      verify(context, email.text, password.text);
                    },style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo[700], foregroundColor: Colors.white) ,child: Text("Login")),
                    SizedBox(height: 10,),
                    TextButton(onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {return SignUp();}));
                    }, child: Text("Sign Up?", style: TextStyle(color: Colors.indigo[700])))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class SignUp extends StatelessWidget {
  SignUp({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController name = new TextEditingController();
    TextEditingController email = new TextEditingController();
    TextEditingController password = new TextEditingController();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo[700],
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              width: MediaQuery.sizeOf(context).width*0.85,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Sign Up", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      controller: password,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(onPressed: () {
                      create(context, name.text, email.text, password.text);
                    },style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo[700], foregroundColor: Colors.white) ,child: Text("Sign Up")),
                    SizedBox(height: 10,),
                    TextButton(onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Login();}));
                    }, child: Text("Sign In?", style: TextStyle(color: Colors.indigo[700])))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController search = TextEditingController();
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Settings();}));
              }, icon: Icon(Icons.settings)),
              Text(Name),
              IconButton(onPressed: () {
                LoadEvents(context);
              }, icon: Icon(Icons.refresh))
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: search,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.black, style: BorderStyle.solid),
                    ),
                    hintText: "Search for events"
                  ),
                ),
                SizedBox(height: 20,),
                if (events != null) for (var i in events) EventContainer(context, i)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Index();}));
        }, child: Icon(Icons.logout, color: Colors.white,), backgroundColor: Colors.black,),
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: () {
                LoadEvents(context);
              }, icon: Icon(Icons.arrow_back)),
              SizedBox(width: 10,),
              Text("Settings")
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {return PersonalDetails(email: Email,);}));
              }, child: Row(
                children: [
                  Icon(Icons.person, color: Colors.black,),
                  SizedBox(width: 10,),
                  Text("Personal details", style: TextStyle(fontSize: 20,color: Colors.black),),
                ],
              )),
              TextButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {return BookingHistory();}));
              }, child: Row(
                children: [
                  Icon(Icons.history, color: Colors.black,),
                  SizedBox(width: 10,),
                  Text("Booking history", style: TextStyle(fontSize: 20,color: Colors.black),),
                ],
              )),
              TextButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {return AddWorkshop();}));
              }, child: Row(
                children: [
                  Icon(Icons.add, color: Colors.black,),
                  SizedBox(width: 10,),
                  Text("Add workshop", style: TextStyle(fontSize: 20,color: Colors.black),),
                ],
              )),
              TextButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {return MyWorkshop();}));
              }, child: Row(
                children: [
                  Icon(Icons.work, color: Colors.black,),
                  SizedBox(width: 10,),
                  Text("My workshops", style: TextStyle(fontSize: 20,color: Colors.black),),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

AlertBox(context, title, message) {
  showDialog(context: context, builder: (context) {
  return AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      TextButton(onPressed: () {Navigator.of(context).pop();}, child: Text("Ok"))
    ],
  );
  });
}

SmallLoader(context) {
   showDialog(context: context, builder: (context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height*0.5,
        child: Center(child: Text("Loading...", style: TextStyle(fontSize: 20),))
      ),
    );
   });
}

EventContainer(context, data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(
          blurRadius: 20,
          blurStyle: BlurStyle.outer,
          color: Colors.black
        )]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.asset("assets/event.png")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data["name"], style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                TextButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {return ViewDetails(id: data["_id"].toString());}));
                }, child: Text("View details", style: TextStyle(color: Colors.indigo),)),
              ],
            ),
            Align(alignment: Alignment.centerLeft,child: Text(data["date"], style: TextStyle(fontSize: 18),)),
            Row(
              children: [
                Text("Organiser: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Text(data["author"], style: TextStyle(fontSize: 18),),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class ViewDetails extends StatefulWidget {
  final String id;
  const ViewDetails({Key? key, required this.id}) : super(key: key);
  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}
class _ViewDetailsState extends State<ViewDetails> {
  var details;

  @override
  void initState() {
    super.initState();
    FetchDetails(widget.id);
  }

  Future FetchDetails(id) async{
    var info = await EventDetails(context, id);
    setState(() {
      details = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: () {
                LoadEvents(context);
              }, icon: Icon(Icons.arrow_back)),
              SizedBox(width: 10,),
              Text( (details != null) ? "Event details" : "Event details")
            ],
          ),
        ),
        body: details != null ? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/event.png")),
                SizedBox(height: 10,),
                Align(alignment: Alignment.centerLeft, child: Text(details["name"], style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
                SizedBox(height: 10,),
                Align(alignment: Alignment.centerLeft, child: Text(details["author"], style: TextStyle(fontSize: 23),)),
                SizedBox(height: 10,),
                Align(alignment: Alignment.centerLeft, child: Text(details["date"], style: TextStyle(fontSize: 23),)),
                Align(alignment: Alignment.centerLeft, child: Text(details["timing"], style: TextStyle(fontSize: 23),)),
                Align(alignment: Alignment.centerLeft, child: Text(details["address"], style: TextStyle(fontSize: 23),)),
                if (details["email"] != Email) ElevatedButton(onPressed: () {
                  BookWorkshop(context, userID, details["_id"]);
                }, child: Text("Book",), style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white))
              ],
            ),
          ),
        ) : Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Center(child: Text("Loading", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
        ),
      ),
    );
  }
}

class PersonalDetails extends StatefulWidget {
  final String email;
  const PersonalDetails({super.key, required String this.email});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  var data;
  bool a = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetails(widget.email);
  }

  Future userDetails(email) async{
    data = await FetchUserInfo(context, email);
    setState(() {
      a=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Row(
          children: [
            IconButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Settings();}));
            }, icon: Icon(Icons.arrow_back)),
            SizedBox(width: 10,),
            a? Text(data == null ? "" : data["name"]) : Text("Loading"),
          ],
        )),
        body: a ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(alignment: Alignment.centerLeft,child: Text("Name", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              Row(
                children: [
                  Text(data["name"], style: TextStyle(fontSize: 20),),
                  IconButton(onPressed: () {
                    EditPersonalInfoBox(context, "name", data);
                  }, icon: Icon(Icons.edit)),
                ],
              ),
              SizedBox(height: 20,),
              Align(alignment: Alignment.centerLeft,child: Text("Email", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              Row(
                children: [
                  Text(data["email"], style: TextStyle(fontSize: 20),),
                  IconButton(onPressed: () {
                    EditPersonalInfoBox(context, "email", data);
                  }, icon: Icon(Icons.edit)),
                ],
              ),
              SizedBox(height: 20,),
              Align(alignment: Alignment.centerLeft,child: Text("Password", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              Row(
                children: [
                  Text("*****", style: TextStyle(fontSize: 20),),
                  IconButton(onPressed: () {
                    EditPersonalInfoBox(context, "password", data);
                  }, icon: Icon(Icons.edit)),
                ],
              ),
            ],
          ),
        ) : Container(height: MediaQuery.sizeOf(context).height,width: MediaQuery.sizeOf(context).width,child: Center(child: Text("Loading", style: TextStyle(fontSize: 30),))),
      ),
    );
  }
}

EditPersonalInfoBox(context, type, data) {
  var editText= new TextEditingController();
  editText.text = data[type];
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Change "+type, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          TextField(
            controller: editText,
            decoration: InputDecoration(
              hintText: "Enter new value",
            ),
          )
        ],
      ),
    actions: [
      TextButton(onPressed: () {
        if (editText.text.length > 1) ChangePersonalInfo(context, Email, type, editText.text);
      }, child: Text("Change")),
      TextButton(onPressed: () {Navigator.of(context).pop();}, child: Text("Cancel"))
    ],
  );
  }
);}

class AddWorkshop extends StatelessWidget {
  const AddWorkshop({super.key});

  @override
  Widget build(BuildContext context) {
    var name = new TextEditingController();
    var date = new TextEditingController();
    var timing = new TextEditingController();
    var address = new TextEditingController();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Settings();}));
              }, icon: Icon(Icons.arrow_back)),
              SizedBox(width: 10,),
              Text("Add workshop")
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(style: BorderStyle.solid)
                    ),
                    hintText: "Enter your workshop name"
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: date,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(style: BorderStyle.solid)
                    ),
                    hintText: "Enter workshop date (Start - end)"
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: timing,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(style: BorderStyle.solid)
                    ),
                    hintText: "Enter your workshop timings"
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: address,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(style: BorderStyle.solid)
                    ),
                    hintText: "Enter workshop address"
                  ),
                ),
                SizedBox(height: 15,),
                ElevatedButton(onPressed: () {
                  AddWorkshopInDatabase(context, name.text, date.text, timing.text, address.text);
                }, child: Text("Add workshop"), style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyWorkshop extends StatefulWidget {
  MyWorkshop({super.key});

  @override
  State<MyWorkshop> createState() => _MyWorkshopState();
}

class _MyWorkshopState extends State<MyWorkshop> {
  bool Loading = true;
  var data = null;

  Future LoadWorkshops() async{
    data = await LoadMyWorkshops(context);
    setState(() {
      Loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    LoadWorkshops();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Settings();}));
              }, icon: Icon(Icons.arrow_back)),
              SizedBox(width: 10,),
              Text("My Workshops")
            ],
          ),
        ),
        body: Loading ? Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Center(
            child: Text("Loading Details", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          ),
        ) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                for (var i in data) MyWorkshopContainer(context, i)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

MyWorkshopContainer(context, data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(
          blurRadius: 20,
          blurStyle: BlurStyle.outer,
          color: Colors.black
        )]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.asset("assets/event.png")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data["name"], style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                TextButton(onPressed: () {
                  DeleteWorkshop(context, data["name"]);
                }, child: Text("Delete", style: TextStyle(color: Colors.red, fontSize: 20),)),
              ],
            ),
            Row(
              children: [
                Text("timing: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Text(data["timing"], style: TextStyle(fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("date: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Text(data["date"], style: TextStyle(fontSize: 18),),
              ],
            ),
            Text(data["address"], style: TextStyle(fontSize: 20),),
            TextButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {return EditWorkshop(id: data["_id"],);}));
            }, child: Text("Edit workshop"), style: TextButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),)
          ],
        ),
      ),
    ),
  );
}

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  var Loading= true;
  var data;

  Future LoadHistory() async{
    data = await LoadBookingHistory(context);
    setState(() {
      Loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Settings();}));
              }, icon: Icon(Icons.arrow_back)),
              SizedBox(width: 10,),
              Text("Booking History")
            ],
          ),
        ),
        body: Loading ? Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Center(
            child: Text("Loading", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          ),
        ) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                for(var i in data) DisplayEventDetailsById(id: i["eventID"])
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class DisplayEventDetailsById extends StatefulWidget {
  final id;
  const DisplayEventDetailsById({super.key, required this.id}) ;

  @override
  State<DisplayEventDetailsById> createState() => _DisplayEventDetailsByIdState();
}

class _DisplayEventDetailsByIdState extends State<DisplayEventDetailsById> {
  bool Loading=true;
  var data;

  Future GetDetails() async {
    data = await GetEventDetailsById(context, widget.id);
    setState(() {
      Loading=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Loading ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        width: MediaQuery.sizeOf(context).width*0.9,
        height: 250,
        child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/load.png")),
      ),
    ) : Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(
            blurRadius: 10,
            blurStyle: BlurStyle.outer,
            color: Colors.black
          )],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:[
              ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.asset("assets/event.png")),
              Align(alignment: Alignment.centerLeft,child: Text(data["name"], style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              Row(
                children: [
                  Text("Date: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Text(data["date"], style: TextStyle(fontSize: 18),),
                ],
              ),
              Row(
                children: [
                  Text("Timing: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Text(data["timing"], style: TextStyle(fontSize: 18),),
                ],
              ),
              Text(data["address"], style: TextStyle(fontSize: 18),),
              ElevatedButton(onPressed: () {
                CancelWorkshopBooking(context, userID, data["_id"]);
              }, child: Text("Cancel"), style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),)
            ]
          ),
        )
      ),
    );
  }
}

class EditWorkshop extends StatefulWidget {
  final id;
  const EditWorkshop({super.key, required this.id});

  @override
  State<EditWorkshop> createState() => _EditWorkshopState();
}

class _EditWorkshopState extends State<EditWorkshop> {
  bool Loading = true;
  var data;

  Future GetDetails() async {
    data = await GetEventDetailsById(context, widget.id);
    setState(() {
      Loading=false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetDetails();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {return MyWorkshop();}));
              }, icon: Icon(Icons.arrow_back)),
              SizedBox(width: 10,),
              Text(Loading ? "Loading" : data["name"])
            ],
          ),
        ),
        body: Loading ? Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/load.png")),
          ),
        ) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/event.png")),
                Row(
                  children: [
                    Text("Name: ", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text(data["name"], style: TextStyle(fontSize: 20),),
                    IconButton(onPressed: () {
                      EditWorkshopBox(context, data, "name");
                    }, icon: Icon(Icons.edit))
                  ],
                ),
                Row(
                  children: [
                    Text("Date: ", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text(data["date"], style: TextStyle(fontSize: 20),),
                    IconButton(onPressed: () {
                      EditWorkshopBox(context, data, "date");
                    }, icon: Icon(Icons.edit))
                  ],
                ),
                Row(
                  children: [
                    Text("Timing: ", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text(data["timing"], style: TextStyle(fontSize: 20),),
                    IconButton(onPressed: () {
                      EditWorkshopBox(context, data, "timing");
                    }, icon: Icon(Icons.edit))
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text("Address:- ", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    IconButton(onPressed: () {EditWorkshopBox(context, data, "address");}, icon: Icon(Icons.edit))
                  ],
                ),
                Text(data["address"], style: TextStyle(fontSize: 20),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

EditWorkshopBox(context, data, type) {
  var editText = new TextEditingController();
  editText.text = data[type];
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Change "+type, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          TextField(
            controller: editText,
            decoration: InputDecoration(
              hintText: "Enter new value",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () {
          if (editText.text.length > 1) ChangeWorkshopInfo(context, data["_id"], type, editText.text);
          else Navigator.of(context).pop();
        }, child: Text("Update")),
        TextButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: Text("Cancel")),
      ],
    );
  });
}