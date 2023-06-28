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

  INSERT INTO Utenti (Nome, Cognome, Username, PasswordHash, Email, CodiceVerifica, Verificato, Ruolo)
VALUES
  ('Mario', 'Rossi', 'mario123', 'c4ca4238a0b923820dcc509a6f75849b', 'mario@example.com', 123456, 1, 1),
  ('Luigi', 'Verdi', 'luigi456', 'c81e728d9d4c2f636f067f89cc14862c', 'luigi@example.com', 654321, 1, 2),
  ('Giovanna', 'Bianchi', 'giovanna789', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 'giovanna@example.com', 987654, 1, 2),
  ('Francesca', 'Neri', 'francesca012', 'a87ff679a2f3e71d9181a67b7542122c', 'francesca@example.com', 246810, 1, 3),
  ('Alessandro', 'Gialli', 'alessandro345', 'e4da3b7fbbce2345d7772b0674a318d5', 'alessandro@example.com', 135790, 1, 3),
  ('Sara', 'Marroni', 'sara678', '1679091c5a880faf6fb5e6087eb1b2dc', 'sara@example.com', 908172, 1, 3),
  ('Marco', 'Blu', 'marco901', '8f14e45fceea167a5a36dedd4bea2543', 'marco@example.com', 271819, 1, 3),
  ('Luisa', 'Arancio', 'luisa234', 'c9f0f895fb98ab9159f51fd0297e236d', 'luisa@example.com', 192837, 1, 3),
  ('Paolo', 'Viola', 'paolo567', '45c48cce2e2d7fbdea1afc51c7c6ad26', 'paolo@example.com', 918273, 1, 3),
  ('Chiara', 'Rosa', 'chiara890', 'd3d9446802a44259755d38e6d163e820', 'chiara@example.com', 738291, 1, 4);


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

INSERT INTO Eventi (Titolo, Sottotitolo, Descrizione, Durata, Data, Luogo, Posizione, Tipo, Prezzo, ConPrenotazione, Capienza, PostiOccupati)
VALUES
  ('Concerto di Rock', 'Una notte di musica e divertimento', 'Un concerto di rock che ti farà ballare tutta la notte', '02:30:00', '2023-06-24 20:00:00', 'Teatro XYZ', POINT(45.1234, 9.5678), 1, 25.50, 1, 1000, 500),
  ('Seminario di Marketing', 'Strategie per il successo nel mercato odierno', 'Un seminario informativo sulle ultime tendenze di marketing', '04:00:00', '2023-06-25 09:00:00', 'Centro Conferenze ABC', POINT(46.7890, 10.1234), 2, 0.00, 0, 200, 150),
  ('Mostra d''Arte Contemporanea', 'Scopri le opere dei migliori artisti contemporanei', 'Una mostra che espone una selezione di opere d''arte moderne', '03:30:00', '2023-06-26 18:00:00', 'Galleria d''Arte DEF', POINT(47.4567, 11.7890), 3, 12.99, 0, 500, 250),
  ('Concerto Acustico', 'Un''esperienza musicale intima', 'Un concerto acustico dal vivo con artisti locali', '01:30:00', '2023-06-27 19:30:00', 'Club XYZ', POINT(45.6789, 9.0123), 1, 15.00, 1, 200, 180),
  ('Conferenza sullo Sviluppo Personale', 'Scopri il tuo vero potenziale', 'Una conferenza interattiva per migliorare te stesso', '02:00:00', '2023-06-28 10:00:00', 'Centro Conferenze ABC', POINT(46.3456, 10.6789), 2, 10.99, 1, 150, 120),
  ('Mostra Fotografica', 'Istantanee di vita quotidiana', 'Una mostra fotografica che cattura la bellezza della vita di tutti i giorni', '02:30:00', '2023-06-29 17:30:00', 'Museo di Fotografia GHI', POINT(47.0123, 11.3456), 3, 8.50, 0, 300, 200),
  ('Spettacolo di Magia', 'Lasciati stupire da incredibili illusioni', 'Uno spettacolo di magia che ti lascerà a bocca aperta', '01:30:00', '2023-06-30 20:30:00', 'Teatro XYZ', POINT(45.7890, 9.2345), 1, 20.00, 1, 100, 90),
  ('Lezione di Cucina', 'Scopri i segreti della cucina italiana', 'Una lezione pratica per imparare a cucinare i piatti tradizionali italiani', '03:00:00', '2023-07-01 09:00:00', 'Scuola di Cucina MNO', POINT(46.4567, 10.9012), 2, 30.50, 1, 50, 40),
  ('Esposizione di Sculture', 'Amira l''arte in tre dimensioni', 'Un''esposizione di sculture di artisti rinomati', '02:30:00', '2023-07-02 16:00:00', 'Parco Pubblico PQR', POINT(47.1234, 11.5678), 3, 15.99, 0, 100, 80),
  ('Festival di Musica Indie', 'La scoperta dei nuovi talenti musicali', 'Un festival che celebra la musica indie con artisti emergenti', '06:00:00', '2023-07-03 14:00:00', 'Piazza Principale STU', POINT(48.7890, 12.1234), 1, 35.00, 1, 5000, 4000),
  ('Conferenza di Tecnologia', 'Le ultime novità nel mondo della tecnologia', 'Una conferenza per conoscere le nuove tendenze e innovazioni tecnologiche', '04:30:00', '2023-07-04 11:30:00', 'Centro Conferenze ABC', POINT(49.4567, 12.7890), 2, 15.99, 1, 300, 250),
  ('Mostra di Pittura', 'Un viaggio nel mondo dei colori', 'Una mostra che presenta opere pittoriche di artisti di fama internazionale', '03:00:00', '2023-07-05 17:00:00', 'Galleria d''Arte DEF', POINT(50.0123, 13.3456), 3, 10.50, 0, 400, 300),
  ('Spettacolo di Commedia', 'Ridere senza sosta con i migliori comici', 'Uno spettacolo comico che ti farà morire dalle risate', '02:00:00', '2023-07-06 21:00:00', 'Teatro XYZ', POINT(49.7890, 12.2345), 1, 18.00, 1, 200, 180);

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
    FOREIGN KEY (Proprietario) REFERENCES Utenti (IdUtente) ON DELETE CASCADE
  ) ENGINE = InnoDB;


SET @image = LOAD_FILE('/home/pi/NarniaFestival/db/menu.png');

INSERT INTO Ristoranti (Nome, Descrizione, Indirizzo, Posizione, Menu, Proprietario)
VALUES
  ('Ristorante di Chiara', 'Un ristorante accogliente che offre cucina tradizionale italiana', 'Via Roma 1, Milano', POINT(45.1234, 9.5678), @image);

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
    FOREIGN KEY (Utente) REFERENCES Utenti (IdUtente) ON DELETE CASCADE,
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
    FOREIGN KEY (Utente) REFERENCES Utenti (IdUtente) ON DELETE CASCADE,
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