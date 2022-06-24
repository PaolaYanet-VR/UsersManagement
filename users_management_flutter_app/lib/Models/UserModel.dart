List<UserModel> usersList = [];
UserModel actualUser = UserModel();
UserModel selectedUser = UserModel();

class UserModel {
  String? id;
  String? name;
  String? lastname;
  String? email;
  String? password;
  bool? admin;

  UserModel({
     this.id = "",
     this.name = "",
     this.lastname = "",
     this.email = "",
     this.password = "",
     this.admin = false
  });
 
}