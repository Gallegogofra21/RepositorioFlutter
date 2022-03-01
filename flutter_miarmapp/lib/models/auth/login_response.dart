class LoginResponse {
  LoginResponse({
    required this.email,
    required this.nick,
    required this.avatar,
    required this.perfil,
    required this.token,
    required this.posts,
  });
  late final String email;
  late final String nick;
  late final String avatar;
  late final String perfil;
  late final String token;
  late final List<dynamic> posts;
  
  LoginResponse.fromJson(Map<String, dynamic> json){
    email = json['email'];
    nick = json['nick'];
    avatar = json['avatar'];
    perfil = json['perfil'];
    token = json['token'];
    posts = List.castFrom<dynamic, dynamic>(json['posts']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['nick'] = nick;
    _data['avatar'] = avatar;
    _data['perfil'] = perfil;
    _data['token'] = token;
    _data['posts'] = posts;
    return _data;
  }
}