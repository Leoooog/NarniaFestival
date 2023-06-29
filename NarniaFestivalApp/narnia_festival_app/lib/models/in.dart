import 'package:equatable/equatable.dart';

class BuonoPasto extends Equatable {
  final String idBuono;
  final bool valido;
  final int tipo;
  final String utente;

  const BuonoPasto({
    required this.idBuono,
    required this.valido,
    required this.tipo,
    required this.utente,
  });

  factory BuonoPasto.initial() {
    return const BuonoPasto(idBuono: '', valido: false, tipo: 0, utente: '');
  }

  BuonoPasto copyWith({
    String? idBuono,
    bool? valido,
    int? tipo,
    String? utente,
  }) =>
      BuonoPasto(
        idBuono: idBuono ?? this.idBuono,
        valido: valido ?? this.valido,
        tipo: tipo ?? this.tipo,
        utente: utente ?? this.utente,
      );

  factory BuonoPasto.fromJson(Map<String, dynamic> json) => BuonoPasto(
        idBuono: json["IdBuono"],
        valido: json["Valido"] == "1",
        tipo: int.parse(json["Tipo"]),
        utente: json["Utente"],
      );

  Map<String, dynamic> toJson() => {
        "IdBuono": idBuono,
        "Valido": valido,
        "Tipo": tipo,
        "Utente": utente,
      };

  @override
  List<Object?> get props => [idBuono, valido, tipo, utente];

  @override
  String toString() {
    return 'BuonoPasto{idBuono: $idBuono, valido: $valido, tipo: $tipo, utente: $utente}';
  }
}

class Ristorante extends Equatable {
  final String idRistorante;
  final String nome;
  final String descrizione;
  final String indirizzo;
  final double latitudine;
  final double longitudine;
  final String menu;
  final String proprietario;

  const Ristorante({
    required this.idRistorante,
    required this.nome,
    required this.descrizione,
    required this.indirizzo,
    required this.latitudine,
    required this.longitudine,
    required this.menu,
    required this.proprietario,
  });

  factory Ristorante.initial() {
    return const Ristorante(
        idRistorante: '',
        nome: '',
        descrizione: '',
        indirizzo: '',
        latitudine: 0,
        longitudine: 0,
        menu: '',
        proprietario: '');
  }

  Ristorante copyWith({
    String? idRistorante,
    String? nome,
    String? descrizione,
    String? indirizzo,
    double? latitudine,
    double? longitudine,
    String? menu,
    String? proprietario,
  }) =>
      Ristorante(
        idRistorante: idRistorante ?? this.idRistorante,
        nome: nome ?? this.nome,
        descrizione: descrizione ?? this.descrizione,
        indirizzo: indirizzo ?? this.indirizzo,
        latitudine: latitudine ?? this.latitudine,
        longitudine: longitudine ?? this.longitudine,
        menu: menu ?? this.menu,
        proprietario: proprietario ?? this.proprietario,
      );

  factory Ristorante.fromJson(Map<String, dynamic> json) => Ristorante(
        idRistorante: json["IdRistorante"],
        nome: json["Nome"],
        descrizione: json["Descrizione"],
        indirizzo: json["Indirizzo"],
        latitudine: double.parse(json["Latitudine"]),
        longitudine: double.parse(json["Longitudine"]),
        menu: json["Menu"],
        proprietario: json["Proprietario"],
      );

  Map<String, dynamic> toJson() => {
        "IdRistorante": idRistorante,
        "Nome": nome,
        "Descrizione": descrizione,
        "Indirizzo": indirizzo,
        "Latitudine": latitudine,
        "Longitudine": longitudine,
        "Menu": menu,
        "Proprietario": proprietario,
      };

  @override
  List<Object?> get props => [
        idRistorante,
        nome,
        descrizione,
        indirizzo,
        latitudine,
        longitudine,
        menu,
        proprietario
      ];

  @override
  String toString() {
    return 'Ristorante{idRistorante: $idRistorante, nome: $nome, descrizione: $descrizione, indirizzo: $indirizzo, latitudine: $latitudine, longitudine: $longitudine, menu: $menu, proprietario: $proprietario}';
  }
}

class Utente extends Equatable {
  final String idUtente;
  final String nome;
  final String cognome;
  final String username;
  final String email;
  final bool verificato;
  final int ruolo;
  final DateTime dataCreazione;

