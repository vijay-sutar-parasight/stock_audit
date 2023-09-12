class AdminUsersModel{
  final int? adminUserId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? mobileNo;

  AdminUsersModel({this.adminUserId, required this.firstName, required this.lastName, this.email, this.password, this.mobileNo});

  AdminUsersModel.fromMap(Map<String, dynamic> res):
        adminUserId = res['admin_user_id'],
        firstName = res['first_name'],
        lastName = res['last_name'],
        email = res['email'],
        password = res['password'],
        mobileNo = res['mobile_no'];



Map<String, Object?> toMap(){
  return{
    'admin_user_id' : adminUserId,
    'first_name' : firstName,
    'last_name' : lastName,
    'email' : email,
    'password' : password,
    'mobile_no' : mobileNo


  };
}
}