import 'package:flutter/material.dart';
import 'package:hms_system_application/models/assignment.dart';
import 'package:hms_system_application/models/module.dart';
import 'package:hms_system_application/pages/assigments_page.dart';
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
  List<Module> modules = [];
  List<Assignment> assignments = [];

  @override
  void initState() {
    super.initState();
    getModules();
    getAssignments();
  }

  void getModules() async {
    ModuleProvider moduleProvider = context.read<ModuleProvider>();
    setState(() {
      modules = moduleProvider.modules;
    });
  }

  void getAssignments() async {
    AssignmentProvider assignmentProvider = context.read<AssignmentProvider>();
    setState(() {
      assignments = assignmentProvider.assignments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Assignments',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF22489E),
      ),
      body: modules.isEmpty
          ? _buildNoModulesMessage()
          : _buildModulesAndAssignments(),
    );
  }

  Widget _buildNoModulesMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No modules assigned 📚",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "You don't have any modules assigned yet.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[900],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModulesAndAssignments() {
    Module selectedModule = modules[_selectedModuleIndex];
    List<Assignment> filteredAssignments = assignments
        .where((assignment) => assignment.moduleId == selectedModule.moduleId)
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildModulesList(),
          _buildAssignmentsTitle(),
          _buildAssignmentsList(filteredAssignments),
        ],
      ),
    );
  }

  Widget _buildModulesList() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: modules.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedModuleIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedModuleIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF22489E) : Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
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
    );
  }

  Widget _buildAssignmentsTitle() {
    return const Padding(
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
    );
  }

  Widget _buildAssignmentsList(List<Assignment> filteredAssignments) {
    return Expanded(
      child: filteredAssignments.isNotEmpty
          ? ListView.builder(
              itemCount: filteredAssignments.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filteredAssignments[index].assignmentTitle,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            filteredAssignments[index].assignmentDescription,
                            style: const TextStyle(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              DateFormat('dd/MM/yyyy at HH:mm')
                                  .format(filteredAssignments[index].dueDate),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                      '/assignment-details',
                      arguments: assignments.first,
                    );

                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => AssigmentsPage(
                    //       assignment: filteredAssignments[index],
                    //     ),
                    //   ),
                    // );
                  },
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
                      color: Colors.grey[900],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
