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

Widget activeBottom(
    VoidCallback onTap, String title, Color bgColor, Color textColor) {
  return TextButton(
    onPressed: onTap,
    style: TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      backgroundColor: bgColor,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 14, color: textColor, fontWeight: FontWeight.w500),
      ),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentLanguage = 'English';

  String selectedThemeKey = 'System Theme';
  final List<String> themeOptions = [
    'System Theme',
    'Light',
    'Dark',
  ];
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
      body: LayoutBuilder(builder: (context, constrants) {
        return ListView.custom(
          padding: EdgeInsets.zero,
          shrinkWrap: false,
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: examples.length,
            (context, index) {
              final example = examples[index];
              return ExamplesWidget(
                title: example.title,
                subtitle: example.subtitle,
                height: constrants.maxHeight / examples.length,
                width: constrants.maxWidth,
                color: index % 2 == 0
                    ? Theme.of(context)
                        .colorScheme
                        .surface // Alternating row colors
                    : Colors.white,
                onTap: () {
                  if (example.title == 'HomeExample') {
                    _navigateToHomeView(context); // Navigate to HomeView
                  } else if (example.title == 'ProfileView') {
                    showProfileView(); // Show ProfileView
                  } else if (example.title == 'SettingsView') {
                    showSettingsView(); // Show ProfileView
                  } else if (example.title == 'AddEditLabelView') {
                    showAddLabelView(); // Show AddLabelView
                  } else if (example.title == 'SureView') {
                    showSureView(
                        'Are you sure want to Delete?',
                        'Once Deleted a label cannot be undo, are you sure want\nto Delete?',
                        () {});
                  } else {
                    _showSubtitleDialog(context, example); // Show dialog on tap
                  }
                },
              );
            },
          ),
        );
      }),
    );
  }

  void showProfileView() {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: const Color(0xff3D3D3D),
            ),
            AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              backgroundColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Image.asset('assets/logo.png'),
                      const Text(
                        'Welcome to Arfoon Note',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Full Name'),
                      const SizedBox(height: 8),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'Full Name',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xffE4E4E7))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xffE4E4E7))),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          activeBottom(() {
                            Navigator.of(context).pop(); // Close the dialog
                          }, 'Countinue', Colors.black87, Colors.white),
                          const SizedBox(height: 16),
                          const Text(
                            'By using X note you agree to Terms of Services and Privacy Policy',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void showSettingsView() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: const Color(0xff3D3D3D),
              ),
              AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                backgroundColor: Colors.white,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/settings.png'),
                        const Text(
                          'Arfoon Note Settings',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Change Theme'),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffE4E4E7)),
                              borderRadius: BorderRadius.circular(8)),
                          child: DropdownButton<String>(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            value: currentLanguage,
                            isExpanded: true,
                            underline: const SizedBox(),
                            icon: Image.asset('assets/updown.png'),
                            onChanged: (String? newLanguage) {
                              if (newLanguage != null) {
                                setState(() {
                                  currentLanguage = newLanguage;
                                });
                              }
                              Navigator.of(context).pop();
                            },
                            items: <String>['English', 'Pashto', 'Dari']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Theme Selection
                        const Text('Change Language'),
                        const SizedBox(height: 10),

                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffE4E4E7)),
                              borderRadius: BorderRadius.circular(8)),
                          child: DropdownButton<String>(
                            enableFeedback: false,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            value: selectedThemeKey,
                            isExpanded: true,
                            underline: const SizedBox(),
                            icon: Image.asset('assets/updown.png'),
                            onChanged: (String? newThemeKey) {
                              if (newThemeKey != null) {
                                setState(() {
                                  selectedThemeKey = newThemeKey;
                                });
                              }
                              Navigator.of(context).pop();
                            },
                            items: themeOptions
                                .map<DropdownMenuItem<String>>((String key) {
                              return DropdownMenuItem<String>(
                                value: key,
                                child: Text(key),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
      },
    );
  }

  void showSureView(String title, String subtitle, VoidCallback onAccepte) {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: const Color(0xff3D3D3D),
            ),
            AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              backgroundColor: Colors.white,
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subtitle), // Display the subtitle
                ],
              ),
              actions: [
                activeBottom(() {
                  Navigator.of(context).pop();
                },
                    'Cancel',
                    const Color(
                      0xffFBFBFB,
                    ),
                    const Color(0xff646464)),
                activeBottom(() {
                  onAccepte();
                  Navigator.of(context).pop(); // Close the dialog
                }, 'Delete It.', Colors.black87, Colors.white),
              ],
            ),
          ],
        );
      },
    );
  }

  void showAddLabelView() {
    String labelText = '';

    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: const Color(0xff3D3D3D),
            ),
            AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              backgroundColor: Colors.white,
              title: const Text('New Label'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Label Name'),
                  const SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: TextEditingController(text: labelText),
                    onChanged: (value) {
                      labelText = value;
                    },
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xffE4E4E7))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xffE4E4E7))),
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    activeBottom(() {
                      onDelete();
                      Navigator.of(context).pop(); // Close the dialog
                    }, 'Delete', const Color(0xffFBFBFB),
                        const Color(0xff646464)),
                    const Spacer(),
                    activeBottom(() {
                      onSubmit(labelText);
                      Navigator.of(context).pop(); // Close the dialog
                    }, 'Save Label', Colors.black87, Colors.white),
                  ],
                )
              ],
            ),
          ],
        );
      },
    );
  }

  void _showSubtitleDialog(BuildContext context, ExampleModel example) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(example.title),
        content: Text(example.subtitle), // Subtitle content
        actions: [
          activeBottom(
              () => Navigator.of(context).pop(),
              'Close',
              const Color(
                0xffFBFBFB,
              ),
              const Color(0xff646464)),
        ],
      ),
    );
  }

  void onDelete() {
    debugPrint('Delete button pressed');
  }

  void onSubmit(String labelText) {
    debugPrint('Submit button pressed with label: $labelText');
  }

  void onAccepte() {
    debugPrint('Accept button pressed');
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    required this.height,
    required this.width,
  });

  final String title;
  final String subtitle;
  final Color color;
  final double height;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
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
            Flexible(
              child: Text(
                overflow: TextOverflow.visible,
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
