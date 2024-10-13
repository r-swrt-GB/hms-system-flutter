import 'package:dio/dio.dart';
import 'package:hms_system_application/framework/services/http_service.dart';
import 'package:hms_system_application/models/user.dart';

var postOptions = Options(headers: {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
});

class ApiService extends HttpService {
  Future<Response> performLogin(String email, String password) async {
    return await httpPost(
      '/api/v1/login',
      data: {
        'email': email,
        'password': password,
      },
      options: postOptions,
    );
  }

  Future<Response> performRegistration(
      String firstName, String lastName, String email, String password) async {
    return await httpPost(
      '/api_v1/register',
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'password_confirmation': password,
      },
      options: postOptions,
    );
  }

  Future<Response> createSubmission(
      int moduleId, int assignmentId, List files) async {
    return await httpPost(
      '/api_v1/modules/$moduleId/assignments/$assignmentId/submissions/create',
      data: {
        'submission_date': DateTime.now(),
        'files': files,
      },
      options: postOptions,
    );
  }

  Future<Response> refreshUser() async {
    Response respone = await httpGet('/api/v1/profile');
    return respone;
  }

  Future<Response> refreshModules() async {
    Response respone = await httpGet('/api/v1/modules');
    return respone;
  }

  Future<Response> refreshAssigments(int moduleId) async {
    Response respone = await httpGet('/api/v1/modules/$moduleId/assignments');
    return respone;
  }

  Future<Response> refreshNotifications(int moduleId) async {
    Response respone = await httpGet('/api/v1/modules/$moduleId/notifications');
    return respone;
  }

  Future<Response> markNotificationAsRead(
      int moduleId, int notificationId) async {
    return await httpPatch(
      '/api/v1/modules/${moduleId}/notifications/${notificationId}/mark-as-read',
      options: postOptions,
    );
  }

  Future<Response> deleteUser(
      int userId, String email, String userToken) async {
    return await httpDelete(
      '/auth/user/$userId/delete-account',
      data: {
        'email': email,
      },
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Accept': 'application/json',
      }),
    );
  }

  Future<Response> updateuser(User user) async {
    return await httpPatch(
      '/api/v1/edit/user/${user.userId}',
      data: {
        'first_name': user.firstName,
        'last_name': user.lastName,
        'email': user.email,
      },
      options: postOptions,
    );
  }

  Future<Response> uploadFiles(
      int moduleId, int assignmentId, List files) async {
    return await httpPatch(
      '/api/v1/',
      data: {},
      options: postOptions,
    );
  }

  Future<Response> getModules() async {
    return await httpGet(
      '/api_v1/modules/',
      options: postOptions,
    );
  }

  Future<Response> getModuleAssignments(int moduleId) async {
    return await httpGet(
      '/api_v1/modules/$moduleId/assignments/',
      options: postOptions,
    );
  }

  Future<Response> getModuleSubmissions(int moduleId, int assignmentId) async {
    return await httpGet(
      '/api_v1/modules/$moduleId/assignments/$assignmentId/submissions/',
      options: postOptions,
    );
  }

  Future<Response> getSubmissionComments(
      int moduleId, int assignmentId, int submissionId) async {
    return await httpGet(
      '/api_v1/modules/$moduleId/assignments/$assignmentId/submissions/$submissionId/comments/',
      options: postOptions,
    );
  }

  Future<Response> getUserNotifications() async {
    return await httpGet(
      '/api_v1/notifications/',
      options: postOptions,
    );
  }

  Future<Response> getAssignment() async {
    return await httpGet(
      '/api_v1/assignments/',
      options: postOptions,
    );
  }
}

// Post Request example

  /* Future<Response> performLogin(String email, String password) async {
    return await httpPost(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
      options: postOptions,
    );
  } */

// Delete Request example

  /* Future<Response> deleteUser(
      int userId, String email, String userToken) async {
    return await httpDelete(
      '/auth/user/$userId/delete-account',
      data: {
        'email': email,
      },
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Accept': 'application/json',
      }),
    );
  } */

// Get Request Example

  /* Future<Response> getOrderDetail(int orderId) async {
    return await httpGet('/orders/$orderId');
  }  */

// Patch Request Example

/*  Future<dynamic> updateOrder(int orderId, Map<String, dynamic> data) async {
    try {
      print("Order id: $orderId");
      print("Order data: $data");
      Response response = await httpPatch('/orders/$orderId', data: data);
      print("Response data:${response.data}");
      return response;
    } catch (e, stackTrace) {
      print("Error occurred: $e");
      print("Stack trace: $stackTrace");
      // Handle the error here if necessary
      return null; // or throw the error again
    }
  }  */






  /*
    Future<Response> performRegistration(String email, String password) async {
    return await httpPost(
      '/auth/register',
      data: {
        'email': email,
        'password': password,
      },
      options: postOptions,
    );
  }

  Future<Response> refreshUser() async {
    return await httpGet('/user');
  }

  Future<Response> deleteUser(
      int userId, String email, String userToken) async {
    return await httpDelete(
      '/auth/user/$userId/delete-account',
      data: {
        'email': email,
      },
      options: Options(headers: {
        'Authorization': 'Bearer $userToken',
        'Accept': 'application/json',
      }),
    );*/
