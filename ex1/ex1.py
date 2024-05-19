import csv
from io import TextIOWrapper
from zipfile import ZipFile

def process_movie_table(row_data, writer):
    movie_id = row_data['Film ID']
    movie_row = [row_data['Film ID'], 
                 row_data['Film'], 
                 row_data['Movie Time'], 
                 row_data['Movie Genre'], 
                 row_data['Year of Release'], 
                 row_data['Content Rating'], 
                 row_data['IMDB Rating'], 
                 row_data['IMDB Votes'], 
                 row_data['Film Studio/Producer(s)']]
    writer.writerow(movie_row)
    return movie_id

# process_file goes over all rows in original csv file, and sends each row to process_row()
def process_file(outfile):
    csv_files = [open(f"{name}.csv", 'w' , encoding='UTF8',newline='') for name in get_names()]
    writers = {name: csv.writer(file, delimiter=",", quoting=csv.QUOTE_MINIMAL) 
               for name, file in zip(get_names(), csv_files)}

    # Keeping track of unique values for each table
    movies = set()
    production_companies = set()
    directors = set()
    actors = set()
    authors = set()

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

                # Building the ProductionCompany table

            
    for file in csv_files:
        file.close()

# return the list of all tables
def get_names():
    return ['Movie', 
            'ProductionCompany', 
            'Director', 
            'DirectedBy', 
            'Actor', 
            'ActedBy', 
            'Author',
            'AuthoredBy', 
            'BestPictureAward', 
            'BestPictureNominee']

def split_list_value(list_value):
    return list_value.split("&&")
	
def main():
    """
    """
    # opens file.
    with open("oscars.csv", 'w' , encoding='UTF8',newline='') as oscars_outfile:
        process_file(oscars_outfile)

if __name__ == "__main__":
    main()

