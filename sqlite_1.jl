
using SQLite
using DataFrames
using DBInterface

# Make a connection
db = SQLite.DB("analisis_anyos.sqlite")

# To find out all tables available in schema

DBInterface.execute(db, """
    CREATE TABLE IF NOT EXISTS arcanosanyo (
        anyo INTEGER NOT NULL,
        casa INTEGER NOT NULL,
        arcanos TEXT,
        PRIMARY KEY(anyo,casa)
    )
""")

DBInterface.execute(db, """
    CREATE TABLE IF NOT EXISTS casaloco (
        anyo INTEGER NOT NULL,
        casa INTEGER NOT NULL,
        PRIMARY KEY(anyo)
    )
""")

DBInterface.execute(db, """
    CREATE TABLE IF NOT EXISTS arcanossinusar (
        anyo INTEGER NOT NULL,
        arcanossin INTEGER NOT NULL,
        PRIMARY KEY(anyo)
    )
""")






# USO TABLAS
#
#tbls = SQLite.tables(db)
# To load a specific table (movies table from Movies.db)
#q = "SELECT * FROM usuarios"
#data = SQLite.DBInterface.execute(db,q)
# To get as a dataframe
#df = DataFrames.DataFrame(data)
