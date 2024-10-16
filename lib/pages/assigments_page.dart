import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hms_system_application/models/assignment.dart';
import 'package:hms_system_application/models/submission.dart';
import 'package:hms_system_application/providers/assignment_provider.dart';
import 'package:hms_system_application/providers/submission_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

class AssigmentsPage extends StatefulWidget {
  final Assignment assignment;
  final Submission? submission;
  const AssigmentsPage({super.key, required this.assignment, this.submission});

  @override
  State<AssigmentsPage> createState() => _AssigmentsPageState();
}

class _AssigmentsPageState extends State<AssigmentsPage> {
  late VideoPlayerController _videoController;

  bool isLoading = false;
  bool _hasVideo = false;
  final List<Map<String, dynamic>> _videoFiles = [];
  int _selectedVideoIndex = 0;
  List<DropdownMenuItem<int>> listItems = [];

  @override
  void initState() {
    super.initState();

    _initializeVideoPlayer();
    setListItems();
  }

  void setListItems() {
    setState(() {
      isLoading = true;
      listItems = [];
      if (widget.submission == null) {
        for (var i = 0; i < widget.assignment.maxVideos; i++) {
          bool hasVideo = false;
          for (var k = 0; k < _videoFiles.length; k++) {
            if (_videoFiles[k]['attatchment_number'] == i) {
              hasVideo = true;
            }
          }
          listItems.add(DropdownMenuItem<int>(
            value: i,
            child: Text('Attachment ${i + 1} ${hasVideo ? '(Uploaded)' : ''}'),
          ));
        }
      } else {
        for (var i = 0; i < widget.submission!.files!.length; i++) {
          setState(() {
            widget.submission!.files![i]['attatchment_number'] = i;
            _videoFiles.add(widget.submission!.files![i]);

            listItems.add(DropdownMenuItem<int>(
              value: i,
              child: Text('Attachment ${i + 1} (Uploaded)'),
            ));
          });
        }
        isLoading = false;
      }
    });
  }

  void _initializeVideoPlayer() {
    isLoading = true;

    if (widget.submission != null &&
        widget.submission!.files != null &&
        widget.submission!.files!.isNotEmpty) {
      String? videoUrl = widget.submission!.files![0]['url'];
      if (videoUrl != null && videoUrl.isNotEmpty) {
        _videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
          ..initialize().then((_) {
            setState(() {
              _hasVideo = true;
            });
          }).catchError((error) {
            print('Error initializing video player: $error');
            setState(() {
              _hasVideo = false;
            });
          });
      }
    }

    isLoading = false;
  }

