CREATE DATABASE IF NOT EXISTS narnia_db CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE narnia_db;

CREATE TABLE IF NOT EXISTS Ruoli (
  Id INT NOT NULL,
  Descrizione VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY (Id)
);

DELETE FROM Ruoli;

INSERT INTO Ruoli VALUES
(1, 'admin'),
(2, 'iscritto'),
(3, 'ospite'),
(4, 'partner');

CREATE TABLE IF NOT EXISTS Utenti (
  IdUtente BINARY(16) NOT NULL DEFAULT (UUID_TO_BIN(UUID())),
  Nome VARCHAR(50) NOT NULL,
  Cognome VARCHAR(50) NOT NULL,
  Username VARCHAR(50) NOT NULL,
  PasswordHash VARCHAR(64) NOT NULL,
  Email VARCHAR(320) NOT NULL UNIQUE,
  CodiceVerifica INT(6) NOT NULL,
  Verificato TINYINT NOT NULL DEFAULT FALSE,
  Ruolo INT NOT NULL DEFAULT 3,
  PRIMARY KEY (IdUtente),
  FOREIGN KEY (Ruolo) REFERENCES Ruoli(Id)
);

INSERT INTO Utenti (Nome, Cognome, Username, PasswordHash, Email, CodiceVerifica, Verificato, Ruolo)
VALUES
('Mario', 'Rossi', 'mrossi', 'password123', 'mario.rossi@example.com', '123456', 1, 1),
('Luigi', 'Verdi', 'lverdi', 'password456', 'luigi.verdi@example.com', '234567', 0, 2),
('Giovanni', 'Bianchi', 'gbianchi', 'password789', 'giovanni.bianchi@example.com', '345678', 0, 2),
('Paola', 'Neri', 'pneri', 'passwordabc', 'paola.neri@example.com', '456789', 1, 3),
('Sara', 'Russo', 'srusso', 'passworddef', 'sara.russo@example.com', '567890', 1, 4);

CREATE TABLE IF NOT EXISTS TipiEventi (
  Id INT NOT NULL,
  Descrizione VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY(Id)
);

DELETE FROM TipiEventi;

INSERT INTO TipiEventi VALUES
(1, 'Concerto'),
(2, 'Lezione'),
(3, 'Mostra');

CREATE TABLE IF NOT EXISTS Eventi (
  IdEvento BINARY(16) NOT NULL DEFAULT (UUID_TO_BIN(UUID())),
  Titolo VARCHAR(50) NOT NULL,
  Sottotitolo VARCHAR(100) NOT NULL,
  Descrizione VARCHAR(1024) NOT NULL,
  Durata TIME NOT NULL,
  Data DATETIME NOT NULL,
  Luogo VARCHAR(500) NOT NULL,
  Posizione GEOMETRY SRID 4326,
  Tipo INT NOT NULL,
  Prezzo FLOAT(5,2) NOT NULL DEFAULT 0,
  ConPrenotazione TINYINT NOT NULL DEFAULT FALSE,
  Capienza INT,
  PostiOccupati INT,
  PRIMARY KEY (IdEvento),
  FOREIGN KEY (Tipo) REFERENCES TipiEventi(Id)
);

CREATE TABLE IF NOT EXISTS Strutture (
  IdStruttura BINARY(16) NOT NULL DEFAULT (UUID_TO_BIN(UUID())),
  Nome VARCHAR(50) NOT NULL,
  Descrizione VARCHAR(1024) NOT NULL,
  Indirizzo VARCHAR(100) NOT NULL,
  Posizione GEOMETRY SRID 4326,
  UrlMenu TEXT NOT NULL,
  Proprietario BINARY(16) NOT NULL,
  PRIMARY KEY (IdStruttura),
  FOREIGN KEY (Proprietario) REFERENCES Utenti(IdUtente)
);

CREATE TABLE IF NOT EXISTS TipiBuono (
  Id INT NOT NULL,
  Valore FLOAT(5,2) NOT NULL,
  Nome VARCHAR(50) NOT NULL,
  Descrizione VARCHAR(200) NOT NULL,
  PRIMARY KEY(Id)
);

DELETE FROM TipiBuono;

INSERT INTO TipiBuono VALUES
(1, 7, 'Basic', '1 primo o secondo, acqua a volontà, 1 caffè'),
(2, 10, 'Premium', '1 primo o secondo, acqua a volontà, 1 caffè, 1 dolce'),
(3, 15, 'Executive', '1 primo, 1 secondo, acqua a volontà, 1 caffè, 1 dolce');

CREATE TABLE IF NOT EXISTS BuoniPasto (
  IdBuono BINARY(16) NOT NULL DEFAULT (UUID_TO_BIN(UUID())),
  Valido TINYINT NOT NULL DEFAULT FALSE,
  Tipo INT NOT NULL,
  Utente BINARY(16) NOT NULL,
  PRIMARY KEY (IdBuono),
  FOREIGN KEY (Tipo) REFERENCES TipiBuono (Id),
  FOREIGN KEY (Utente) REFERENCES Utenti (IdUtente)
);

CREATE TABLE IF NOT EXISTS BuoniPastoAccettati (
  Struttura BINARY(16) NOT NULL,
  TipoBuono INT NOT NULL,
  PRIMARY KEY (Struttura, TipoBuono)
);

CREATE TABLE IF NOT EXISTS Prenotazioni (
  IdPrenotazione BINARY(16) NOT NULL DEFAULT (UUID_TO_BIN(UUID())),
  DataPrenotazione DATETIME NOT NULL,
  Utente BINARY(16) NOT NULL,
  Evento BINARY(16) NOT NULL,
  Validata TINYINT DEFAULT FALSE,
  PRIMARY KEY (IdPrenotazione),
  FOREIGN KEY (Utente) REFERENCES Utenti (IdUtente),
  FOREIGN KEY (Evento) REFERENCES Eventi (IdEvento)
);