  const Utente({
    required this.idUtente,
    required this.nome,
    required this.cognome,
    required this.username,
    required this.email,
    required this.verificato,
    required this.ruolo,
    required this.dataCreazione,
  });

  factory Utente.initial() {
    return Utente(
        idUtente: '',
        nome: '',
        cognome: '',
        username: '',
        email: '',
        verificato: false,
        ruolo: 0,
        dataCreazione: DateTime(0));
  }

  Utente copyWith({
    String? idUtente,
    String? nome,
    String? cognome,
    String? username,
    String? email,
    bool? verificato,
    int? ruolo,
    DateTime? dataCreazione,
  }) =>
      Utente(
        idUtente: idUtente ?? this.idUtente,
        nome: nome ?? this.nome,
        cognome: cognome ?? this.cognome,
        username: username ?? this.username,
        email: email ?? this.email,
        verificato: verificato ?? this.verificato,
        ruolo: ruolo ?? this.ruolo,
        dataCreazione: dataCreazione ?? this.dataCreazione,
      );

  factory Utente.fromJson(Map<String, dynamic> json) => Utente(
        idUtente: json["IdUtente"],
        nome: json["Nome"],
        cognome: json["Cognome"],
        username: json["Username"],
        email: json["Email"],
        verificato: json["Verificato"] == "1",
        ruolo: int.parse(json["Ruolo"]),
        dataCreazione: DateTime.parse(json["DataCreazione"]),
      );

  Map<String, dynamic> toJson() => {
        "IdUtente": idUtente,
        "Nome": nome,
        "Cognome": cognome,
        "Username": username,
        "Email": email,
        "Verificato": verificato,
        "Ruolo": ruolo,
        "DataCreazione": dataCreazione.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        idUtente,
        nome,
        cognome,
        username,
        email,
        verificato,
        ruolo,
        dataCreazione
      ];

  @override
  String toString() {
    return 'Utente{idUtente: $idUtente, nome: $nome, cognome: $cognome, username: $username, email: $email, verificato: $verificato, ruolo: $ruolo, dataCreazione: $dataCreazione}';
  }
}

class Prenotazione extends Equatable {
  final String idPrenotazione;
  final DateTime dataPrenotazione;
  final String utente;
  final String evento;
  final int posti;
  final bool validata;

  const Prenotazione({
    required this.idPrenotazione,
    required this.dataPrenotazione,
    required this.utente,
    required this.evento,
    required this.posti,
    required this.validata,
  });

  factory Prenotazione.initial() {
    return Prenotazione(
        idPrenotazione: '',
        dataPrenotazione: DateTime(0),
        utente: '',
        evento: '',
        posti: 0,
        validata: false);
  }

  Prenotazione copyWith({
    String? idPrenotazione,
    DateTime? dataPrenotazione,
    String? utente,
    String? evento,
    int? posti,
    bool? validata,
  }) =>
      Prenotazione(
        idPrenotazione: idPrenotazione ?? this.idPrenotazione,
        dataPrenotazione: dataPrenotazione ?? this.dataPrenotazione,
        utente: utente ?? this.utente,
        evento: evento ?? this.evento,
        posti: posti ?? this.posti,
        validata: validata ?? this.validata,
      );

  factory Prenotazione.fromJson(Map<String, dynamic> json) => Prenotazione(
        idPrenotazione: json["IdPrenotazione"],
        dataPrenotazione: DateTime.parse(json["DataPrenotazione"]),
        utente: json["Utente"],
        evento: json["Evento"],
        posti: int.parse(json["Posti"]),
        validata: json["Validata"] == "1",
      );

  Map<String, dynamic> toJson() => {
        "IdPrenotazione": idPrenotazione,
        "DataPrenotazione": dataPrenotazione.toIso8601String(),
        "Utente": utente,
        "Evento": evento,
        "Posti": posti,
        "Validata": validata,
      };

  @override
  List<Object?> get props =>
      [idPrenotazione, dataPrenotazione, utente, evento, posti, validata];

  @override
  String toString() {
    return 'Prenotazione{idPrenotazione: $idPrenotazione, dataPrenotazione: $dataPrenotazione, utente: $utente, evento: $evento, posti: $posti, validata: $validata}';
  }
}

