INSERT INTO life (configuration, generation, x, y, alive)
  SELECT
    configuration,
    generation+1,
    x,
    y,
    alive
  FROM
    next_life_generation
  WHERE
    generation = (select max(generation) from life where configuration = '10x10') AND
    configuration = '10x10';
