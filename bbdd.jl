using SQLite
using DataFrames
using DBInterface

function crear_base_y_tablas()
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
        arcanossin TEXT NOT NULL,
        PRIMARY KEY(anyo)
    )
""")

    DBInterface.execute(db,"""
        DELETE FROM arcanosanyo
    """)
    DBInterface.execute(db,"""
        DELETE FROM casaloco
    """)
    DBInterface.execute(db,"""
        DELETE FROM arcanossinusar
    """)


DBInterface.close!(db)

end

function guardar_datos(anyo,casas,loco,sinusar)
    db = SQLite.DB("analisis_anyos.sqlite")   
    # Guardamos arcanos
    stmtarcanos = DBInterface.prepare(db, "INSERT INTO arcanosanyo (anyo, casa, arcanos) VALUES (?, ?, ?)")
    for (casa_salida,arcanos_salida) in casas
        txtarcanos=""
        for arcano in arcanos_salida
            txtarcanos=txtarcanos * string(arcano) * ";" 
        end
        DBInterface.execute(stmtarcanos,(anyo,parse(Int,casa_salida),txtarcanos))   
    end
    # Guardamos el arcano loco
    stmtloco = DBInterface.prepare(db, "INSERT INTO casaloco (anyo,casa) VALUES (?, ?)")
    DBInterface.execute(stmtloco,(anyo,loco))
    stmtsinusar = DBInterface.prepare(db,"INSERT INTO arcanossinusar (anyo,arcanossin) VALUES (?,?)")
    txtsinusar=""
    for arcano in sinusar
        txtsinusar=txtsinusar * string(arcano) * ";"
    end
    DBInterface.execute(stmtsinusar,(anyo,txtsinusar))
end

# Algunas consultas útiles :

#=
SELECT 
	anyo,
	arcanossin,
	LENGTH(arcanossin)-LENGTH(REPLACE(arcanossin,';','')) AS nro_arcanos
 FROM arcanossinusar
=#

#=
SELECT 
	anyo,
	arcanossin,
	LENGTH(arcanossin)-LENGTH(REPLACE(arcanossin,';','')) AS nro_arcanos
 FROM arcanossinusar WHERE arcanossin LIKE '%17%'
=#
