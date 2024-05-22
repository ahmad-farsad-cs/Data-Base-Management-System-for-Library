
CREATE TABLE adherent (
    no_adherent SERIAL PRIMARY KEY,
    nom character varying(255) NOT NULL,
    prenom character varying(255) NOT NULL,
    adresse character varying(255) NOT NULL,
    phone character varying(15) NOT NULL
);

--

CREATE TABLE auteurs (
    auteur_id SERIAL PRIMARY KEY,
    auteur_nom character varying(255) NOT NULL
);

CREATE TABLE genres (
    livre_id integer NOT NULL, 
    genre_nom VARCHAR(15) NOT NULL
);
CREATE TABLE livre (
    livre_id SERIAL PRIMARY KEY,
    titre character varying(255) NOT NULL,
    genre VARCHAR(50) NOT NULL
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

ALTER TABLE ONLY commande
    ADD CONSTRAINT commande_adherent FOREIGN KEY (no_adherent) REFERENCES adherent(no_adherent);



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
    ADD CONSTRAINT livre_auteur_auteurid FOREIGN KEY (auteur_id) REFERENCES auteurs(auteur_id);


--
-- Name: livre_auteur livre_auteur_livreid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY livre_auteur
    ADD CONSTRAINT livre_auteur_livreid FOREIGN KEY (livre_id) REFERENCES livre(livre_id);


ALTER TABLE ONLY genres
    ADD CONSTRAINT genre_livre FOREIGN KEY (livre_id) REFERENCES  livre(livre_id);


