import 'package:baato_maps/baato_maps.dart';
import 'package:flutter/material.dart';
import 'models/home_menu.dart';
import 'ui/baato_location_picker.dart';
import 'ui/baato_reverse.dart';
import 'ui/baato_routing.dart';
import 'ui/baato_search.dart';
import 'ui/breeze_map.dart';
import 'ui/monochrome_map.dart';
import 'ui/retro_map.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

BaatoAPI baatoAPI = Baato.api;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Baato.configure(
      apiKey: dotenv.get('baato_api_key'), enableLogging: true);
  runApp(const BaatoExampleApp());
}

class BaatoExampleApp extends StatelessWidget {
  const BaatoExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Baato Example App",
      home: ListScreen(),
    );
  }
}

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<HomeMenu> homeMenus = [];

  @override
  void initState() {
    super.initState();
    homeMenus.add(
      HomeMenu(title: "Search", subTitle: "Example for Baato Search API"),
    );
    homeMenus.add(
      HomeMenu(
        title: "Reverse",
        subTitle: "Example for Baato Reverse Search API",
      ),
    );
    homeMenus.add(
      HomeMenu(
        title: "Location Picker",
        subTitle: "Example-2 for Baato Reverse Search API",
      ),
    );
    homeMenus.add(
      HomeMenu(
        title: "Directions",
        subTitle: "Example for Baato Directions API",
      ),
    );
    homeMenus.add(
      HomeMenu(
        title: "Breeze Map",
        subTitle: "Example for Baato Breeze map style",
      ),
    );
    homeMenus.add(
      HomeMenu(
        title: "Monochrome Map",
        subTitle: "Example for Baato Monochrome map style",
      ),
    );
    homeMenus.add(
      HomeMenu(
        title: "Retro Map",
        subTitle: "Example for Baato Retro map style API",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Baato Flutter"),
      ),
      body: StringList(homeMenus: homeMenus),
    );
  }
}

class StringList extends StatelessWidget {
  final List<HomeMenu> homeMenus;

  const StringList({super.key, required this.homeMenus});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: homeMenus.length,
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(color: Colors.deepOrange),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${homeMenus[index].title}'),
          subtitle: Text('${homeMenus[index].subTitle}'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BaatoSearchExample()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BaatoReverseExample(),
                  ),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BaatoLocationPickerExample(),
                  ),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BaatoDirectionsExample(),
                  ),
                );
                break;
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BreezeMapStyle()),
                );
                break;
              case 5:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MonochromeMapStyle()),
                );
                break;
              case 6:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RetroMapStyle()),
                );
                break;
            }
          },
        );
      },
    );
  }
}
