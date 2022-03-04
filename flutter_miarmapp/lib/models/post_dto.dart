class PostDto {
  String? titulo;
  String? texto;
  bool? tipo;

  PostDto(
      {this.titulo,
      this.texto,
      this.tipo,
      });

  PostDto.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    texto = json['texto'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['titulo'] = titulo;
    data['texto'] = texto;
    data['tipo'] = tipo;
    return data;
  }
}