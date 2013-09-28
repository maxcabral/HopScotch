CREATE TABLE table_col (
  id INTEGER primary key AUTOINCREMENT NOT NULL,
  table_id int NOT NULL,
  name text NOT NULL,
  data_type text NOT NULL,
  nullable boolean NOT NULL DEFAULT 0,
  default_value text,
  is_primary_key boolean NOT NULL default 0
);
