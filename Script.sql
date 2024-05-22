
--- Création des tableaux ---

BEGIN TRANSACTION;
CREATE TABLE Adherent (
No_adherent INTEGER NOT NULL PRIMARY KEY,
Nom VARCHAR(255) NOT NULL,
Prenom VARCHAR(255) NOT NULL,
Adresse VARCHAR(255) NOT NULL,
Phone VARCHAR(15) NOT NULL
);
CREATE TABLE Livre (
Livre_id INTEGER NOT NULL PRIMARY KEY,
Titre VARCHAR(255) NOT NULL
);
CREATE TABLE Genres (
Livre_id INTEGER NOT NULL,
Genre_nom VARCHAR(255) NOT NULL,
PRIMARY KEY (Livre_id, Genre_nom)
);
CREATE TABLE Auteurs (
Auteur_id INTEGER NOT NULL PRIMARY KEY,
Auteur_nom VARCHAR(255) NOT NULL
);
CREATE TABLE Livre_Auteur (
Livre_id INTEGER NOT NULL,
Auteur_id INTEGER NOT NULL,
PRIMARY KEY (Livre_id, Auteur_id)
);
CREATE TABLE Emprunte (
No_adherent INTEGER NOT NULL,
Livre_id INTEGER NOT NULL,
Date_emprunt DATE NOT NULL,
Date_retour DATE,
PRIMARY KEY (No_adherent, Livre_id, Date_emprunt)
);
CREATE TABLE Commande (
No_adherent INTEGER NOT NULL,
Livre_id INTEGER NOT NULL,
Date_commande DATE NOT NULL,
Quantite INTEGER NOT NULL, CHECK (Quantite <= 3),
PRIMARY KEY (No_adherent, Livre_id, Date_commande)
); 
COMMIT;

--- Création de références ---

BEGIN TRANSACTION;

CREATE SEQUENCE adherent_no_adherent_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE adherent_no_adherent_seq OWNED BY Adherent.No_adherent;

CREATE SEQUENCE livre_livre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE livre_livre_id_seq OWNED BY Livre.Livre_id;

CREATE SEQUENCE auteurs_auteur_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE auteurs_auteur_id_seq OWNED BY Auteurs.Auteur_id;

ALTER TABLE ONLY Adherent ALTER COLUMN no_adherent SET DEFAULT nextval('adherent_no_adherent_seq'::regclass);

ALTER TABLE ONLY Auteurs ALTER COLUMN Auteur_id SET DEFAULT nextval('auteurs_auteur_id_seq'::regclass);

ALTER TABLE ONLY Livre ALTER COLUMN Livre_id SET DEFAULT nextval('livre_livre_id_seq'::regclass);

ALTER TABLE Livre_Auteur
ADD CONSTRAINT livre_auteur_livreid
FOREIGN KEY (Livre_id)
REFERENCES Livre(Livre_id);

ALTER TABLE Livre_Auteur
ADD CONSTRAINT livre_auteur_auteurid
FOREIGN KEY (Auteur_id)
REFERENCES Auteurs(Auteur_id);

ALTER TABLE Genres
ADD CONSTRAINT genres_livreid
FOREIGN KEY (Livre_id)
REFERENCES Livre(Livre_id);

ALTER TABLE Emprunte
ADD CONSTRAINT emprunte_adherent
FOREIGN KEY (No_adherent)
REFERENCES Adherent(No_adherent);

ALTER TABLE Emprunte
ADD CONSTRAINT emprunt_livreid
FOREIGN KEY (Livre_id)
REFERENCES Livre(Livre_id);

ALTER TABLE Commande
ADD CONSTRAINT commande_adherent
FOREIGN KEY (No_adherent)
REFERENCES Adherent(No_adherent);

ALTER TABLE Commande
ADD CONSTRAINT commande_livreid
FOREIGN KEY (Livre_id)
REFERENCES Livre(Livre_id);

COMMIT;

--- Insertion de données ---

BEGIN TRANSACTION;

