import 'package:flutter/material.dart';
import 'package:hms_system_application/models/submission.dart';
import 'package:hms_system_application/providers/assignment_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class AssigmentsPage extends StatefulWidget {
  const AssigmentsPage({super.key});

  @override
  State<AssigmentsPage> createState() => _AssigmentsPageState();
}

class _AssigmentsPageState extends State<AssigmentsPage> {
  late VideoPlayerController _videoController;
  Submission submission = Submission(
    submissionId: 1,
    submissionDate: DateTime.now(),
    assignmentId: 1,
    submissionGrade: null,
    files: [],
  );
  List files = [
    'https://media.gq.com/photos/59a9a273dc3ba42b1cdca2e9/16:9/w_2560%2Cc_limit/2017-09_GQ-FITNESS-Stretching_3x2.jpg',
    'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/10/shutterstock_657588133_header-1024x575.jpg?w=1155&h=1528',
    'https://blog.nasm.org/hubfs/benefits-of-stretching.jpg',
    'https://media.gq.com/photos/59a9a273dc3ba42b1cdca2e9/16:9/w_2560%2Cc_limit/2017-09_GQ-FITNESS-Stretching_3x2.jpg',
    'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/10/shutterstock_657588133_header-1024x575.jpg?w=1155&h=1528',
    'https://blog.nasm.org/hubfs/benefits-of-stretching.jpg'
  ];

  @override
  void initState() {
    super.initState();

    _videoController =
        VideoPlayerController.networkUrl(Uri.parse(files[0] ?? ''))
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AssignmentProvider>(
      builder: (context, assignmentProvider, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF22489E),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text(
            'Assignment Details',
            overflow: TextOverflow.fade,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(Icons.help_outline),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 24.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Assignment 1 title',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'You have 5 minutes to record your review. Your video will be submitted automatically.',
                          style: TextStyle(fontSize: 19),
                          softWrap: true,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(color: Colors.grey),
                        ),
                        const Text(
                          'Assignment status: In Progress',
                          style: TextStyle(fontSize: 19),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(color: Colors.grey),
                        ),
                        const Row(
                          children: [
                            Card.outlined(
                              color: Color(0xFFF0F3F4),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.event_available),
                              ),
                            ),
                            Text(
                              'Open date: 2024/07/12',
                              style: TextStyle(fontSize: 19),
                              softWrap: true,
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Card.outlined(
                              color: Color(0xFFF0F3F4),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.event_busy),
                              ),
                            ),
                            Text(
                              'Close date: 2024/07/18',
                              style: TextStyle(fontSize: 19),
                              softWrap: true,
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Card.outlined(
                              color: Color(0xFFF0F3F4),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.timer),
                              ),
                            ),
                            Text(
                              'Maximum duration: 30 min',
                              style: TextStyle(fontSize: 19),
                              softWrap: true,
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Card.outlined(
                              color: Color(0xFFF0F3F4),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.grade),
                              ),
                            ),
                            Text(
                              'Maximum grade: 100',
                              style: TextStyle(fontSize: 19),
                              softWrap: true,
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(color: Colors.grey),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Column(
                              children: [
                                SizedBox(
                                  width: constraints.maxWidth,
                                  height: constraints.maxWidth - 100,
                                  child: _videoController.value.isInitialized
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            border: Border.all(
                                                color: Colors.grey, width: 2.0),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: AspectRatio(
                                            aspectRatio: _videoController
                                                .value.aspectRatio,
                                            child:
                                                VideoPlayer(_videoController),
                                          ),
                                        )
                                      : const Center(
                                          child: Text(
                                            'No previous submissions',
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: files.map((file) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0,
                                          vertical: 8.0,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3.0),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 2.0,
                                            ),
                                          ),
                                          width: 100,
                                          height: 100,
                                          child: Image.network(
                                            file,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22489E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Upload submission',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
