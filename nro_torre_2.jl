
include("conocer_numero.jl")
include("collatz.jl")

nueve_elementos_egipcios=["Osiris","Horus","Geb","Bastet","Sethan","Khnum","Toht","Anubis","Atum"]

println("Introduzca año : ")
anyo=parse(Int,readline())

nro_estudiado=conocer_nro(2026)
println(nro_estudiado)

lista=[]
suma=[]
nropasos=(collatz_steps(anyo,lista,suma))
println("Nro de pasos para expresar el arcano 0 : $nropasos")
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