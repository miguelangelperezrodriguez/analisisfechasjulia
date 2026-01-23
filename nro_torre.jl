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

# Lectura nro
#entradanro = 2027
println("Introduzca nro : ")
entrada = readline()
entradanro = parse(Int,entrada)

println("Collatz nro : $entradanro")
lista=[]
suma=[]
nropasos=(collatz_steps(entradanro,lista,suma))
println("Nro. pasos : $nropasos")
for dato in lista
    print("$dato ")
end
println()
for dato_suma in suma
    println("Suma : $dato_suma")
end
