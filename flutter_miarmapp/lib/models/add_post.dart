class AddPost {
  AddPost({
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
  
  AddPost.fromJson(Map<String, dynamic> json){
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