class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.telefono,
    required this.avatar,
    required this.perfil,
    required this.fecha,
    required this.posts,
    required this.listaPeticiones,
    required this.followers,
  });
  late final String id;
  late final String username;
  late final String email;
  late final dynamic telefono;
  late final String avatar;
  late final String perfil;
  late final String fecha;
  late final List<Posts> posts;
  late final List<dynamic> listaPeticiones;
  late final List<dynamic> followers;
  
  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    username = json['username'];
    email = json['email'];
    telefono = json['telefono'];
    avatar = json['avatar'];
    perfil = json['perfil'];
    fecha = json['fecha'];
    posts = List.from(json['posts']).map((e)=>Posts.fromJson(e)).toList();
    listaPeticiones = List.castFrom<dynamic, dynamic>(json['listaPeticiones']);
    followers = List.castFrom<dynamic, dynamic>(json['followers']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['email'] = email;
    _data['telefono'] = telefono;
    _data['avatar'] = avatar;
    _data['perfil'] = perfil;
    _data['fecha'] = fecha;
    _data['posts'] = posts.map((e)=>e.toJson()).toList();
    _data['listaPeticiones'] = listaPeticiones;
    _data['followers'] = followers;
    return _data;
  }
}

class Posts {
  Posts({
    required this.id,
    required this.titulo,
    required this.contenido,
    required this.contenidoOriginal,
    required this.contenidoMultimedia,
    required this.tipoPublicacion,
    required this.user,
    required this.userAvatar,
  });
  late final int id;
  late final String titulo;
  late final String contenido;
  late final String contenidoOriginal;
  late final String contenidoMultimedia;
  late final String tipoPublicacion;
  late final String user;
  late final String userAvatar;
  
  Posts.fromJson(Map<String, dynamic> json){
    id = json['id'];
    titulo = json['titulo'];
    contenido = json['contenido'];
    contenidoOriginal = json['contenidoOriginal'];
    contenidoMultimedia = json['contenidoMultimedia'];
    tipoPublicacion = json['tipoPublicacion'];
    user = json['user'];
    userAvatar = json['userAvatar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['titulo'] = titulo;
    _data['contenido'] = contenido;
    _data['contenidoOriginal'] = contenidoOriginal;
    _data['contenidoMultimedia'] = contenidoMultimedia;
    _data['tipoPublicacion'] = tipoPublicacion;
    _data['user'] = user;
    _data['userAvatar'] = userAvatar;
    return _data;
  }
}