List<UserModel> usersList = [];
UserModel actualUser = UserModel();
UserModel selectedUser = UserModel();

class UserModel {
  String? id;
  String? name;
  String? lastname;
  String? email;
  String? password;

  UserModel({
     this.id = "",
     this.name = "",
     this.lastname = "",
     this.email = "",
     this.password = ""
  });
 
}