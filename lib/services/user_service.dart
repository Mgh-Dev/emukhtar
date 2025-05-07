class UserService {
  Future<void> submitApprovalRequest(String phone, String name) async {
    // Dummy logic to simulate Firestore write
    await Future.delayed(Duration(seconds: 1));
    print("Request submitted for $phone by $name");
  }
}
