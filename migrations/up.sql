BEGIN TRANSACTION;

CREATE TABLE life_configurations
(
  name           TEXT NOT NULL PRIMARY KEY,
  width          INTEGER NOT NULL CHECK (width > 0),
  height         INTEGER NOT NULL CHECK (height > 0)
);
   
CREATE TABLE life
(
    configuration            TEXT NOT NULL REFERENCES life_configurations(name),
    generation               INTEGER NOT NULL,
    x                        INTEGER NOT NULL,
    y                        INTEGER NOT NULL,
    alive                    BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (configuration, generation, x, y)
);

CREATE DOMAIN cell_action AS TEXT
   CHECK (
     VALUE IN (
        'DEATH',
        'NO CHANGE',
        'BIRTH'
     )
   );

CREATE TABLE life_rules
(
    alive            BOOLEAN NOT NULL,
    neighbors        INTEGER NOT NULL,
    next_cell_action cell_action NOT NULL,
    PRIMARY KEY (alive, neighbors)
);

-- Any live cell with fewer than two live neighbours dies (referred to as underpopulation or exposure[1]).
-- Any live cell with more than three live neighbours dies (referred to as overpopulation or overcrowding).
-- Any live cell with two or three live neighbours lives, unchanged, to the next generation.
-- Any dead cell with exactly three live neighbours will come to life.

INSERT INTO life_rules
   (alive, neighbors, next_cell_action)
 VALUES
   (TRUE,  0, 'DEATH'),
   (TRUE,  1, 'DEATH'),
   (TRUE,  2, 'NO CHANGE'),
   (TRUE,  3, 'NO CHANGE'),
   (TRUE,  4, 'DEATH'),
   (TRUE,  5, 'DEATH'),
   (TRUE,  6, 'DEATH'),
   (TRUE,  7, 'DEATH'),
   (TRUE,  8, 'DEATH'),
   (FALSE, 0, 'NO CHANGE'),
   (FALSE, 1, 'NO CHANGE'),
   (FALSE, 2, 'NO CHANGE'),
   (FALSE, 3, 'BIRTH'),
   (FALSE, 4, 'NO CHANGE'),
   (FALSE, 5, 'NO CHANGE'),
   (FALSE, 6, 'NO CHANGE'),
   (FALSE, 7, 'NO CHANGE'),
   (FALSE, 8, 'NO CHANGE');

--
-- life_neighbor_deltas -- the deltaX and deltaY
--   values for all neighbors of a cell.
--

CREATE VIEW life_neighbor_deltas AS
  SELECT
    dx,
    dy
  FROM
    GENERATE_SERIES(-1, 1) AS dx,
    GENERATE_SERIES(-1, 1) AS dy
  WHERE
    NOT (dx = 0 AND dy = 0);

--
-- life_neighbors -- all cells with
--    all their neighbors given a
--    configuration
--

CREATE VIEW life_neighbors AS
  SELECT
    life_configurations.name as configuration,
    x,
    y,
    x+life_neighbor_deltas.dx AS nx,
    y+life_neighbor_deltas.dy AS ny
  FROM
    life_neighbor_deltas,
    life_configurations,
    GENERATE_SERIES(0, life_configurations.width-1) AS x,
    GENERATE_SERIES(0, life_configurations.height-1) AS y
  WHERE
    x+life_neighbor_deltas.dx >= 0 AND
    y+life_neighbor_deltas.dy >= 0 AND
    x+life_neighbor_deltas.dx < life_configurations.width AND
    y+life_neighbor_deltas.dy < life_configurations.height;

--
-- life_generation_state - the board at a given
--   generation, the currrent state of each
--  position (0,0) through (width-1,height-1)
--   and the number of neighbors that are alive

CREATE VIEW life_generation_state as
  SELECT
    life.configuration,
    life.generation,
    life.x,
    life.y,
    life.alive,
    SUM(CASE WHEN neighbors.alive THEN 1 ELSE 0 END) AS neighbors_alive
  FROM
    life
  INNER JOIN life_neighbors ON
    life_neighbors.x = life.x AND
    life_neighbors.y = life.y AND
    life_neighbors.configuration = life.configuration
  INNER JOIN life AS neighbors ON
    neighbors.x = life_neighbors.nx AND
    neighbors.y = life_neighbors.ny AND
    neighbors.generation = life.generation AND
    neighbors.configuration = life.configuration
  GROUP BY
    life.configuration,
    life.generation,
    life.x,
    life.y,
    life.alive;

-- next_life_generation - calculate the next generation's
--   board state given a specific generation.

CREATE VIEW next_life_generation AS
  SELECT
    life_generation_state.configuration,
    life_generation_state.generation,
    life_generation_state.x,
    life_generation_state.y,
    life_generation_state.alive AS was_alive,
    life_generation_state.neighbors_alive,
    life_rules.next_cell_action,
    CASE WHEN life_rules.next_cell_action = 'DEATH'::cell_action THEN FALSE
         WHEN life_rules.next_cell_action = 'NO CHANGE'::cell_action THEN life_generation_state.alive
         ELSE TRUE
      END AS alive
  FROM
    life_generation_state
  INNER JOIN life_rules ON
    life_rules.alive = life_generation_state.alive AND
    life_rules.neighbors = life_generation_state.neighbors_alive
  ORDER BY
    life_generation_state.configuration,
    life_generation_state.generation,
    life_generation_state.y,
    life_generation_state.x;

--
-- life_board -- a given generation in graphical form
--

CREATE VIEW life_board AS
  SELECT
    life.configuration,
    life.generation,
    life.y,
    ARRAY_TO_STRING(
      ARRAY_AGG(
         CASE WHEN life.alive THEN 'x' ELSE ' ' END ORDER BY life.x
      ),
      ''
    ) AS board
  FROM
    life
  GROUP BY
    life.configuration,
    life.generation,
    life.y
  ORDER BY
    life.configuration,
    life.generation,
    life.y;

--
-- life_board -- next board state for a given generation in graphical form
--

CREATE VIEW next_life_board AS
  SELECT
    next_life_generation.configuration,
    next_life_generation.generation,
    next_life_generation.y,
    ARRAY_TO_STRING(
      ARRAY_AGG(
            CASE WHEN next_life_generation.alive THEN 'x'
                 ELSE ' '
              END ORDER BY next_life_generation.x
      ),
      ''
    ) AS board
  FROM
    next_life_generation
  GROUP BY
    next_life_generation.configuration,
    next_life_generation.generation,
    next_life_generation.y
  ORDER BY
    next_life_generation.configuration,
    next_life_generation.generation,
    next_life_generation.y;

COMMIT;
