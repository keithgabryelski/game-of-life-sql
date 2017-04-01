begin transaction;

insert into life_configurations
   (name, width, height)
 values
   ('5x5', 10, 10);

-- y\x  0 1 2 3 4
--    0 x x
--    1   x   x
--    2   x   x x 
--    3       x    
--    4       x   

INSERT INTO life
   (configuration, generation, x, y, alive)
 VALUES
   ('5x5', 0, 0, 0, true),
   ('5x5', 0, 0, 1, false),
   ('5x5', 0, 0, 2, false),
   ('5x5', 0, 0, 3, false),
   ('5x5', 0, 0, 4, false),
   ('5x5', 0, 1, 0, true),
   ('5x5', 0, 1, 1, true),
   ('5x5', 0, 1, 2, true),
   ('5x5', 0, 1, 3, false),
   ('5x5', 0, 1, 4, false),
   ('5x5', 0, 2, 0, false),
   ('5x5', 0, 2, 1, false),
   ('5x5', 0, 2, 2, false),
   ('5x5', 0, 2, 3, false),
   ('5x5', 0, 2, 4, false),
   ('5x5', 0, 3, 0, false),
   ('5x5', 0, 3, 1, true),
   ('5x5', 0, 3, 2, true),
   ('5x5', 0, 3, 3, true),
   ('5x5', 0, 3, 4, true),
   ('5x5', 0, 4, 0, false),
   ('5x5', 0, 4, 1, false),
   ('5x5', 0, 4, 2, true),
   ('5x5', 0, 4, 3, false),
   ('5x5', 0, 4, 4, false);

commit;