INSERT INTO Adherent (Nom, Prenom, Adresse, Phone) VALUES
('Seda', 'Carlos', '3066 Boulevard Decarie', '514-555-1234'),
('Solis', 'Diego', '456 Chihuahua St', '514-555-2345'),
('Galicia', 'Eduardo', '789 Chicago St', '514-555-3456'),
('Torres', 'Sofia', '321 Vendome St', '514-555-4567'),
('Camargo', 'Eva', '654 Pina St', '514-555-5678'),
('Ocean', 'Frank', '987 Justin St', '514-555-6789'),
('Johnson', 'Drake', '147 Hillary St', '514-555-7890'),
('Camargo', 'Alfonso', '258 Microsoft St', '514-555-8901'),
('Solis', 'Ivan', '369 Veracruz St', '514-555-9012'),
('Miles', 'Judy', '963 Sinaloa St', '514-555-0123'),
('Pena', 'Mali', '741 Juan St', '514-555-1230');

INSERT INTO Auteurs (Auteur_nom) VALUES
('Gabriel Garcia Marquez'),
('Antoine de Saint-Exupéry'),
('Homero'),
('Lewis Carroll'),
('Herman Melville'),
('Rachael Lippincott'),
('Miiki Daughtry'),
('Stephen King'),
('Owen King'),
('John Green'),
('Maureen Johnson'),
('Lauren Myracle'),
('Victor Hugo'),
('Guillaume Apollinaire'),
('George R.R.Martin'); 

INSERT INTO Livre (Titre) VALUES
('Cien años de soledad'),
('Le petit Prince'),
('Odyssee'),
('Alice au pays des merveilles'),
('Moby Dick'),
('A deux metres de toi'),
('Belles endormies'),
('Nuit blanche'),
('Les Miserables'),
('Calligrammes'),
('Game of Thrones'),
('Amour aux temps du choléra'),
('Chronique dune mort annoncee'),
('Dolores Claiborne');

INSERT INTO Genres (Livre_Id, Genre_nom) VALUES
(1, 'Science-fiction'),
(2, 'Fantasy'),
(3, 'Romance'),
(4, 'Romance'),
(5, 'Policier'),
(6, 'Fantasy'),
(7, 'Biographie'),
(8, 'Histoire'),
(9, 'Science-fiction'),
(10, 'Science-fiction'),
(11, 'Science-fiction'),
(12, 'Romance'),
(13, 'Fantasy'),
(14, 'Science-fiction');

INSERT INTO Livre_Auteur (Livre_id, Auteur_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5), 
(6, 6),
(12, 1),
(7, 8),
(8, 10),
(13, 1),
(14, 12),
(9, 13),
(10, 14),
(11, 15);

INSERT INTO Emprunte (No_adherent, Livre_id, Date_emprunt, Date_retour) VALUES
(1, 1, '2022-01-15', '2022-01-29'),
(2, 2, '2022-02-20', '2022-03-06'),
(3, 3, '2022-03-15', '2022-03-29'),
(4, 4, '2022-04-30', '2022-05-14'),
(5, 1, '2022-06-01', '2022-06-15'),
(6, 6, '2022-06-20', '2022-07-04'),
(7, 7, '2022-07-25', '2022-08-08'),
(8, 8, '2022-08-15', '2022-08-29'),
(9, 1, '2022-09-10', '2022-09-24'),
(10, 2, '2022-10-25', '2022-11-08'),
(11, 11, '2022-11-20', '2022-12-04'),
(1, 12, '2023-04-01', '2023-04-29'),
(5, 13, '2023-03-02', '2023-04-30');

INSERT INTO Commande (No_adherent, Livre_id, Date_commande, Quantite) VALUES
(1, 8, '2022-01-10', 1),
(2, 3, '2022-02-12', 3),
(3, 9, '2022-03-05', 2),
(4, 5, '2022-04-20', 1),
(5, 6, '2022-05-28', 2),
(6, 7, '2022-06-10', 3),
(7, 8, '2022-07-18', 1),
(8, 9, '2022-08-10', 1),
(9, 2, '2022-09-01', 1),
(10, 11, '2023-01-15', 2),
(11, 8, '2023-02-10', 1);

COMMIT;



