CREATE DATABASE IF NOT EXISTS narnia_db CHARACTER SET latin1 COLLATE latin1_swedish_ci;


USE narnia_db;
DELIMITER //

CREATE FUNCTION BIN_TO_UUID(uuid_val BINARY(16))
  RETURNS CHAR(36)
  BEGIN
    DECLARE uuid_str CHAR(36);

    SET @uuid_str = LOWER(HEX(uuid_val));

    SET @uuid_str = INSERT(@uuid_str, 9, 0, '-');
    SET @uuid_str = INSERT(@uuid_str, 14, 0, '-');
    SET @uuid_str = INSERT(@uuid_str, 19, 0, '-');
    SET @uuid_str = INSERT(@uuid_str, 24, 0, '-');

    RETURN @uuid_str;
  END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION UUID_TO_BIN(uuid_val CHAR(36))
  RETURNS BINARY(16)
  BEGIN
    DECLARE uuid_bin BINARY(16);

    SET uuid_bin = UNHEX(REPLACE(uuid_val, '-', ''));
    RETURN uuid_bin;
  END //

DELIMITER ;


CREATE TABLE IF NOT EXISTS
  Ruoli (
    Id INT NOT NULL,
    Descrizione VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (Id)
  ) ENGINE = InnoDB;


DELETE FROM Ruoli;


INSERT INTO
  Ruoli
VALUES
  (1, 'admin'),
  (2, 'iscritto'),
  (3, 'ospite'),
  (4, 'ristorante');


CREATE TABLE IF NOT EXISTS
  Utenti (
    IdUtente BINARY(16) NOT NULL DEFAULT UNHEX(
      REPLACE
        (UUID(), '-', '')
    ),
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(64) NOT NULL,
    Email VARCHAR(320) NOT NULL UNIQUE,
    CodiceVerifica INT(6) NOT NULL,
    Verificato TINYINT NOT NULL DEFAULT FALSE,
    Ruolo INT NOT NULL DEFAULT 3,
    DataCreazione DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    DataVerifica DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (IdUtente),
    FOREIGN KEY (Ruolo) REFERENCES Ruoli (Id)
  ) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS
  TipiEventi (
    Id INT NOT NULL,
    Descrizione VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (Id)
  ) ENGINE = InnoDB;


DELETE FROM TipiEventi;


INSERT INTO
  TipiEventi
VALUES
  (1, 'Concerto'),
  (2, 'Lezione'),
  (3, 'Mostra');


CREATE TABLE IF NOT EXISTS
  Eventi (
    IdEvento BINARY(16) NOT NULL DEFAULT UNHEX(
      REPLACE
        (UUID(), '-', '')
    ),
    Titolo VARCHAR(50) NOT NULL,
    Sottotitolo VARCHAR(100) NOT NULL,
    Descrizione TEXT NOT NULL,
    Durata TIME NOT NULL,
    Data DATETIME NOT NULL,
    Luogo VARCHAR(500) NOT NULL,
    Posizione POINT,
    Tipo INT NOT NULL,
    Prezzo FLOAT(5, 2) NOT NULL DEFAULT 0,
    ConPrenotazione TINYINT NOT NULL DEFAULT FALSE,
    Capienza INT,
    PostiOccupati INT,
    PRIMARY KEY (IdEvento),
    FOREIGN KEY (Tipo) REFERENCES TipiEventi (Id)
  ) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS
  Ristoranti (
    IdRistorante BINARY(16) NOT NULL DEFAULT UNHEX(
      REPLACE
        (UUID(), '-', '')
    ),
    Nome VARCHAR(50) NOT NULL,
    Descrizione TEXT NOT NULL,
    Indirizzo VARCHAR(100) NOT NULL,
    Posizione POINT,
    Menu BLOB,
    Proprietario BINARY(16) NOT NULL,
    PRIMARY KEY (IdRistorante),
    FOREIGN KEY (Proprietario) REFERENCES Utenti (IdUtente)
  ) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS
  TipiBuono (
    Id INT NOT NULL,
    Valore FLOAT(5, 2) NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Descrizione TEXT NOT NULL,
    PRIMARY KEY (Id)
  ) ENGINE = InnoDB;


DELETE FROM TipiBuono;


INSERT INTO
  TipiBuono
VALUES
  (
    1,
    7,
    'Basic',
    '1 primo o secondo, acqua a volonta, 1 caffe'
  ),
  (
    2,
    10,
    'Premium',
    '1 primo o secondo, acqua a volonta, 1 caffe, 1 dolce'
  ),
  (
    3,
    15,
    'Executive',
    '1 primo, 1 secondo, acqua a volonta, 1 caffe, 1 dolce'
  );


CREATE TABLE IF NOT EXISTS
  BuoniPasto (
    IdBuono BINARY(16) NOT NULL DEFAULT UNHEX(
      REPLACE
        (UUID(), '-', '')
    ),
    Valido TINYINT NOT NULL DEFAULT TRUE,
    Tipo INT NOT NULL,
    Utente BINARY(16) NOT NULL,
    Ristorante BINARY(16) DEFAULT NULL,
    PRIMARY KEY (IdBuono),
    FOREIGN KEY (Tipo) REFERENCES TipiBuono (Id),
    FOREIGN KEY (Utente) REFERENCES Utenti (IdUtente),
    FOREIGN KEY (Ristorante) REFERENCES Ristoranti (IdRistorante)
  ) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS
  BuoniPastoAccettati (
    Ristorante BINARY(16) NOT NULL,
    TipoBuono INT NOT NULL,
    PRIMARY KEY (Ristorante, TipoBuono)
  ) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS
  Prenotazioni (
    IdPrenotazione BINARY(16) NOT NULL DEFAULT UNHEX(
      REPLACE
        (UUID(), '-', '')
    ),
    DataPrenotazione DATETIME NOT NULL DEFAULT NOW(),
    Utente BINARY(16) NOT NULL,
    Evento BINARY(16) NOT NULL,
    Posti INT NOT NULL,
    Validata TINYINT DEFAULT FALSE,
    PRIMARY KEY (IdPrenotazione),
    FOREIGN KEY (Utente) REFERENCES Utenti (IdUtente),
    FOREIGN KEY (Evento) REFERENCES Eventi (IdEvento)
  ) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS
  InvalidJWT (Token VARCHAR(255) NOT NULL PRIMARY KEY) ENGINE = InnoDB;


CREATE TRIGGER ai_buonipasto AFTER
INSERT
  ON BuoniPasto FOR EACH ROW
SET
  @last_buonopasto_uuid = NEW.IdBuono;


CREATE TRIGGER ai_prenotazioni AFTER
INSERT
  ON Prenotazioni FOR EACH ROW
SET
  @last_prenotazione_uuid = NEW.IdPrenotazione;


CREATE TRIGGER ai_eventi AFTER
INSERT
  ON Eventi FOR EACH ROW
SET
  @last_evento_uuid = NEW.IdEvento;


CREATE TRIGGER ai_utenti AFTER
INSERT
  ON Utenti FOR EACH ROW
SET
  @last_utente_uuid = NEW.IdUtente;


CREATE TRIGGER ai_ristoranti AFTER
INSERT
  ON Ristoranti FOR EACH ROW
SET
  @last_ristorante_uuid = NEW.IdRistorante;