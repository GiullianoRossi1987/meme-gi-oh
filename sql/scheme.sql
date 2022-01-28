-- MySQL & MariaDB

CREATE OR REPLACE TABLE tb_cards(
	cd_card INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nm_card LONGTEXT NOT NULL,
	dsc_card LONGTEXT NOT NULL,
	vl_attack DECIMAL(10, 2) NOT NULL DEFAULT 10,
	vl_defense DECIMAL(10, 2) NOT NULL DEFAULT 10,
	vl_type VARCHAR(10) NOT NULL DEFAULT "NORMAL",
	hp_uses DECIMAL(10, 2) NOT NULL DEFAULT 10.2,
	vl_price DECIMAL(10, 2) NOT NULL,
	vl_rareness INTEGER NOT NULL DEFAULT 0 CHECK(vl_rareness IN (0, 1, 2, 3, 4))
);

CREATE OR REPLACE TABLE tb_currency(
	cd_currency INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nm_user VARCHAR(255) NOT NULL,
	vl_currency DECIMAL(10, 2) NOT NULL DEFAULT 500
);

CREATE OR REPLACE TABLE tb_deck(
	cd_inventory_entrance INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nm_user VARCHAR(255) NOT NULL,
	id_card INTEGER NOT NULL,
	vl_hp DECIMAL(10, 2) NOT NULL DEFAULT 100,
	qtd_card INTEGER NOT NULL DEFAULT 1,
	FOREIGN KEY (id_card) REFERENCES tb_cards(cd_card)
);

CREATE OR REPLACE TABLE tb_frag_inv(
	-- Table for the cards fragments on the inventory
	cd_inventory_entrance INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nm_user VARCHAR(255) NOT NULL,
	vl_type_fragment VARCHAR(6) NOT NULL CHECK(vl_type_fragment IN ("top", "left", "right", "bottom")),
	id_card_from INTEGER NOT NULL,
	FOREIGN KEY (id_card_from) REFERENCES tb_cards(cd_card)
);
-- Procedures
DELIMITER $
CREATE OR REPLACE PROCEDURE inventory_card_stats(IN name_user VARCHAR(255))
BEGIN
	SELECT c.*, 
	u.vl_hp as card_hp,
	u.qtd_card as card_qtd
	FROM tb_cards AS c
	INNER JOIN tb_deck as u
	ON u.id_card = c.cd_card
	WHERE u.nm_user LIKE name_user;
END$

CREATE OR REPLACE PROCEDURE inventory_fragment_stats(IN name_user VARCHAR(255))
BEGIN
	SELECT f.vl_type_fragment as type_frag,
	c.*
	FROM tb_cards AS c
	INNER JOIN tb_frag_inv as f
	ON f.id_card_from = c.cd_card
	WHERE f.nm_user LIKE name_user
	GROUP BY c.nm_card, f.vl_type_fragment;
END$

DELIMTER ;
