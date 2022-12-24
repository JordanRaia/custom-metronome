import 'package:flutter/material.dart';
import 'package:custom_metronome/globals.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:custom_metronome/ad_helper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  // Edit the lead in
  void showEditLeadIn(BuildContext context, Metronome metronome) {
    final tempoController =
        TextEditingController(text: metronome.tempo.toString());
    final beatsController =
        TextEditingController(text: metronome.beatsPerMeasure.toString());
    final timeController =
        TextEditingController(text: metronome.timeSignature.toString());
    final measuresController =
        TextEditingController(text: metronome.measures.toString());

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit Lead In'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: tempoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Tempo',
                  ),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                      child: DropdownButtonFormField(
                        items: [
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                          '11',
                          '12',
                        ].map((beatsPerMeasure) {
                          return DropdownMenuItem(
                            value: beatsPerMeasure,
                            child: Text(beatsPerMeasure),
                          );
                        }).toList(),
                        onChanged: (value) {
                          beatsController.text = value!;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Beats',
                        ),
                        value: metronome.beatsPerMeasure.toString(),
                      ),
                    ),
                    const Text('/', style: TextStyle(fontSize: 40)),
                    SizedBox(
                      width: 50,
                      child: DropdownButtonFormField(
                        items: [
                          '4',
                          '8',
                          '16',
                          '32',
                        ].map((timeSignature) {
                          return DropdownMenuItem(
                            value: timeSignature,
                            child: Text(timeSignature),
                          );
                        }).toList(),
                        onChanged: (value) {
                          timeController.text = value!;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Value',
                        ),
                        value: metronome.timeSignature.toString(),
                      ),
                    ),
                  ],
                ),
                DropdownButtonFormField(
                  items: [
                    '1',
                    '2',
                    '3',
                    '4',
                  ].map((measures) {
                    return DropdownMenuItem(
                      value: measures,
                      child: Text(measures),
                    );
                  }).toList(),
                  onChanged: (value) {
                    measuresController.text = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Measures',
                  ),
                  value: metronome.measures.toString(),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    int tempo =
                        int.tryParse(tempoController.text) ?? defaultTempo;
                    int beatsPerMeasure = int.tryParse(beatsController.text) ??
                        defaultBeatsPerMeasure;
                    int timeSignature = int.tryParse(timeController.text) ??
                        defaultTimeSignature;
                    int measures = int.tryParse(measuresController.text) ?? 1;

                    userData.leadInMetronome = Metronome(
                        tempo: tempo,
                        beatsPerMeasure: beatsPerMeasure,
                        timeSignature: timeSignature,
                        measures: measures);
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
          title: const Text('Settings'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        bottomNavigationBar: _bannerAd == null
            ? null
            : SizedBox(
                height: _bannerAd!.size.height.toDouble(),
                width: double.infinity,
                child: AdWidget(ad: _bannerAd!),
              ),
        body: ListView(children: [
          const ListTile(
            title: Text('Version'),
            subtitle: Text('1.0'),
          ),
          CheckboxListTile(
            title: const Text('Lead In'),
            value: userData.leadIn,
            onChanged: (value) {
              setState(() {
                userData.leadIn = value!;
              });
              // save user data
              sharedPref.save("user", userData);
            },
          ),
          ListTile(
            title: const Text('Edit Lead In'),
            subtitle: Text('${userData.leadInMetronome.tempo}, '
                '${userData.leadInMetronome.beatsPerMeasure}/'
                '${userData.leadInMetronome.timeSignature}, '
                '${userData.leadInMetronome.measures} measures'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                showEditLeadIn(context, userData.leadInMetronome);
              },
            ),
          ),
        ]));
  }
}
