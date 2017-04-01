begin transaction;

insert into life_configurations
   (name, width, height)
 values
   ('10x10', 10, 10);

-- y\x  0 1 2 3 4 5 6 7 8 9
--    0 x x
--    1       x
--    2           x
--    3               x
--    4       x   x   x
--    5       x x x
--    6         x
--    7         x
--    8 x x x
--    9   x x x x x x

INSERT INTO life
   (configuration, generation, x, y, alive)
 VALUES
   ('10x10', 0, 0, 0, true),
   ('10x10', 0, 0, 1, false),
   ('10x10', 0, 0, 2, false),
   ('10x10', 0, 0, 3, false),
   ('10x10', 0, 0, 4, false),
   ('10x10', 0, 0, 5, false),
   ('10x10', 0, 0, 6, false),
   ('10x10', 0, 0, 7, false),
   ('10x10', 0, 0, 8, true),
   ('10x10', 0, 0, 9, false),
   ('10x10', 0, 1, 0, true),
   ('10x10', 0, 1, 1, false),
   ('10x10', 0, 1, 2, false),
   ('10x10', 0, 1, 3, false),
   ('10x10', 0, 1, 4, false),
   ('10x10', 0, 1, 5, false),
   ('10x10', 0, 1, 6, false),
   ('10x10', 0, 1, 7, false),
   ('10x10', 0, 1, 8, true),
   ('10x10', 0, 1, 9, true),
   ('10x10', 0, 2, 0, false),
   ('10x10', 0, 2, 1, false),
   ('10x10', 0, 2, 2, false),
   ('10x10', 0, 2, 3, false),
   ('10x10', 0, 2, 4, false),
   ('10x10', 0, 2, 5, false),
   ('10x10', 0, 2, 6, false),
   ('10x10', 0, 2, 7, false),
   ('10x10', 0, 2, 8, true),
   ('10x10', 0, 2, 9, true),
   ('10x10', 0, 3, 0, false),
   ('10x10', 0, 3, 1, true),
   ('10x10', 0, 3, 2, false),
   ('10x10', 0, 3, 3, false),
   ('10x10', 0, 3, 4, true),
   ('10x10', 0, 3, 5, true),
   ('10x10', 0, 3, 6, false),
   ('10x10', 0, 3, 7, false),
   ('10x10', 0, 3, 8, false),
   ('10x10', 0, 3, 9, true),
   ('10x10', 0, 4, 0, false),
   ('10x10', 0, 4, 1, false),
   ('10x10', 0, 4, 2, false),
   ('10x10', 0, 4, 3, false),
   ('10x10', 0, 4, 4, false),
   ('10x10', 0, 4, 5, true),
   ('10x10', 0, 4, 6, true),
   ('10x10', 0, 4, 7, true),
   ('10x10', 0, 4, 8, false),
   ('10x10', 0, 4, 9, true),
   ('10x10', 0, 5, 0, false),
   ('10x10', 0, 5, 1, false),
   ('10x10', 0, 5, 2, true),
   ('10x10', 0, 5, 3, false),
   ('10x10', 0, 5, 4, true),
   ('10x10', 0, 5, 5, true),
   ('10x10', 0, 5, 6, false),
   ('10x10', 0, 5, 7, false),
   ('10x10', 0, 5, 8, false),
   ('10x10', 0, 5, 9, true),
   ('10x10', 0, 6, 0, false),
   ('10x10', 0, 6, 1, false),
   ('10x10', 0, 6, 2, false),
   ('10x10', 0, 6, 3, false),
   ('10x10', 0, 6, 4, false),
   ('10x10', 0, 6, 5, false),
   ('10x10', 0, 6, 6, false),
   ('10x10', 0, 6, 7, false),
   ('10x10', 0, 6, 8, false),
   ('10x10', 0, 6, 9, true),
   ('10x10', 0, 7, 0, false),
   ('10x10', 0, 7, 1, false),
   ('10x10', 0, 7, 2, false),
   ('10x10', 0, 7, 3, true),
   ('10x10', 0, 7, 4, true),
   ('10x10', 0, 7, 5, false),
   ('10x10', 0, 7, 6, false),
   ('10x10', 0, 7, 7, false),
   ('10x10', 0, 7, 8, false),
   ('10x10', 0, 7, 9, false),
   ('10x10', 0, 8, 0, false),
   ('10x10', 0, 8, 1, false),
   ('10x10', 0, 8, 2, false),
   ('10x10', 0, 8, 3, false),
   ('10x10', 0, 8, 4, false),
   ('10x10', 0, 8, 5, false),
   ('10x10', 0, 8, 6, false),
   ('10x10', 0, 8, 7, false),
   ('10x10', 0, 8, 8, false),
   ('10x10', 0, 8, 9, false),
   ('10x10', 0, 9, 0, false),
   ('10x10', 0, 9, 1, false),
   ('10x10', 0, 9, 2, false),
   ('10x10', 0, 9, 3, false),
   ('10x10', 0, 9, 4, false),
   ('10x10', 0, 9, 5, false),
   ('10x10', 0, 9, 6, false),
   ('10x10', 0, 9, 7, false),
   ('10x10', 0, 9, 8, false),
   ('10x10', 0, 9, 9, false);

commit;
