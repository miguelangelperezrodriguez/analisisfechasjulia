
# INFORMACIÓN SOBRE NACIMIENTO.

function collatz_steps(n,salida,lsuma)
    suma=0
    if (n<1)
        throw(DomainError("Número inválido"))
    end
    if (n==1)
        return 0
    end
    pasos=0
    while (n>1)
        push!(salida,n)
        suma+=n
        if n % 2 == 0
            n = div(n,2)
        else
            n = n * 3 + 1
        end
        pasos+=1
    end
    push!(lsuma,suma)
    pasos
end

function fecha_entrada()
    println("Introduzca fecha :")
    println("Día :")
    dia = readline()
    println("Mes :")
    mes = readline()
    println("Año :")
    anyo = readline()
    dia * mes * anyo
end

function anyo_entrada()
    println("Año al que referirse . CASA : ")
    anyo=readline()
    anyo
end

function pasos(entrada)
    lista=[]
    suma=[]
    pasos=[]
    while(entrada>1)
        push!(pasos,entrada)
        entrada=(collatz_steps(entrada,lista,suma))
    end
    push!(pasos,1)
end

function suma_cadena(cadena)
    suma_cifras = 0
    for caracter in cadena
        if isdigit(caracter)
        suma_cifras += parse(Int, caracter)
        end
    end
    suma_cifras
end

# Lectura nro
#entradanro = 2027
entradanro = parse(Int,fecha_entrada())
l_pasos=(pasos(entradanro))
println(l_pasos)

entradaanyo = parse(Int,anyo_entrada())
l_pasos_anyo=(pasos(entradaanyo))
suma=sum(l_pasos_anyo)

l_pasos_compuesto=[]
for i in l_pasos
    push!(l_pasos_compuesto,string(i)*string(suma))
end
println(l_pasos_compuesto)

l_pasos_compuesto_suma=[]
for i in l_pasos_compuesto
    push!(l_pasos_compuesto_suma,suma_cadena(i))
end
println(l_pasos_compuesto_suma)
