import 'package:flutter/material.dart';
import 'package:hms_system_application/models/assignment.dart';
import 'package:hms_system_application/models/module.dart';
import 'package:hms_system_application/providers/assignment_provider.dart';
import 'package:hms_system_application/providers/module_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  int _selectedModuleIndex = 0;

  // List of modules
  List<Module> modules = [];

<<<<<<< HEAD
  // Assignments now have a 'module' field to associate with a specific module
  List<Map<String, String>> assignments = [
    {
      "module": "PSY101",
      "title": "Introduction to Psychology: Essay",
      "description":
          "Write an essay on the impact of cognitive psychology on modern therapy.",
      "dueDate": "Due: Sept 20, 2024"
    },
    {
      "module": "BIO201",
      "title": "Human Anatomy: Project",
      "description":
          "Create a detailed project on the human circulatory system.",
      "dueDate": "Due: Sept 25, 2024"
    },
    {
      "module": "SOC101",
      "title": "Sociology Basics: Report",
      "description":
          "Submit a report on social stratification and its effects on education.",
      "dueDate": "Due: Sept 30, 2024"
    },
    {
      "module": "COG301",
      "title": "Cognitive Science: Presentation",
      "description":
          "Prepare a presentation on the role of perception in cognitive processes.",
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
      "description":
          "Submit a research paper on the evolutionary adaptations of humans.",
      "dueDate": "Due: Sept 30, 2024"
    },
    // (Additional assignments omitted for brevity)
  ];
=======
  List<Assignment> assignments = [];

  @override
  void initState() {
    super.initState();
    getModules();
    getAssignments();
  }

  void getModules() async {
    ModuleProvider moduleProvider = context.read<ModuleProvider>();
    modules = moduleProvider.modules;
  }

  void getAssignments() async {
    AssignmentProvider assignmentProvider = context.read<AssignmentProvider>();
    assignments = assignmentProvider.assignments;
  }
>>>>>>> devlopment

  @override
  Widget build(BuildContext context) {
    // Filter assignments based on the selected module
    Module selectedModule = modules[_selectedModuleIndex];
    List<Assignment> filteredAssignments = assignments
        .where((assignment) => assignment.moduleId == selectedModule.moduleId)
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
                      _selectedModuleIndex =
                          index; // Update selected module index
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        modules[index].moduleCode,
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

          // Scrollable List of Filtered Assignments or 'No Assignments' message
          Expanded(
            child: filteredAssignments.isNotEmpty
                ? ListView.builder(
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
                                filteredAssignments[index].assignmentTitle!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                filteredAssignments[index]
                                    .assignmentDescription!,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              Text(
                                DateFormat('dd/MM/yyyy at HH:mm')
                                    .format(filteredAssignments[index].dueDate),
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
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No assignments 😊",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
