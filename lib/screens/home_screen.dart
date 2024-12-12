import 'package:flutter/material.dart';

class ExampleModel {
  final String title;
  final String subtitle;
  ExampleModel({required this.title, required this.subtitle});
}

final List<ExampleModel> examples = [
  ExampleModel(
    title: 'HomeExample',
    subtitle:
        'Push to HomeExample and Example returns HomeView with calls of getNote(file), getLabels, addNote, onSettingTap, onProfileTap.',
  ),
  ExampleModel(
    title: 'ProfileView',
    subtitle:
        'This is a dialog and show as ProfileView().show(context) and has parameters of: title, submitText, onSubmit(s)',
  ),
  ExampleModel(
    title: 'SettingsView',
    subtitle:
        'This is a dialog and show as SettingsView().show(context) and has parameters of currentLanguage, onLanguageChanged(llang), currentTheme, onThemeChanged(t)',
  ),
  ExampleModel(
    title: 'AddEditLabelView',
    subtitle:
        'This is a dialog and show as AddEditLabelView().show(context) and has parameters of: title, onSubmit(s), onDelete',
  ),
  ExampleModel(
    title: 'SureView',
    subtitle:
        'This is a dialog and show as SureView().show(context) and has parameters of: title, subtitle, sureText, onSure()',
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentLanguage = 'English';

  ThemeData currentTheme = ThemeData.light();

  String label = 'Initial Label';

  void submitLabel(String labelText) {
    setState(() {
      label = labelText;
    });
    print('Label Submitted: $labelText');
  }

  void deleteLabel() {
    setState(() {
      label = '';
    });
    print('Label Deleted');
  }

  void changeLanguage(String language) {
    setState(() {
      currentLanguage = language;
    });
  }

  void changeTheme(ThemeData theme) {
    setState(() {
      currentTheme = theme;
    });
  }

  void onSureAction() {
    print('Action confirmed!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'Examples',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: examples.length,
        itemBuilder: (context, index) {
          final example = examples[index];
          return ExamplesWidget(
            title: example.title,
            subtitle: example.subtitle,
            color: index % 2 == 0
                ? Theme.of(context)
                    .colorScheme
                    .surface // Alternating row colors
                : Colors.white,
            onTap: () {
              if (example.title == 'HomeExample') {
                _navigateToHomeView(context); // Navigate to HomeView
              } else if (example.title == 'ProfileView') {
                ProfileView().show(context); // Show ProfileView dialog
              } else if (example.title == 'SettingsView') {
                SettingsView().show(
                  context,
                  currentLanguage,
                  changeLanguage,
                  currentTheme,
                  changeTheme,
                ); // Show ProfileView dialog
              } else if (example.title == 'AddEditLabelView') {
                AddEditLabelView().show(
                  context,
                  label,
                  submitLabel,
                  deleteLabel,
                ); // Show AddEditLabelView dialog
              } else if (example.title == 'SureView') {
                SureView().show(
                    context, 'Sure', 'Are you sure?', 'Sure', onSureAction);
              } else {
                _showSubtitleDialog(context, example); // Show dialog on tap
              }
            },
          );
        },
      ),
    );
  }

  void _showSubtitleDialog(BuildContext context, ExampleModel example) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(example.title),
        content: Text(example.subtitle), // Subtitle content
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Close dialog
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

void _navigateToHomeView(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const HomeView(),
    ),
  );
}

class SureView {
  void show(BuildContext context, String title, String subtitle,
      String sureText, Function() onSure) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subtitle), // Display the subtitle
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onSure();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(sureText),
            ),
          ],
        );
      },
    );
  }
}

class AddEditLabelView {
  void show(BuildContext context, String title, Function(String) onSubmit,
      Function() onDelete) {
    String labelText = title;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title.isEmpty ? 'Add Label' : 'Edit Label'),
          content: TextField(
            controller: TextEditingController(text: labelText),
            onChanged: (value) {
              labelText = value;
            },
            decoration: const InputDecoration(
              labelText: 'Label',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            if (title.isNotEmpty)
              TextButton(
                onPressed: () {
                  onDelete();
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Delete'),
              ),
            TextButton(
              onPressed: () {
                onSubmit(labelText);
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}

class ProfileView {
  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String inputText = '';
        return AlertDialog(
          title: const Text('ProfileView'), // Dialog title
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter your details below:'),
              TextField(
                onChanged: (value) {
                  inputText = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Input',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                print('Submitted: $inputText');
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}

class SettingsView {
  void show(
      BuildContext context,
      String currentLanguage,
      Function(String) onLanguageChanged,
      ThemeData currentTheme,
      Function(ThemeData) onThemeChanged) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: currentLanguage,
                onChanged: (String? newLanguage) {
                  if (newLanguage != null) {
                    onLanguageChanged(newLanguage);
                  }
                },
                items: <String>['English', 'Pashto', 'Dari']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Theme Selection
              Row(
                children: [
                  const Text('Select Theme:'),
                  Switch(
                    value: currentTheme.brightness == Brightness.dark,
                    onChanged: (bool isDarkMode) {
                      onThemeChanged(
                          isDarkMode ? ThemeData.dark() : ThemeData.light());
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => _getNote(),
              child: const Text('Get Note'),
            ),
            ElevatedButton(
              onPressed: () => _getLabels(),
              child: const Text('Get Labels'),
            ),
            ElevatedButton(
              onPressed: () => _addNote(),
              child: const Text('Add Note'),
            ),
            ElevatedButton(
              onPressed: () => _onSettingTap(),
              child: const Text('Settings Tap'),
            ),
            ElevatedButton(
              onPressed: () => _onProfileTap(),
              child: const Text('Profile Tap'),
            ),
          ],
        ),
      ),
    );
  }

  void _getNote() {
    final notes = {'file1': 'Note 1', 'file2': 'Note 2'};
    print('Fetched Notes: $notes');
  }

  void _getLabels() {
    final labels = ['Work', 'Personal', 'Urgent'];
    print('Fetched Labels: $labels');
  }

  void _addNote() {
    print('Note added successfully.');
  }

  void _onSettingTap() {
    print('Settings tapped.');
  }

  void _onProfileTap() {
    print('Profile tapped.');
  }
}

class ExamplesWidget extends StatelessWidget {
  const ExamplesWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Semantics(
        button: true,
        label: title,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          color: color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
