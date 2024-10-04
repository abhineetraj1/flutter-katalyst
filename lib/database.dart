import 'package:flutter/material.dart';
import 'package:katalyst/main.dart';
import 'package:mongo_dart/mongo_dart.dart';

var MongoURL = "mongodb://10.0.2.2:27017/katalyst";

Future isDatabaseOnline(context) async {
  try {
    var a = await Db.create(MongoURL);
    a.open()
      .timeout(Duration(seconds: 3))
    ;
    return true;
  } catch (e) {
    AlertBox(context, "", e.toString());
    return false;
  }
}

verify(context, email, password) async{
  if (await isDatabaseOnline(context)) {
    var db = await Db.create(MongoURL);
    await db.open();
    var users = await db.collection("users");
    var data = await users.find(where.eq("email",email)).toList();
    var n = true;
    if (data.length > 0) {
      for (var a in data) if (a["email"] == email && a["password"] == password) {
        Name = a["name"];
        Email = email;
        Password = password;
        userID = a["_id"];
        await LoadEvents(context);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Dashboard();}));
        n=false;
        break;
      }
    }
    if (n) AlertBox(context, "Account", "Wrong credentials");
  } else {
    AlertBox(context, "Internet", "No internet connection");
  }
}

create(context, name, email, password) async{
  if (await isDatabaseOnline(context)) {
    var db = await Db.create(MongoURL);
    await db.open();
    var users = await db.collection("users");
    var data = await users.find(where.eq("email",email)).toList();
    var n = false;
    if (data.length > 0) {
      for (var a in data) if (a["email"] == email) {n=true;break;}
    }
    if (n) {
      AlertBox(context, "Account", "Account already exists");
    } else {
      await users.insert({"name":name,"email":email,"password":password});
      Name = name;
      Email = email;
      Password = password;
      var user_D = await users.findOne(where.eq("email", email));
      userID = user_D != null ? user_D["_id"] : "";
      await LoadEvents(context);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Dashboard();}));
    }
  } else {
    AlertBox(context, "Internet", "No internet connection");
  }
}

LoadEvents(context) async {
  if (await isDatabaseOnline(context)) {
    var db = await Db.create(MongoURL);
    await db.open();
    var evtd = await db.collection("events");
    events = await evtd.find().toList();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Dashboard();}));
  } else {
    AlertBox(context, "Internet", "No internet connection");
  }
}

EventDetails(context, id) async {
  if (await isDatabaseOnline(context)) {
    var db = await Db.create(MongoURL);
    await db.open();
    var details = await db.collection("events");
    var event = await details.find().toList();
    for (var i in event) if (i["_id"].toString() == id) return i;
    return Null;
  } else {
    AlertBox(context, "Internet", "No internet connection");
  }
}

FetchUserInfo(context, email) async{
  if (await isDatabaseOnline(context)) {
    var db = await Db.create(MongoURL);
    await db.open();
    var users = await db.collection("users");
    var data = await users.find(where.eq("email",email)).toList();
    if (data.length > 0) {
      return data[0];
    } else {
      return Null;
    }
  } else {
    AlertBox(context, "Internet", "No internet connection");
  }
}

ChangePersonalInfo(context, email, type, value)  async{
  if (await isDatabaseOnline(context)) {
    var db = await Db.create(MongoURL);
    await db.open();
    var users = await db.collection("users");
    var evnt = await db.collection("events");
    var ifAv = await users.find(where.eq("email", value)).toList();
    if (ifAv.length > 0) {
      AlertBox(context, "Email", "Email already exist");
    } else {
      await users.update(where.eq("email", email), modify.set(type, value));
      Password = type == "password" ? value : Password;
      Name = type == "name" ? value : Name;
      if (type == "email") {
        evnt.updateMany(where.eq("email", Email), modify.set("email", value));
        Email = value;
      }
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {return PersonalDetails(email: type == "email" ? value : Email,);}));
    }
  } else {
    AlertBox(context, "Internet", "No internet connection");
  }
}

