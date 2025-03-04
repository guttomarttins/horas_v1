class Hour{
  String id;
  String data;
  int minutos;
  String? descricao;

  Hour(this.id, this.data, this.minutos);

    Hour.fromMap(Map<String, dynamic> map) :
      id = map['id'],
      data = map['data'],
      minutos = map['minutos'],
      descricao = map['descricao'];

    Map<String, dynamic> toMap() {
      return {
        'id': id,
        'data': data,
        'minutos': minutos,
        'descricao': descricao
      };
    }
}