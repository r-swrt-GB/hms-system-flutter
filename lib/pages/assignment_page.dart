import 'package:flutter/material.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  int _selectedModuleIndex = 0;
  int _selectedTabIndex = 1; // Default to Assignments tab

  // List of modules
  List<String> modules = [
    "PSY101",
    "BIO201",
    "SOC101",
    "COG301",
    "PSY202",
    "ANTH301",
    "PSY303",
    "ETH101",
    "ANTH102"
  ];

  // Assignments now have a 'module' field to associate with a specific module
  List<Map<String, String>> assignments = [
    {
      "module": "PSY101",
      "title": "Introduction to Psychology: Essay",
      "description": "Write an essay on the impact of cognitive psychology on modern therapy.",
      "dueDate": "Due: Sept 20, 2024"
    },
    {
      "module": "BIO201",
      "title": "Human Anatomy: Project",
      "description": "Create a detailed project on the human circulatory system.",
      "dueDate": "Due: Sept 25, 2024"
    },
    {
      "module": "SOC101",
      "title": "Sociology Basics: Report",
      "description": "Submit a report on social stratification and its effects on education.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "COG301",
      "title": "Cognitive Science: Presentation",
      "description": "Prepare a presentation on the role of perception in cognitive processes.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "PSY202",
      "title": "Developmental Psychology: Case Study",
      "description": "Analyze a case study on child development stages.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "ANTH301",
      "title": "Biological Anthropology: Research Paper",
      "description": "Submit a research paper on the evolutionary adaptations of humans.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "BIO201",
      "title": "Human Anatomy: Project",
      "description": "Create a detailed project on the human circulatory system.",
      "dueDate": "Due: Sept 25, 2024"
    },
    {
      "module": "SOC101",
      "title": "Sociology Basics: Report",
      "description": "Submit a report on social stratification and its effects on education.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "COG301",
      "title": "Cognitive Science: Presentation",
      "description": "Prepare a presentation on the role of perception in cognitive processes.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "PSY202",
      "title": "Developmental Psychology: Case Study",
      "description": "Analyze a case study on child development stages.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "ANTH301",
      "title": "Biological Anthropology: Research Paper",
      "description": "Submit a research paper on the evolutionary adaptations of humans.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "PSY101",
      "title": "Introduction to Psychology: Essay",
      "description": "Write an essay on the impact of cognitive psychology on modern therapy.",
      "dueDate": "Due: Sept 20, 2024"
    },
    {
      "module": "BIO201",
      "title": "Human Anatomy: Project",
      "description": "Create a detailed project on the human circulatory system.",
      "dueDate": "Due: Sept 25, 2024"
    },
    {
      "module": "SOC101",
      "title": "Sociology Basics: Report",
      "description": "Submit a report on social stratification and its effects on education.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "COG301",
      "title": "Cognitive Science: Presentation",
      "description": "Prepare a presentation on the role of perception in cognitive processes.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "PSY202",
      "title": "Developmental Psychology: Case Study",
      "description": "Analyze a case study on child development stages.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "ANTH301",
      "title": "Biological Anthropology: Research Paper",
      "description": "Submit a research paper on the evolutionary adaptations of humans.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "BIO201",
      "title": "Human Anatomy: Project",
      "description": "Create a detailed project on the human circulatory system.",
      "dueDate": "Due: Sept 25, 2024"
    },
    {
      "module": "SOC101",
      "title": "Sociology Basics: Report",
      "description": "Submit a report on social stratification and its effects on education.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "COG301",
      "title": "Cognitive Science: Presentation",
      "description": "Prepare a presentation on the role of perception in cognitive processes.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "PSY202",
      "title": "Developmental Psychology: Case Study",
      "description": "Analyze a case study on child development stages.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "ANTH301",
      "title": "Biological Anthropology: Research Paper",
      "description": "Submit a research paper on the evolutionary adaptations of humans.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "PSY101",
      "title": "Introduction to Psychology: Essay",
      "description": "Write an essay on the impact of cognitive psychology on modern therapy.",
      "dueDate": "Due: Sept 20, 2024"
    },
    {
      "module": "BIO201",
      "title": "Human Anatomy: Project",
      "description": "Create a detailed project on the human circulatory system.",
      "dueDate": "Due: Sept 25, 2024"
    },
    {
      "module": "SOC101",
      "title": "Sociology Basics: Report",
      "description": "Submit a report on social stratification and its effects on education.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "COG301",
      "title": "Cognitive Science: Presentation",
      "description": "Prepare a presentation on the role of perception in cognitive processes.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "PSY202",
      "title": "Developmental Psychology: Case Study",
      "description": "Analyze a case study on child development stages.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "ANTH301",
      "title": "Biological Anthropology: Research Paper",
      "description": "Submit a research paper on the evolutionary adaptations of humans.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "BIO201",
      "title": "Human Anatomy: Project",
      "description": "Create a detailed project on the human circulatory system.",
      "dueDate": "Due: Sept 25, 2024"
    },
    {
      "module": "SOC101",
      "title": "Sociology Basics: Report",
      "description": "Submit a report on social stratification and its effects on education.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "COG301",
      "title": "Cognitive Science: Presentation",
      "description": "Prepare a presentation on the role of perception in cognitive processes.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "PSY202",
      "title": "Developmental Psychology: Case Study",
      "description": "Analyze a case study on child development stages.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "ANTH301",
      "title": "Biological Anthropology: Research Paper",
      "description": "Submit a research paper on the evolutionary adaptations of humans.",
      "dueDate": "Due: Sept 30, 2024"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter assignments based on the selected module
    String selectedModule = modules[_selectedModuleIndex];
    List<Map<String, String>> filteredAssignments = assignments
        .where((assignment) => assignment['module'] == selectedModule)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('HMS Systems'),
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Colors.grey,

      body: Column(
        children: [
          // Horizontal Scrollable Pill-shaped Module Names
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: modules.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedModuleIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedModuleIndex = index; // Update selected module index
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        modules[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Title for Assignments
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Assignments:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Scrollable List of Filtered Assignments
          Expanded(
            child: ListView.builder(
              itemCount: filteredAssignments.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          filteredAssignments[index]["title"]!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          filteredAssignments[index]["description"]!,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          filteredAssignments[index]["dueDate"]!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar with grey background and blue icons
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,  // Set the background color of the bar to grey
        selectedItemColor: Colors.blue, // Set selected icon color to blue
        unselectedItemColor: Colors.blue, // Set unselected icon color to blue
        
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Assignments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedTabIndex,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index; // Update selected tab index
          });
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AssignmentPage(),
  ));
}
