import 'package:flutter/material.dart';

void main() => runApp(const MyTempo());

class MyTempo extends StatelessWidget {
  const MyTempo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Object List',
      home: ObjectListPage(),
    );
  }
}

class ObjectListPage extends StatefulWidget {
  const ObjectListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ObjectListPageState createState() => _ObjectListPageState();
}

class _ObjectListPageState extends State<ObjectListPage> {
  // This list contains the data for the objects
  List<ObjectData> objects = [];

  // This string indicates the current sort mode for the list of objects
  String sortMode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Object List'),
        // Add a button to the app bar for sorting the list of objects
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.sort),
            // When the button is tapped, show the sort options
            onPressed: () {
              showSortOptions(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        // The item count is the number of objects in the list
        itemCount: objects.length,
        // This function creates the widget for a single object
        itemBuilder: (context, index) {
          // Get the object data for the current index
          ObjectData object = objects[index];

          debugPrint('index: $index');

          return ObjectCard(
            object: object,
            // When the delete button is tapped, delete the object from the list
            onDelete: () {
              setState(() {
                objects.removeAt(index);
              });
            },
            // When the edit button is tapped, show the edit object dialog
            onEdit: () {
              showEditObjectDialog(context, object, index);
            },
            index: index,
          );
        },
      ),
      // Add a floating action button for adding a new object
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        // When the button is tapped, show the add object dialog
        onPressed: () {
          showAddObjectDialog(context);
        },
      ),
    );
  }

  // This function shows a dialog where the user can enter the data for a new object
  void showAddObjectDialog(BuildContext context) {
    // Create a text controller for the time signature field
    final timeSignatureController = TextEditingController();
    // Create a text controller for the tempo field
    final tempoController = TextEditingController();
    // Create a text controller for the number of measures field
    final measuresController = TextEditingController();
    // Create a text controller for the description field
    final descriptionController = TextEditingController();

    // Create a new alert dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // The dialog has a title
          title: const Text('Add Object'),
          // The dialog has a content area that contains the input fields for the object data
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Use a DropdownButton for the time signature field
              DropdownButtonFormField(
                items: [
                  '1/4',
                  '2/4',
                  '3/4',
                  '4/4',
                  '5/4',
                  '6/4',
                  '7/4',
                  '8/4',
                ].map((timeSignature) {
                  return DropdownMenuItem(
                    value: timeSignature,
                    child: Text(timeSignature),
                  );
                }).toList(),
                onChanged: (value) {
                  timeSignatureController.text = value!;
                },
              ),
              // Use a TextFormField for the tempo field
              TextFormField(
                controller: tempoController,
                decoration: const InputDecoration(
                  labelText: 'Tempo',
                ),
                // Only allow numbers to be entered in the tempo field
                keyboardType: TextInputType.number,
              ),
              // Use a TextFormField for the number of measures field
              TextFormField(
                controller: measuresController,
                decoration: const InputDecoration(
                  labelText: 'Measures',
                ),
                // Only allow numbers to be entered in the measures field
                keyboardType: TextInputType.number,
              ),
              // Use a TextFormField for the description field
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),
          // The dialog has two buttons: one to cancel the operation and one to save the new object
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              // When the cancel button is tapped, just close the dialog
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              // When the save button is tapped, add the new object to the list and close the dialog
              onPressed: () {
                setState(() {
                  // Parse the input fields to get the values for the object data
                  String timeSignature = timeSignatureController.text;
                  int tempo = int.tryParse(tempoController.text) ?? 0;
                  int measures = int.tryParse(measuresController.text) ?? 0;
                  String description = descriptionController.text;

                  // Add the new object to the list
                  objects.add(ObjectData(
                      timeSignature: timeSignature,
                      tempo: tempo,
                      measures: measures,
                      description: description));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // This function shows a dialog where the user can edit the data for an existing object
  void showEditObjectDialog(
      BuildContext context, ObjectData object, int index) {
    // Create a text controller for the time signature field
    final timeSignatureController =
        TextEditingController(text: object.timeSignature);
    // Create a text controller for the tempo field
    final tempoController =
        TextEditingController(text: object.tempo.toString());
    // Create a text controller for the number of measures field
    final measuresController =
        TextEditingController(text: object.measures.toString());
    // Create a text controller for the description field
    final descriptionController =
        TextEditingController(text: object.description);

    // Create a new alert dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // The dialog has a title
          title: const Text('Edit Object'),
          // The dialog has a content area that contains the input fields for the object data
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Use a DropdownButton for the time signature field
              DropdownButtonFormField(
                items: [
                  '1/4',
                  '2/4',
                  '3/4',
                  '4/4',
                  '5/4',
                  '6/4',
                  '7/4',
                  '8/4',
                ].map((timeSignature) {
                  return DropdownMenuItem(
                    value: timeSignature,
                    child: Text(timeSignature),
                  );
                }).toList(),
                onChanged: (value) {
                  timeSignatureController.text = value!;
                },
              ),
              // Use a TextFormField for the tempo field
              TextFormField(
                controller: tempoController,
                decoration: const InputDecoration(
                  labelText: 'Tempo',
                ),
                // Only allow numbers to be entered in the tempo field
                keyboardType: TextInputType.number,
              ),
              // Use a TextFormField for the number of measures field
              TextFormField(
                controller: measuresController,
                decoration: const InputDecoration(
                  labelText: 'Measures',
                ),
                // Only allow numbers to be entered in the measures field
                keyboardType: TextInputType.number,
              ),
              // Use a TextFormField for the description field
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),
          // The dialog has two buttons: one to cancel the operation and one to save the edited object
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              // When the cancel button is tapped, just close the dialog
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              // When the save button is tapped, update the object data and close the dialog
              onPressed: () {
                setState(() {
                  // Parse the input fields to get the values for the updated object data
                  String timeSignature = timeSignatureController.text;
                  int tempo = int.tryParse(tempoController.text) ?? 0;
                  int measures = int.tryParse(measuresController.text) ?? 0;
                  String description = descriptionController.text;

                  // Update the object data in the list
                  objects[index] = ObjectData(
                      timeSignature: timeSignature,
                      tempo: tempo,
                      measures: measures,
                      description: description);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // This function shows a dialog where the user can select the sort mode for the list of objects
  void showSortOptions(BuildContext context) {
    // Create a new alert dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // The dialog has a title
          title: const Text('Sort Options'),
          // The dialog has a content area that contains the options for sorting the list of objects
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Use a radio button for each sort mode
              RadioListTile(
                title: const Text('Time Signature'),
                value: 'timeSignature',
                groupValue: sortMode,
                // When the radio button is tapped, set the sort mode to the time signature and sort the list of objects
                onChanged: (value) {
                  setState(() {
                    sortMode = value!;
                    objects.sort(
                        (a, b) => a.timeSignature.compareTo(b.timeSignature));
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile(
                title: const Text('Tempo'),
                value: 'tempo',
                groupValue: sortMode,
                // When the radio button is tapped, set the sort mode to the tempo and sort the list of objects
                onChanged: (value) {
                  setState(() {
                    sortMode = value!;
                    objects.sort((a, b) => a.tempo.compareTo(b.tempo));
                    sortMode = value;
                    objects.sort((a, b) => a.tempo.compareTo(b.tempo));
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile(
                title: const Text('Measures'),
                value: 'measures',
                groupValue: sortMode,
                // When the radio button is tapped, set the sort mode to the number of measures and sort the list of objects
                onChanged: (value) {
                  setState(() {
                    sortMode = value!;
                    objects.sort((a, b) => a.measures.compareTo(b.measures));
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile(
                title: const Text('Description'),
                value: 'description',
                groupValue: sortMode,
                // When the radio button is tapped, set the sort mode to the description and sort the list of objects
                onChanged: (value) {
                  setState(() {
                    sortMode = value!;
                    objects
                        .sort((a, b) => a.description.compareTo(b.description));
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          // The dialog has a button to cancel the operation
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              // When the cancel button is tapped, just close the dialog
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// This class represents the data for a single object
class ObjectData {
  // The time signature of the object
  final String timeSignature;
  // The tempo of the object
  final int tempo;
  // The number of measures in the object
  final int measures;
  // A description of the object
  final String description;

  ObjectData(
      {required this.timeSignature,
      required this.tempo,
      required this.measures,
      required this.description});
}

// This widget displays the data for a single object and provides buttons for editing or deleting the object
class ObjectCard extends StatelessWidget {
  // The object data
  final ObjectData object;
  // The index of the object in the list
  final int index;
  // The function to call when the object should be edited
  final Function onEdit;
  // The function to call when the object should be deleted
  final Function onDelete;

  const ObjectCard(
      {super.key,
      required this.object,
      required this.index,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Display the time signature of the object
            Text('Time Signature: ${object.timeSignature}'),
            // Display the tempo of the object
            Text('Tempo: ${object.tempo}'),
            // Display the number of measures in the object
            Text('Measures: ${object.measures}'),
            // Display the description of the object
            Text('Description: ${object.description}'),
            // Add a row of buttons for editing and deleting the object
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Add a button for editing the object
                IconButton(
                  icon: const Icon(Icons.edit),
                  // When the button is tapped, call the onEdit function
                  onPressed: () {
                    onEdit();
                  },
                ),
                // Add a button for deleting the object
                IconButton(
                  icon: const Icon(Icons.delete),
                  // When the button is tapped, call the onDelete function
                  onPressed: () {
                    onDelete();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
