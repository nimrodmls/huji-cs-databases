create table ProductionCompany(
  company_name varchar(100) primary key
);

create table Movie(
  filmId varchar(100) primary key,
  film_name varchar not null,
  duration integer,
  genre varchar(100),
  release_year integer,
  content_rating varchar(100),
  imdb_rating float,
  imdb_votes integer,
  production_company varchar(100),
  foreign key(production_company) references ProductionCompany(company_name)
);

create table Director(
  director_name varchar(100) primary key
);

create table DirectedBy(
  filmId varchar(100),
  director_name varchar(100),
  primary key(filmId, director_name),
  foreign key(filmId) references movie(filmId),
  foreign key(director_name) references director(director_name)
);

create table Actor(
  actor_name varchar(100) primary key
);

create table ActedIn(
  filmId varchar(100),
  actor_name varchar(100),
  primary key(filmId, actor_name),
  foreign key(filmId) references movie(filmId),
  foreign key(actor_name) references actor(actor_name)
);

create table Author(
  author_name varchar(100) primary key
);

create table AuthoredBy(
  filmId varchar(100),
  author_name varchar(100),
  primary key(filmId, author_name),
  foreign key(filmId) references movie(filmId),
  foreign key(author_name) references author(author_name)
);

create table BestPictureAward(
  award_year integer primary key,
  filmId varchar(100),
  foreign key(filmId) references movie(filmId)
);

create table BestPictureNominee(
  award_year integer,
  filmId varchar(100),
  primary key(award_year, filmId),
  foreign key(filmId) references movie(filmId)
);