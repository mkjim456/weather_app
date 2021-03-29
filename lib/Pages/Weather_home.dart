import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Pages/Current_page.dart';
import 'package:weather_app/Pages/Forecast_Page.dart';
import 'package:weather_app/Pages/Settings_Page.dart';
import 'package:weather_app/Providers/Location_provider.dart';
import 'package:weather_app/Theme_Style/Text_Style.dart';
import 'package:weather_app/Utils/weather_utils.dart';
import 'package:weather_app/Widgets/Progress_widget.dart';

class WeatherHome extends StatefulWidget {
  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  bool isLoading = true;
  bool isInit = true;

  @override
  void didChangeDependencies() {

    if (isInit) {
      _getLocation();
      isInit = false;
  }
    super.didChangeDependencies();
  }


  _getLocation(){
    Provider.of<LocationProvider>(context, listen: false)
        .getDeviceCurrentPosition().then((_) {

      setState(() {
        isLoading = false;
      });
      //print(Provider.of<LocationProvider>(context, listen: false).position);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        actions: [

          IconButton (
              onPressed: () async {
                final city = await showSearch(context: context, delegate: _CitySearchDelegate());
                if ( city != null){
                  _convertAddressToPosition(city);

                }
              },
              icon:Icon(Icons.search) ),


          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Settings())).then((_) {
              setState(() {
                isLoading = true;
              });
              _getLocation();
            }),
          )
        ],
        title: Text('Weather App',style: title,),
      ),
      body: Container(

        decoration: BoxDecoration(
            color: Colors.black12,
        ),

        child: isLoading ? ProgressWidget() : ListView(
             children: [
               CurrentPage(),
               SizedBox(height: 20,),
               Text('Weather forecast for next 5 days :', style: date,),

               ForecastPage(),
             ],
        ),

        ),

    );
  }

  void _convertAddressToPosition(String city) async {
     final position = await convertAddressToPosition(city);
     if(position != null){
       Provider.of<LocationProvider>(context, listen: false).setNewSearchPosition(position);
       setState(() {
         isLoading = false;
       });
     }
     else{
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('City not found')));


     }


  }


}

class _CitySearchDelegate extends SearchDelegate <String> {

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget> [
      IconButton(onPressed: () {
        query = '';
      },

          icon: Icon(Icons.cancel))

    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    IconButton(onPressed: () {},

        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListTile(
      title: Text(query),
      leading: Icon(Icons.search),
      onTap: (){
        close(context, query);
      },

    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var filtedlist = query == null ? cities : cities.where((city) => city.toLowerCase().startsWith(query.toLowerCase())).toList();
    return ListView.builder(
        itemCount: filtedlist.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(filtedlist[index]),
          onTap: (){
            query = filtedlist[index];
            close(context, query);
          },
        )

    );
  }

}

