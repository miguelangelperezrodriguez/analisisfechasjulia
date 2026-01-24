
include("conocer_numero.jl")
include("collatz.jl")
include("bbdd.jl")

nueve_elementos_egipcios=["Osiris","Horus","Geb","Bastet","Sethan","Khnum","Toht","Anubis","Atum"]

println("Introduzca año : ")
anyo=parse(Int,readline())

nro_estudiado=conocer_nro(anyo)
println(nro_estudiado)

lista=[]
suma=[]
nropasos=(collatz_steps(anyo,lista,suma))
println("Nro de pasos para expresar el arcano 0 : $nropasos")
@show length(lista)
lista_reducida=lista[2:28]
println("Lista de 9x3 elementos : $lista_reducida")
dicc_casas=usar_numeros(lista_reducida)
println(dicc_casas)
casa_loco=situar_loco(nropasos,dicc_casas)
println("Casa Arcano Loco : $casa_loco")
arcanos_sin_usar=arcanos_sin_uso(dicc_casas)
println("Arcanos no usados : ")
println(arcanos_sin_usar)
dicc_dioses=pasar_a_dioses(dicc_casas,nueve_elementos_egipcios)
println(dicc_dioses)


println("Introduzca SI para guardar en base de datos")
entrada_uso_bbdd = readline()

if (entrada_uso_bbdd=="SI")

    println("Introduza año inicio : ")
    anyo_inicio = parse(Int,readline())
    println("Introduzca año fin :")
    anyo_final = parse(Int,readline())

    # Guardamos los datos en la base de datos
    crear_base_y_tablas()

    # Guardamos valores de arcanos desde año 1000 a 3000
    for fecha in anyo_inicio:anyo_final
        println("Guardando fecha $fecha")
        anyo=fecha
        nro_estudiado=conocer_nro(anyo)
        lista=[]
        suma=[]
        nropasos=(collatz_steps(anyo,lista,suma))
        if (length(lista)<28)
            continue
        end
        lista_reducida=lista[2:28]   
        dicc_casas=usar_numeros(lista_reducida)
        casa_loco=situar_loco(nropasos,dicc_casas)    
        arcanos_sin_usar=arcanos_sin_uso(dicc_casas)
        guardar_datos(fecha,dicc_casas,casa_loco,arcanos_sin_usar)

    end
else
    println("Saliendo sin guardar.")
end