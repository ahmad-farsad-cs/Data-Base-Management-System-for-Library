--- Création des tableaux ---
BEGIN TRANSACTION;
CREATE TABLE adherent (
    no_adherent SERIAL PRIMARY KEY,
    nom character varying(255) NOT NULL,
    prenom character varying(255) NOT NULL,
    adresse character varying(255) NOT NULL,
    phone character varying(15) NOT NULL
);

--

CREATE TABLE auteur (
    auteur_id SERIAL PRIMARY KEY,
    nom character varying(255) NOT NULL
);


CREATE TABLE livre (
    livre_id SERIAL PRIMARY KEY,
    titre character varying(255) NOT NULL,
    genre character varying(255) NOT NULL
);
--

CREATE TABLE commande (
    no_adherent integer NOT NULL,
    livre_id integer NOT NULL,
    date_commande date NOT NULL,
    quantite integer NOT NULL,
  PRIMARY KEY (no_adherent, livre_id, date_commande)
);



CREATE TABLE emprunte (
    no_adherent integer NOT NULL,
    livre_id integer NOT NULL,
    date_emprunt date NOT NULL,
    date_retour date,
  PRIMARY KEY (no_adherent, livre_id, date_emprunt)
);



CREATE TABLE livre_auteur (
    livre_id integer NOT NULL,
    auteur_id integer NOT NULL,
  PRIMARY KEY (livre_id, auteur_id)
);

--- Création de références ---

ALTER TABLE ONLY commande
    ADD CONSTRAINT commande_adherent FOREIGN KEY (no_adherent) REFERENCES adherent(no_adherent);


--
-- Name: commande commande_livreid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY commande
    ADD CONSTRAINT commande_livreid FOREIGN KEY (livre_id) REFERENCES livre(livre_id);


--
-- Name: emprunte emprunte_adherent; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY emprunte
    ADD CONSTRAINT emprunte_adherent FOREIGN KEY (no_adherent) REFERENCES adherent(no_adherent);


--
-- Name: emprunte emprunte_livreid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY emprunte
    ADD CONSTRAINT emprunte_livreid FOREIGN KEY (livre_id) REFERENCES livre(livre_id);


--
-- Name: livre_auteur livre_auteur_auteurid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY livre_auteur
    ADD CONSTRAINT livre_auteur_auteurid FOREIGN KEY (auteur_id) REFERENCES auteur(auteur_id);


--
-- Name: livre_auteur livre_auteur_livreid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY livre_auteur
    ADD CONSTRAINT livre_auteur_livreid FOREIGN KEY (livre_id) REFERENCES livre(livre_id);

COMMIT;

--- Insertion de données ---
	
BEGIN TRANSACTION;

INSERT INTO adherent (nom, prenom, adresse, phone) VALUES
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

INSERT INTO auteur (nom) VALUES
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

INSERT INTO livre (titre, genre) VALUES
('Cien años de soledad', 'Science-fiction'),
('Le petit Prince', 'Fantasy'),
('Odyssee', 'Romance'),
('Alice au pays des merveilles', 'Romance'),
('Moby Dick', 'Policier'),
('A deux metres de toi', 'Fantasy'),
('Belles endormies', 'Biographie'),
('Nuit blanche', 'Histoire'),
('Les Miserables', 'Science-fiction'),
('Calligrammes', 'Science-fiction'),
('Game of Thrones', 'Science-fiction'),
('Amour aux temps du choléra', 'Romance'),
('Chronique d''une mort annoncée', 'Fantasy'),
('Dolores Claiborne', 'Science-fiction');

INSERT INTO livre_auteur (livre_id, auteur_id) VALUES
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

INSERT INTO emprunte (no_adherent, livre_id, date_emprunt, date_retour) VALUES
(1, 1, '2023-01-15', '2023-01-29'),
(2, 2, '2023-02-20', '2023-03-06'),
(3, 3, '2023-03-15', '2023-03-29'),
(4, 4, '2023-04-30', '2023-05-14'),
(5, 1, '2023-06-01', '2023-06-15'),
(6, 6, '2023-06-20', '2023-07-04'),
(7, 7, '2023-07-25', '2023-08-08'),
(8, 8, '2023-08-15', '2023-08-29'),
(9, 1, '2023-09-10', '2023-09-24'),
(10, 2, '2023-10-25', '2023-11-08'),
(11, 11, '2023-11-20', '2023-12-04'),
(1, 12, '2023-11-23', '2023-12-02'),
(5, 13, '2023-11-25', '2023-12-10');


INSERT INTO commande (no_adherent, livre_id, date_commande, quantite) VALUES
(1, 8, '2023-01-10', 1),
(2, 3, '2023-02-12', 3),
(3, 9, '2023-03-05', 2),
(4, 5, '2023-04-20', 1),
(5, 6, '2023-05-28', 2),
(6, 7, '2023-06-10', 3),
(7, 8, '2023-07-18', 1),
(8, 9, '2023-08-10', 1),
(9, 2, '2023-09-01', 1),
(10, 11, '2023-10-15', 2),
(11, 8, '2023-11-10', 1);

COMMIT;