class Evento extends Equatable {
  final String idEvento;
  final String titolo;
  final String sottotitolo;
  final String descrizione;
  final String durata;
  final DateTime data;
  final String luogo;
  final double latitudine;
  final double longitudine;
  final int tipo;
  final double prezzo;
  final bool conPrenotazione;
  final int? capienza;
  final int? postiOccupati;

  const Evento({
    required this.idEvento,
    required this.titolo,
    required this.sottotitolo,
    required this.descrizione,
    required this.durata,
    required this.data,
    required this.luogo,
    required this.latitudine,
    required this.longitudine,
    required this.tipo,
    required this.prezzo,
    required this.conPrenotazione,
    required this.capienza,
    required this.postiOccupati,
  });

  factory Evento.initial() {
    return Evento(
        idEvento: '',
        titolo: '',
        sottotitolo: '',
        descrizione: '',
        durata: '',
        data: DateTime(0),
        luogo: '',
        latitudine: 0,
        longitudine: 0,
        tipo: 0,
        prezzo: 0,
        conPrenotazione: false,
        capienza: 0,
        postiOccupati: 0);
  }

  Evento copyWith({
    String? idEvento,
    String? titolo,
    String? sottotitolo,
    String? descrizione,
    String? durata,
    DateTime? data,
    String? luogo,
    double? latitudine,
    double? longitudine,
    int? tipo,
    double? prezzo,
    bool? conPrenotazione,
    int? capienza,
    int? postiOccupati,
  }) =>
      Evento(
        idEvento: idEvento ?? this.idEvento,
        titolo: titolo ?? this.titolo,
        sottotitolo: sottotitolo ?? this.sottotitolo,
        descrizione: descrizione ?? this.descrizione,
        durata: durata ?? this.durata,
        data: data ?? this.data,
        luogo: luogo ?? this.luogo,
        latitudine: latitudine ?? this.latitudine,
        longitudine: longitudine ?? this.longitudine,
        tipo: tipo ?? this.tipo,
        prezzo: prezzo ?? this.prezzo,
        conPrenotazione: conPrenotazione ?? this.conPrenotazione,
        capienza: capienza ?? this.capienza,
        postiOccupati: postiOccupati ?? this.postiOccupati,
      );

  factory Evento.fromJson(Map<String, dynamic> json) => Evento(
        idEvento: json["IdEvento"],
        titolo: json["Titolo"],
        sottotitolo: json["Sottotitolo"],
        descrizione: json["Descrizione"],
        durata: json["Durata"],
        data: DateTime.parse(json["Data"]),
        luogo: json["Luogo"],
        latitudine: double.parse(json["Latitudine"]),
        longitudine: double.parse(json["Longitudine"]),
        tipo: int.parse(json["Tipo"]),
        prezzo: double.parse(json["Prezzo"]),
        conPrenotazione: json["ConPrenotazione"] == "1",
        capienza: int.tryParse(json["Capienza"]),
        postiOccupati: int.tryParse(json["PostiOccupati"]),
      );

  Map<String, dynamic> toJson() => {
        "IdEvento": idEvento,
        "Titolo": titolo,
        "Sottotitolo": sottotitolo,
        "Descrizione": descrizione,
        "Durata": durata,
        "Data": data.toIso8601String(),
        "Luogo": luogo,
        "Latitudine": latitudine,
        "Longitudine": longitudine,
        "Tipo": tipo,
        "Prezzo": prezzo,
        "ConPrenotazione": conPrenotazione,
        "Capienza": capienza,
        "PostiOccupati": postiOccupati,
      };

  @override
  List<Object?> get props => [
        idEvento,
        titolo,
        sottotitolo,
        descrizione,
        durata,
        data,
        luogo,
        latitudine,
        longitudine,
        tipo,
        prezzo,
        conPrenotazione,
        capienza,
        postiOccupati
      ];

  @override
  String toString() {
    return 'Evento{idEvento: $idEvento, titolo: $titolo, sottotitolo: $sottotitolo, descrizione: $descrizione, durata: $durata, data: $data, luogo: $luogo, latitudine: $latitudine, longitudine: $longitudine, tipo: $tipo, prezzo: $prezzo, conPrenotazione: $conPrenotazione, capienza: $capienza, postiOccupati: $postiOccupati}';
  }
}
