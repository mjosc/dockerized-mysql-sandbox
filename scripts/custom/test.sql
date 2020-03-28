CREATE TABLE IF NOT EXISTS test (
	ID int AUTO_INCREMENT,
  ArbitraryData varchar(255),
	primary key (ID)
);

INSERT INTO test (ArbitraryData) VALUES ('Hello, World!');
