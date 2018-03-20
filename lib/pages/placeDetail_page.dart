import 'package:flutter/material.dart';
import '../models/place_model.dart';
import '../services/gplace_service.dart';

class PlaceDetailPage extends StatefulWidget {
 final String _place_id;
  PlaceDetailPage(this._place_id);
  @override
  State createState() => new PlaceDetailState();
}

class PlaceDetailState extends State<PlaceDetailPage> {
  @override
  Widget build(BuildContext context) {
    if (_place == null) {
      return new Material(
          color: Colors.greenAccent,
          child: new Scaffold(
              appBar: new AppBar(
                title: new Text("Loading..."),
                backgroundColor: Colors.green,
              ),
              body: new Container(
                child: new Center(
                    child: new Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: new CircularProgressIndicator(),
                )),
              )));
    }
    return new Material(
        color: Colors.greenAccent,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text(_place.name),
            backgroundColor: Colors.green,
          ),
          body: new SingleChildScrollView(
            child: 
            new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                         padding: const EdgeInsets.only(right: 3.0),
                         child: 
                          new Text(_place.name, 
                          overflow: TextOverflow.ellipsis,
                          
                          style: new TextStyle(
                              fontSize: 20.0,  
                              color: Colors.green, 
                              fontWeight: FontWeight.normal))
                      )
                     
                    ],
                  ),
                ),
                new Divider(
                  color: Colors.green,
                  height: 30.0,
                ),
                getCard("Address ", _place.formatted_address,Icons.location_on),
                getCard("Working Hours ", _place.weekday_text.join("\n"),Icons.work),
              ],
            ),
          ),
          )
        ));
  }

  PlaceDetail _place;
  @override
  void initState() {
    super.initState();

    LocationService.get().getPlace(widget._place_id).then((data) {
      setState(() {
        _place = data;
      });
    });
  }

  getCard(String header, String content, IconData iconData) {
    return new Card(
        color: Colors.white,
        child: new Container(
          child: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Row(
                   children: <Widget>[
                      new Text(header,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0))

                        ,

                        new Icon(iconData,color: Colors.green,)
                   ],
                )
               ,
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: new Text(content, textAlign: TextAlign.start),
                )
              ],
            ),
          ),
        ));
  }
}
