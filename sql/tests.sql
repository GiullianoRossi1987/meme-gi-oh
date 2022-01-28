INSERT INTO tb_cards (nm_card, dsc_card, vl_price) 
VALUES ("card1", "cum", 13), ("card2", "cum2", 14);

INSERT INTO tb_deck (nm_user, id_card) 
VALUES ("cumlord", 1), ("cumlord", 1);

CALL inventory_card_stats("cumlord");

INSERT INTO tb_frag_inv (nm_user, vl_type_fragment, id_card_from)
VALUES ("cumlord", "top", 1), ("cumlord", "left", 1), ("cumlord", "right", 1), ("cumlord", "bottom", 1);

CALL inventory_fragment_stats("cumlord");
