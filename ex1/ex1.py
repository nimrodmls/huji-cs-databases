import csv
from io import TextIOWrapper
from zipfile import ZipFile

# Mapping between the table names to their respective columns
TABLE_NAMES = {'ProductionCompany': ['Film Studio/Producer(s)'], 
               'Movie': ['Film ID', 'Film', 'Movie Time', 'Year of Release', 
                         'Content Rating', 'IMDB Rating', 'IMDB Votes', 'Film Studio/Producer(s)'], 
               'Director': ['Director'], 
               'DirectedBy': ['Film ID', 'Director'],
               'Actor': ['Actor'], 
               'ActedIn': ['Film ID', 'Actor'],
               'Author': ['Author'],
               'AuthoredBy': ['Film ID', 'Author'],
               'Genres': ['Movie Genre'],
               'MovieGenre': ['Film ID', 'Movie Genre'],
               'BestPictureAward': ['Oscar Year', 'Film ID'],
               'BestPictureNominee': ['Oscar Year', 'Film ID']}

def init_csv_writer(file, columns):
    writer = csv.writer(file, delimiter=",", quoting=csv.QUOTE_MINIMAL)
    writer.writerow(columns)
    return writer

def process_row(row_data, writer, table_name):
    csv_data = [row_data[column] for column in TABLE_NAMES[table_name]]
    writer.writerow(csv_data)

def process_movie_table(row_data, writer):
    movie_id = row_data['Film ID']
    movie_row = [row_data['Film ID'], 
                 row_data['Film'], 
                 row_data['Movie Time'], 
                 row_data['Year of Release'], 
                 row_data['Content Rating'], 
                 row_data['IMDB Rating'], 
                 row_data['IMDB Votes'], 
                 row_data['Film Studio/Producer(s)']]
    writer.writerow(movie_row)
    return movie_id

# process_file goes over all rows in original csv file, and sends each row to process_row()
def process_file():
    csv_files = [open(f"{name}.csv", 'w' , encoding='UTF8',newline='') for name in get_names()]
    writers = {name: init_csv_writer(file, TABLE_NAMES[name])
               for name, file in zip(get_names(), csv_files)}

    # Keeping track of unique values for each table
    movies = set()
    production_companies = set()
    directors = set()
    actors = set()
    authors = set()
    genres = set()

    with ZipFile('oscars.zip') as zf:
        with zf.open('oscars.csv', 'r') as infile:
            reader = list(csv.reader(TextIOWrapper(infile, 'utf-8')))
            # Starting to analyze the data from the second row, past the header
            for row in reader[1:]:
                # Transforming to a dict, in which the key is the column name
                # in the CSV file, and the value is the value of the row in that column
                row_data = dict(zip(reader[0], row))

                # Building & Writing the Movie table
                movie_id = row_data['Film ID']
                if movie_id not in movies:
                    movies.add(process_movie_table(row_data, writers['Movie']))
                else: # If the movie already been processed, we skip it
                    continue

                # Building the ProductionCompany table
                production_company = row_data['Film Studio/Producer(s)']
                if production_company not in production_companies:
                    production_companies.add(production_company)
                    writers['ProductionCompany'].writerow([production_company])

                # Building the Director and DirectedBy table
                movie_directors = split_list_value(row_data['Directors'])
                for director in movie_directors:
                    if director == '': # Sometimes there can be no director
                        continue

                    writers['DirectedBy'].writerow([movie_id, director])
                    if director not in directors:
                        directors.add(director)
                        writers['Director'].writerow([director])

                # Building the Actor and ActedBy tables
                movie_actors = split_list_value(row_data['Actors'])
                for actor in movie_actors:
                    if actor == '': # Sometimes there can be no actors
                        continue
                    
                    writers['ActedIn'].writerow([movie_id, actor])
                    if actor not in actors:
                        actors.add(actor)
                        writers['Actor'].writerow([actor])

                # Building the Author and AuthoredBy tables
                movie_authors = split_list_value(row_data['Authors'])
                for author in movie_authors:
                    if author == '': # Sometimes there can be no authors
                        continue

                    writers['AuthoredBy'].writerow([movie_id, author])
                    if author not in authors:
                        authors.add(author)
                        writers['Author'].writerow([author])

                # Building the MovieGenre table
                movie_genres = split_list_value(row_data['Movie Genre'])
                for genre in movie_genres:
                    if genre == '': # Sometimes there can be no genres
                        continue

                    writers['MovieGenre'].writerow([movie_id, genre])
                    if genre not in genres:
                        genres.add(genre)
                        writers['Genres'].writerow([genre])

                # Building the BestPictureAward and BestPictureNominee tables
                if 'Winner' == row_data['Award']:
                    writers['BestPictureAward'].writerow([row_data['Oscar Year'], movie_id])
                else:
                    writers['BestPictureNominee'].writerow([row_data['Oscar Year'], movie_id])

            
    for file in csv_files:
        file.close()

# return the list of all tables
def get_names():
    return TABLE_NAMES.keys()

def split_list_value(list_value):
    return set([value.strip() for value in list_value.split("&&")])
	
def main():
    """
    """
    # opens file.
    process_file()

if __name__ == "__main__":
    main()

