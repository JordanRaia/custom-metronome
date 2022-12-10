import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool isMute = false;
  int beatNum = 4;
  int beat = 1;
  int timeSignature = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Untitled'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isMute = !isMute;
              });
            },
            icon: Icon(isMute ? Icons.volume_mute : Icons.volume_up),
            color: isMute ? Colors.teal : Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2.0),
            color: Colors.cyan,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.black,
            width: double.infinity,
            height: (MediaQuery.of(context).size.height * 0.35) - 80,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < beatNum; i++)
                    const Icon(
                      Icons.circle,
                      color: Colors.cyan,
                      size: 45,
                    ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            child: Container(
              margin: const EdgeInsets.all(5.0),
              height: (MediaQuery.of(context).size.height * 0.20) - 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Container(
                margin: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [Text('Measure'), Text('1')],
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [Text('Time Signature'), Text('4/4')],
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            height: (MediaQuery.of(context).size.height * 0.425) - 80,
          ),
          Container(
            color: Colors.black12,
            child: Container(
              margin: const EdgeInsets.all(5.0),
              height: (MediaQuery.of(context).size.height * 0.30) - 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Container(
                margin: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.remove,
                              size: 45,
                            )),
                        const Text(
                          '100%',
                          style: TextStyle(fontSize: 25),
                        ),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              size: 45,
                            )),
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow_rounded),
                      iconSize: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