AddWorkshopInDatabase(context, name, date, timing, address) async{
  if (await isDatabaseOnline(context)) {
    var db = await Db.create(MongoURL);
    await db.open();
    var events = await db.collection("events");
    var users = await db.collection("users");
    var userDetails = await users.findOne(where.eq("email", Email));
    await events.insert({
      "name":name,
      "date":date,
      "timing":timing,
      "address":address,
      "author":Name,
      "email":Email,
      "userID": userDetails != null ? userDetails["_id"].toString() : ""
    });
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {return AddWorkshop();}));
  } else {
    AlertBox(context, "Internet", "No internet connection");
  }
}

LoadMyWorkshops(context) async {
  if (await isDatabaseOnline(context)) {
    var db = await Db.create(MongoURL);
    await db.open();
    var events = await db.collection("events");
    var myEvents = await events.find(where.eq("email", Email)).toList();
    return myEvents;
  } else {
    AlertBox(context, "Internet", "No internet connection");
    return false;
  }
}

DeleteWorkshop(context, name) async {
  if (await isDatabaseOnline(context)) {
    var db = await Db.create(MongoURL);
    await db.open();
    var events = await db.collection("events");
    var bookings = await db.collection("events");
    var eventDetails = await events.findOne(where.eq("email", Email).eq("name", name));
    await events.deleteOne(where.eq("email", Email).eq("name", name));
    await bookings.deleteOne(where.eq("eventID", eventDetails != null ? eventDetails["_id"] : ""));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {return MyWorkshop();}));
  } else {
    AlertBox(context, "Internet", "No internet connection");
    return false;
  }
}

LoadBookingHistory(context) async{
  if (await isDatabaseOnline(context)) {
    var db = await Db.create(MongoURL);
    await db.open();
    var events = await db.collection("bookings");
    var users = await db.collection("users");
    var usersDetails = await users.findOne(where.eq("email", Email));
    var listOfHistory = await events.find(where.eq("userID", usersDetails != null ? usersDetails["_id"] : null)).toList();
    return listOfHistory;
  } else {
    AlertBox(context, "Internet", "No internet connection");
    return false;
  }
}

BookWorkshop(context, userID, eventID) async{
  if (await isDatabaseOnline(context)) {
    var db = await Db.create(MongoURL);
    await db.open();
    var bookings = await db.collection("bookings");
    var a = await bookings.find(where.eq("userID", userID).eq("eventID", eventID)).toList();
    if (a.length == 0) {
      await bookings.insert({"userID":userID,"eventID":eventID});
      AlertBox(context, "Booking", "Workshop has been booked");
    } else {
      AlertBox(context, "Booking", "This workshop is already booked");
    }
  } else {
    AlertBox(context, "Internet", "No internet connection");
    return false;
  } 
}

ChangeWorkshopInfo(context, _id, type, value)  async{
  if (await isDatabaseOnline(context)) {
    var db = await Db.create(MongoURL);
    await db.open();
    var wks = await db.collection("events");
    await wks.update(where.eq("_id", _id), modify.set(type, value));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {return EditWorkshop(id: _id);}));
  } else {
    AlertBox(context, "Internet", "No internet connection");
  }
}

GetEventDetailsById(context, id) async{
  if (await isDatabaseOnline(context)) {
    var db = await Db.create(MongoURL);
    await db.open();
    var evt = await db.collection("events");
    var data = await evt.findOne(where.eq("_id", id));
    return data;
  } else {
    AlertBox(context, "Internet", "No internet connection");
    return null;
  }
}

CancelWorkshopBooking(context, userID, eventID) async{
  if (await isDatabaseOnline(context)) {
    var db = await Db.create(MongoURL);
    await db.open();
    var evt = await db.collection("bookings");
    await evt.deleteOne(where.eq("eventID", eventID).eq("userID", userID));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {return BookingHistory();}));
  } else {
    AlertBox(context, "Internet", "No internet connection");
  }
}