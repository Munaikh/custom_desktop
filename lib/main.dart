import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var time = DateFormat('hh:mm a').format(DateTime.now());
  WeatherFactory wf;
  Weather w;

  void queryForecast() async {
    Weather forecasts = await wf.currentWeatherByCityName('Kuwait City');
    setState(() {
      w = forecasts;
    });
  }

Icon getIcon(String weather){
  
  if(weather == 'clear sky'){
    return Icon(CupertinoIcons.sun_max, color: Colors.white, size: 35,);
  }
  else if (weather == 'few clouds'){
    return Icon(CupertinoIcons.cloud_sun_fill, color: Colors.white, size: 35,);
  }
  else if (weather == 'scattered clouds'){
    return Icon(CupertinoIcons.cloud, color: Colors.white, size: 35,);
  }
  else if (weather == 'broken clouds'){
    return Icon(CupertinoIcons.cloud_fill, color: Colors.white, size: 35,);
  }
  else if (weather == 'shower rain'){
    return Icon(CupertinoIcons.cloud_heavyrain_fill, color: Colors.white, size: 35,);
  }
  else if (weather == 'rain'){
    return Icon(CupertinoIcons.cloud_rain_fill, color: Colors.white, size: 35,);
  }
  else if (weather == 'thunderstorm'){
    return Icon(CupertinoIcons.cloud_bolt_fill, color: Colors.white, size: 35,);
  }
  else if (weather == 'snow'){
    return Icon(CupertinoIcons.cloud_snow_fill, color: Colors.white, size: 35,);
  }else if (weather == 'mist'){
    return Icon(CupertinoIcons.cloud_fog_fill, color: Colors.white, size: 35,);
  }
  else{
    Icon(CupertinoIcons.cloud, color: Colors.white, size: 35,);
  }


}

  @override
  void initState() {
    super.initState();
    wf = WeatherFactory("72075cddc28099d40aa742a42d5e52e7");
    queryForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Container(
          //   height: MediaQuery.of(context).size.height,
          //   child: Image.asset(
          //     'assets/3189407.jpg',
          //     fit: BoxFit.fill,
          //   ),
          // ),
          Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Good Afternoon, Abdullah.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'SF Pro Display'),
                  ),
                  Text(
                    'It\'s $time.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'SF Pro Display'),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: getIcon('${w.weatherDescription == null ? '' : w.weatherDescription}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'It\'ll be ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'SF Pro Display'),
                        ),
                        TextSpan(
                          text:
                              '${w.weatherDescription == null ? '' : w.weatherDescription} ',
                          style: TextStyle(
                              color: Color(0xffF7BE69),
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'SF Pro Display'),
                        ),
                        TextSpan(
                          text: 'today.',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'SF Pro Display'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
