SELECT * FROM next_life_board WHERE configuration = '10x10' AND generation = (select max(generation) from life where configuration = '10x10');

