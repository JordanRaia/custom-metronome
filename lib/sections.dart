import 'package:flutter/material.dart';
import 'package:custom_metronome/globals.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:custom_metronome/ad_helper.dart';

class EditSection extends StatefulWidget {
  const EditSection({super.key});

  @override
  EditSectionState createState() => EditSectionState();
}

class EditSectionState extends State<EditSection> {
  // Edit a Section
  void showEditSection(BuildContext context, int index, Section section) {
    final nameController = TextEditingController(text: section.name);
    final measuresController =
        TextEditingController(text: section.measures.toString());

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Section ${nameController.text}'),
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter a name for this section',
                ),
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                controller: measuresController,
                decoration: const InputDecoration(
                  labelText: 'Measures',
                  hintText: 'Enter the number of measures',
                ),
                keyboardType: TextInputType.number,
              ),
            ]),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // check if name already exists
                  for (int i = 0; i < sections.length; i++) {
                    if (sections[i].name == nameController.text) {
                      // check if it's the same section
                      if (sections[i] == section) {
                        break;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('A section with the '
                                'name ${nameController.text} already exists.'),
                          ),
                        );
                        return;
                      }
                    }
                  }

                  // check if measures is above 0
                  if (int.parse(measuresController.text) <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Measures must be above 0.'),
                      ),
                    );
                    return;
                  }
                  setState(() {
                    sections[index].name = nameController.text;
                    sections[index].measures =
                        int.parse(measuresController.text);
                  });
                  // save changes
                  sharedPref.save("user", userData);
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          );
        });
  }

  // add a new section
  void showAddSection(BuildContext context) {
    final nameController = TextEditingController();
    final measuresController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Section'),
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter a name for this section',
                ),
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                controller: measuresController,
                decoration: const InputDecoration(
                  labelText: 'Measures',
                  hintText: 'Enter the number of measures',
                ),
                keyboardType: TextInputType.number,
              ),
            ]),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // check if measures is above 0
                  if (int.parse(measuresController.text) <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Measures must be above 0.'),
                      ),
                    );
                    return;
                  }
                  setState(() {
                    String name = '';
                    if (nameController.text == '') {
                      name = getSectionName(defaultName);
                    } else {
                      name = getSectionName(nameController.text);
                    }
                    int measures = int.tryParse(measuresController.text) ??
                        defaultMeasures;

                    sections.add(Section(name: name, measures: measures));
                  });
                  // save changes
                  sharedPref.save("user", userData);
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          );
        });
  }

  String getSectionName(String name) {
    // check if name already exists
    for (int i = 0; i < sections.length; i++) {
      if (sections[i].name == name) {
        return getSectionName('$name(1)');
      }
    }
    return name;
  }

  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();

    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
            child: Text((userData.metronomeData[userData.currentIndex].name))),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showAddSection(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: _bannerAd == null
          ? null
          : SizedBox(
              height: _bannerAd!.size.height.toDouble(),
              width: double.infinity,
              child: AdWidget(ad: _bannerAd!),
            ),
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.music_note),
            title: Text(sections[index].name.toString()),
            subtitle: Text(getMeasureRangeSection(sections, index)),
            trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      showEditSection(context, index, sections[index]);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        sections.removeAt(index);
                      });

                      // save changes
                      sharedPref.save("user", userData);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ]),
          );
        },
      ),
    );
  }
}
