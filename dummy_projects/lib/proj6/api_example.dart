import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyApiExampleApp extends StatelessWidget {
  const MyApiExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark, 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ApiExampleHome(),
    );
  }
}

class ApiExampleHome extends StatefulWidget {
  const ApiExampleHome({super.key});

  @override
  State<ApiExampleHome> createState() => _ApiExampleHomeState();
}

class _ApiExampleHomeState extends State<ApiExampleHome> {
  late final Future<Response> _res;

  @override
  void initState() {
    super.initState();

    _res = Dio().get("https://jsonplaceholder.typicode.com/users");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Example"),
      ),
      body: FutureBuilder(
        future: _res, 
        builder: (context, snapshot) => snapshot.hasData 
          ? SingleChildScrollView(
            child: Column(
              children: [
                for(final user in snapshot.data!.data)
                  ...[
                    for(final prop in User.fromJson(user).toJson().values)
                      if(prop is Map)
                        for(final prop2 in prop.values)
                          Text(prop2.toString())
                      else
                        Text(prop.toString()),
                    const SizedBox(height: 20,),
                  ],
              ],
            ),
          )
          : const CircularProgressIndicator(),  
      ),
    );
  }
}


class User{
  final int? id;
  final String? name, username, email, phone, website;
  final Address address;
  final Company company;

  User.fromJson(Map json) : 
    id = json["id"],
    name = json["name"],
    username = json["username"],
    email = json["email"],
    phone = json["phone"],
    website = json["website"],
    address = Address.fromJson(json["address"]),
    company = Company.fromJson(json["company"]);
  
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "email": email,
    "phone": phone,
    "website": website,
    "address": address.toJson(),
    "company": company.toJson(),
  };
}

class Address{
  final String? street, city, suite, zipcode;
  final String? lat, long;

  Address.fromJson(Map json) : 
    street = json["street"],
    city = json["city"],
    suite = json["suite"],
    zipcode = json["zipcode"],
    lat = json["geo"]["lat"],
    long = json["geo"]["long"];
  
  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "suite": suite,
    "zipcode": zipcode,
    "lat": lat,
    "long": long,
  };
}

class Company{
  final String? name, catchPhrase, bs;

  Company.fromJson(Map json) : 
    name = json["name"],
    catchPhrase = json["catchPhrase"],
    bs = json["bs"];
  
  Map<String, dynamic> toJson() => {
    "name": name,
    "catchPhrase": catchPhrase,
    "bs": bs,
  };
}