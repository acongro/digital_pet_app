import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // main entry point
}

// app bar, scaffold, text
class MyApp extends StatelessWidget {
  // root, constructor
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // grab all common features with theme, navigate, title
      home: DefaultTabController(
        length: 3, // how many tabs
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    // lifecycle
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this, // makes animation run smooth
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    // used whenever you move, only load one tab at a time
    _tabController.dispose(); // release all resources, prevent memory leaks
    tabIndex.dispose();
    super.dispose(); // ref parent class
  }

  @override
  Widget build(BuildContext context) {
    // For the To do task hint: consider defining the widget and name of the tabs here
    final tabs = ['Dog', 'Cat', 'Cow'];

    return Scaffold(
      // standard layout for screen
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tabs Demo'),
        bottom: TabBar(
          controller: _tabController, // highlight active tab
          tabs: [for (final tab in tabs) Tab(text: tab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Text(
                    'Bark Bark',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'data:image/jpeg;base64,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',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Text(
                    'Meow',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://media.istockphoto.com/id/1463580205/photo/united-states-marines-boeing-f-a-18d-hornet-multirole-fighter-from-vmfa-225-vikings.jpg?s=612x612&w=0&k=20&c=oPI7IJBFPbL0oiUwZ9Gu55c0wIy3JxtdGwGg0-ZIkww=',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Text(
                    'Moo',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