  Future<void> _pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      File videoFile = File(video.path);
      if (await _validateVideo(videoFile)) {
        setState(() {
          _videoFiles.add({
            'attatchment_number': _selectedVideoIndex,
            'video': videoFile,
          });
          setListItems();
          _initializeVideoPlayerWithFile(videoFile);
        });
      }
    }
  }

  Future<void> _recordVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.camera);

    if (video != null) {
      File videoFile = File(video.path);
      if (await _validateVideo(videoFile)) {
        setState(() {
          _videoFiles.add({
            'attatchment_number': _selectedVideoIndex,
            'video': videoFile,
          });
          setListItems();
          _initializeVideoPlayerWithFile(videoFile);
        });
      }
    }
  }

  Future<bool> _validateVideo(File videoFile) async {
    // Get video duration
    final VideoPlayerController tempController =
        VideoPlayerController.file(videoFile);
    await tempController.initialize();
    final duration = tempController.value.duration;
    await tempController.dispose();

    if (duration.inMinutes > widget.assignment.maxVideoLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Video is longer than the maximum allowed length of ${widget.assignment.maxVideoLength} minutes.')),
      );
      return false;
    }

    if (_videoFiles.length >= widget.assignment.maxVideos) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'You have reached the maximum number of videos allowed (${widget.assignment.maxVideos}).')),
      );
      return false;
    }

    return true;
  }

  void _initializeVideoPlayerWithFile(File file) {
    isLoading = true;

    _videoController = VideoPlayerController.file(file)
      ..initialize().then((_) {
        setState(() {
          _hasVideo = true;
        });
      }).catchError((error) {
        print('Error initializing video player: $error');
        setState(() {
          _hasVideo = false;
        });
      });

    isLoading = false;
  }

  void _intitializeVideoPlayerWithUrl(String url) {
    isLoading = true;

    _videoController = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        setState(() {
          _hasVideo = true;
        });
      }).catchError((error) {
        print('Error initializing video player with url: $error');
        setState(() {
          _hasVideo = false;
        });
      });
    isLoading = false;
  }

  Future<void> _uploadSubmission() async {
    isLoading = true;

    if (_videoFiles.length < widget.assignment.minVideos) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please upload at least ${widget.assignment.minVideos} videos.',
          ),
        ),
      );
      return;
    }

    SubmissionProvider submissionProvider = context.read<SubmissionProvider>();

    List<Map<String, String>> uploadedFilesDetails = [];

    for (var videoFile in _videoFiles) {
      // Compress each video
      final compressedVideo = await VideoCompress.compressVideo(
        videoFile['video'].path,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false,
      );

      if (compressedVideo != null && compressedVideo.file != null) {
        final String fileName = compressedVideo.file!.path.split('/').last;
        final String? contentType = lookupMimeType(compressedVideo.file!.path);

        if (contentType == null) {
          print('Failed to determine content type.');
          continue;
        }

        // Fetch pre-signed URL for this video
        final presignedUrl = await submissionProvider.fetchPresignedUrl(
          widget.assignment.moduleId.toString(),
          widget.assignment.assignmentId.toString(),
          fileName,
          contentType,
        );

        if (presignedUrl != null) {
          bool uploadSuccess = await submissionProvider.uploadFileToS3(
              presignedUrl, File(compressedVideo.file!.path), contentType);

          if (uploadSuccess) {
            uploadedFilesDetails.add({
              'file_name': fileName,
              'file_url': presignedUrl.split('?')[0],
              'content_type': contentType,
            });
          }
        }
      }
    }

    // Once all videos are uploaded, finalize submission by sending details to backend
    await submissionProvider.uploadSubmission(
      widget.assignment,
      uploadedFilesDetails,
    );

    if (mounted) {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Assignment has been submitted successfully!')),
      );
      Navigator.pop(context);
    }
  }

  String getAssignmentStatus() {
    if (widget.submission != null) {
      if (widget.submission!.submissionGrade != null) {
        return 'Graded';
      } else if (widget.submission!.submissionGrade == null) {
        return 'Submitted';
      }
    } else if (DateTime.now().isAfter(widget.assignment.openDate)) {
      'Upcoming';
    } else if (widget.assignment.dueDate.isAfter(DateTime.now())) {
      return 'Passed due';
    }
    return 'In Progress';
  }

  bool showBottomButton() {
    if (widget.submission != null) {
      if (widget.submission!.submissionGrade != null) {
        return false;
      } else if (widget.submission!.submissionGrade == null) {
        return false;
      }
    } else if (DateTime.now().isAfter(widget.assignment.openDate)) {
      false;
    } else if (widget.assignment.dueDate.isAfter(DateTime.now())) {
      return false;
    }
    return true;
  }

  void selectNewVideo(int value) {
    setState(() {
      _hasVideo = false;
      _selectedVideoIndex = value;

      if (_videoFiles.isNotEmpty) {
        for (var i = 0; i < _videoFiles.length; i++) {
          if (_videoFiles[i]['attatchment_number'] == value) {
            _hasVideo = true;
            if (_videoFiles[i]['video'] == null) {
              _intitializeVideoPlayerWithUrl(_videoFiles[i]['url']);
            }
          }
        }
      }
    });
  }

  void _showVideoOptions() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickVideo();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.videocam),
                  title: const Text('Record a video'),
                  onTap: () {
                    Navigator.pop(context);
                    _recordVideo();
                  },
                ),
              ],
            ),
          );
        });
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
        body: Stack(
          children: [
            Column(
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
                            Text(
                              widget.assignment.assignmentTitle,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              widget.assignment.assignmentDescription,
                              style: const TextStyle(fontSize: 19),
                              softWrap: true,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Divider(color: Colors.grey),
                            ),
                            if (widget.submission != null &&
                                widget.submission!.submissionGrade != null)
                              Text(
                                'Assignment grade: ${widget.submission!.submissionGrade}',
                                style: const TextStyle(fontSize: 19),
                              ),
                            Text(
                              'Assignment status: ${getAssignmentStatus()}',
                              style: const TextStyle(fontSize: 19),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Divider(color: Colors.grey),
                            ),
                            Row(
                              children: [
                                const Card.outlined(
                                  color: Color(0xFFF0F3F4),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.event_available),
                                  ),
                                ),
                                Text(
                                  'Open date: ${DateFormat('dd-MM-yyyy').format(widget.assignment.openDate)}',
                                  style: const TextStyle(fontSize: 19),
                                  softWrap: true,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Card.outlined(
                                  color: Color(0xFFF0F3F4),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.event_busy),
                                  ),
                                ),
                                Text(
                                  'Close date: ${DateFormat('dd-MM-yyyy').format(widget.assignment.dueDate)}',
                                  style: const TextStyle(fontSize: 19),
                                  softWrap: true,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Card.outlined(
                                  color: Color(0xFFF0F3F4),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                                Text(
                                  'Minimum videos: ${widget.assignment.minVideos}',
                                  style: const TextStyle(fontSize: 19),
                                  softWrap: true,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Card.outlined(
                                  color: Color(0xFFF0F3F4),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.warning_amber_rounded),
                                  ),
                                ),
                                Text(
                                  'Maximum videos: ${widget.assignment.maxVideos}',
                                  style: const TextStyle(fontSize: 19),
                                  softWrap: true,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Card.outlined(
                                  color: Color(0xFFF0F3F4),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.timer),
                                  ),
                                ),
                                Text(
                                  'Maximum duration: ${widget.assignment.maxVideoLength} min',
                                  style: const TextStyle(fontSize: 19),
                                  softWrap: true,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Card.outlined(
                                  color: Color(0xFFF0F3F4),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.grade),
                                  ),
                                ),
                                Text(
                                  'Maximum grade: ${widget.assignment.maxGrade}',
                                  style: const TextStyle(fontSize: 19),
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
                                    GestureDetector(
                                      onTap:
                                          _hasVideo ? null : _showVideoOptions,
                                      child: Container(
                                        width: constraints.maxWidth,
                                        height: constraints.maxWidth - 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                              color: Colors.grey, width: 2.0),
                                        ),
                                        child: _hasVideo &&
                                                _videoController
                                                    .value.isInitialized
                                            ? AspectRatio(
                                                aspectRatio: _videoController
                                                    .value.aspectRatio,
                                                child: VideoPlayer(
                                                    _videoController),
                                              )
                                            : const Center(
                                                child: Text(
                                                  'Tap to upload or record video',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                      ),
                                    ),
                                    if (_hasVideo)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (widget.submission == null)
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  for (var i = 0;
                                                      i < _videoFiles.length;
                                                      i++) {
                                                    if (_videoFiles[i][
                                                            'attatchment_number'] ==
                                                        _selectedVideoIndex) {
                                                      _videoFiles[i] = {};
                                                      selectNewVideo(
                                                          _selectedVideoIndex);
                                                      setListItems();
                                                    }
                                                  }
                                                });
                                              },
                                              child: const Card.outlined(
                                                color: Color(0xFFF0F3F4),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(Icons
                                                      .restart_alt_outlined),
                                                ),
                                              ),
                                            ),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                _videoController.value.isPlaying
                                                    ? _videoController.pause()
                                                    : _videoController.play();
                                              });
                                            },
                                            child: Card.outlined(
                                              color: const Color(0xFFF0F3F4),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  _videoController
                                                          .value.isPlaying
                                                      ? Icons.pause
                                                      : Icons.play_arrow,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ],
                                );
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Divider(color: Colors.grey),
                            ),
                            // Video selector
                            DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: _selectedVideoIndex,
                                isExpanded: true,
                                items: listItems,
                                onChanged: (int? newValue) {
                                  if (newValue != null) {
                                    selectNewVideo(newValue);
                                  }
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Divider(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (showBottomButton())
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: _uploadSubmission,
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
            if (isLoading) // Show loader if isLoading is true
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
