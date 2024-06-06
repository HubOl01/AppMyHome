import '../../pages/chatsPages/Chats/api/firebase.dart';

void addUser(
  String id,
  String userEmail,
  String userSurname,
  String userName,
  String userMiddle_name,
  String code,
  String status,
  String personalCheck,
  String numberPhone,
) async {
  baseAPI.addUsers(
      id: id,
      userEmail: userEmail,
      userSurname: userSurname,
      userName: userName,
      userMiddle_name: userMiddle_name,
      code: code,
      status: status,
      personalCheck: personalCheck,
      numberPhone: numberPhone,);

      // myUserEmail = UserEmail;
      // myUserSurname = UserSurname;
      // myUserName = UserName;
      // myUserMiddle_name = UserMiddle_name;
      // myCode = Code;
      // myStatus = Status;
      // myPersonalCheck = PersonalCheck;
      // myNumberPhone = NumberPhone;
      // myUrlAvatar = '0';
}
