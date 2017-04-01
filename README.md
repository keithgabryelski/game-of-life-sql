# game-of-life-sql
Conway's Game of Life written in SQL

## create the database

```bash
psql < migrations/create-db.sql
```

## add tables and views

```bash
psql < game_of_life migrations/up.sql
```

## seed the board with 10x10 board

```bash
psql < game_of_life seeds/seed-10x10.sql
```

## show seeded board

```bash
el-guapo$ psql game_of_life
psql (9.4.2)
Type "help" for help.

game_of_life=# SELECT * FROM life_board WHERE generation = 0 AND configuration = '10x10';
 configuration | generation | y |   board    
---------------+------------+---+------------
 10x10         |          0 | 0 | xx        
 10x10         |          0 | 1 |    x      
 10x10         |          0 | 2 |      x    
 10x10         |          0 | 3 |        x  
 10x10         |          0 | 4 |    x x x  
 10x10         |          0 | 5 |    xxx    
 10x10         |          0 | 6 |     x     
 10x10         |          0 | 7 |     x     
 10x10         |          0 | 8 | xxx       
 10x10         |          0 | 9 |  xxxxxx   
(10 rows)
game_of_life=# 
```

## show next generation

```bash
game_of_life=# SELECT * FROM next_life_board WHERE generation = 0 AND configuration = '10x10';
 configuration | generation | y |   board    
---------------+------------+---+------------
 10x10         |          0 | 0 |           
 10x10         |          0 | 1 |           
 10x10         |          0 | 2 |           
 10x10         |          0 | 3 |     x     
 10x10         |          0 | 4 |    x x    
 10x10         |          0 | 5 |    x xx   
 10x10         |          0 | 6 |           
 10x10         |          0 | 7 |  x x      
 10x10         |          0 | 8 | x         
 10x10         |          0 | 9 | x  xxx    
(10 rows)

game_of_life=# 
```

## update database with some generations

```bash
game_of_life=# INSERT INTO life (configuration, generation, x, y, alive)
game_of_life-#   SELECT
game_of_life-#     configuration,
game_of_life-#     generation+1,
game_of_life-#     x,
game_of_life-#     y,
game_of_life-#     alive
game_of_life-#   FROM
game_of_life-#     next_life_generation
game_of_life-#   WHERE
game_of_life-#     generation = (select max(generation) from life where configuration = '10x10') AND
game_of_life-#     configuration = '10x10';
INSERT 0 100
game_of_life=# INSERT INTO life (configuration, generation, x, y, alive)
game_of_life-#   SELECT
game_of_life-#     configuration,
game_of_life-#     generation+1,
game_of_life-#     x,
game_of_life-#     y,
game_of_life-#     alive
game_of_life-#   FROM
game_of_life-#     next_life_generation
game_of_life-#   WHERE
game_of_life-#     generation = (select max(generation) from life where configuration = '10x10') AND
game_of_life-#     configuration = '10x10';
INSERT 0 100
game_of_life=# INSERT INTO life (configuration, generation, x, y, alive)
game_of_life-#   SELECT
game_of_life-#     configuration,
game_of_life-#     generation+1,
game_of_life-#     x,
game_of_life-#     y,
game_of_life-#     alive
game_of_life-#   FROM
game_of_life-#     next_life_generation
game_of_life-#   WHERE
game_of_life-#     generation = (select max(generation) from life where configuration = '10x10') AND
game_of_life-#     configuration = '10x10';
INSERT 0 100
game_of_life=# INSERT INTO life (configuration, generation, x, y, alive)
game_of_life-#   SELECT
game_of_life-#     configuration,
game_of_life-#     generation+1,
game_of_life-#     x,
game_of_life-#     y,
game_of_life-#     alive
game_of_life-#   FROM
game_of_life-#     next_life_generation
game_of_life-#   WHERE
game_of_life-#     generation = (select max(generation) from life where configuration = '10x10') AND
game_of_life-#     configuration = '10x10';
INSERT 0 100
game_of_life=# 
```

## look at the generations

```bash
game_of_life=# SELECT * FROM life_board WHERE generation = 1 AND configuration = '10x10';
 configuration | generation | y |   board    
---------------+------------+---+------------
 10x10         |          1 | 0 |           
 10x10         |          1 | 1 |           
 10x10         |          1 | 2 |           
 10x10         |          1 | 3 |     x     
 10x10         |          1 | 4 |    x x    
 10x10         |          1 | 5 |    x xx   
 10x10         |          1 | 6 |           
 10x10         |          1 | 7 |  x x      
 10x10         |          1 | 8 | x         
 10x10         |          1 | 9 | x  xxx    
(10 rows)

game_of_life=# SELECT * FROM life_board WHERE generation = 2 AND configuration = '10x10';
 configuration | generation | y |   board    
---------------+------------+---+------------
 10x10         |          2 | 0 |           
 10x10         |          2 | 1 |           
 10x10         |          2 | 2 |           
 10x10         |          2 | 3 |     x     
 10x10         |          2 | 4 |    x xx   
 10x10         |          2 | 5 |      xx   
 10x10         |          2 | 6 |   x x     
 10x10         |          2 | 7 |           
 10x10         |          2 | 8 | xxxx      
 10x10         |          2 | 9 |     x     
(10 rows)

game_of_life=# SELECT * FROM life_board WHERE generation = 3 AND configuration = '10x10';
 configuration | generation | y |   board    
---------------+------------+---+------------
 10x10         |          3 | 0 |           
 10x10         |          3 | 1 |           
 10x10         |          3 | 2 |           
 10x10         |          3 | 3 |     xx    
 10x10         |          3 | 4 |       x   
 10x10         |          3 | 5 |    x  x   
 10x10         |          3 | 6 |      x    
 10x10         |          3 | 7 |           
 10x10         |          3 | 8 |  xxx      
 10x10         |          3 | 9 |  xxx      
(10 rows)

game_of_life=# SELECT * FROM life_board WHERE generation = 4 AND configuration = '10x10';
 configuration | generation | y |   board    
---------------+------------+---+------------
 10x10         |          4 | 0 |           
 10x10         |          4 | 1 |           
 10x10         |          4 | 2 |           
 10x10         |          4 | 3 |      x    
 10x10         |          4 | 4 |     x x   
 10x10         |          4 | 5 |      xx   
 10x10         |          4 | 6 |           
 10x10         |          4 | 7 |   x       
 10x10         |          4 | 8 |  x x      
 10x10         |          4 | 9 |  x x      
(10 rows)

game_of_life=# SELECT * FROM life_board WHERE generation = 5 AND configuration = '10x10';
 configuration | generation | y | board 
---------------+------------+---+-------
(0 rows)

game_of_life=# 
```
