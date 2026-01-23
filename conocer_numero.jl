function descomponer_en_cifras(nro_a_descomponer)
    lista_cifras_str=collect(string(nro_a_descomponer))
    lista_cifras=[]
    for i in lista_cifras_str
        push!(lista_cifras,parse(Int,i))
    end
    lista_cifras
end


function conocer_nro(nro_a_estudiar)
    l_cifras=descomponer_en_cifras(nro_a_estudiar)
    l_conocidos=[]
    b_1_digito=true
    nro_digitos_conocidos=0
    for i in 1:length(l_cifras)-1
        # Si la anterior comparacion fue de 2 digitos
        # reiniciamos y no leemos
        if (!b_1_digito)
            b_1_digito=true
            continue
        end
        nro_1_digito=l_cifras[i]
        lnro_2_digitos=l_cifras[i:i+1]
        nro_2_digitos=lnro_2_digitos[1]*10+lnro_2_digitos[2]
        # b_1_digito=true                   1 digito
        # b_1_digito=false                  2 digitos
        b_1_digito=true
        if ((nro_2_digitos>=10) && (nro_2_digitos<=21)) || (nro_2_digitos % 11 == 0)
            b_1_digito=false
        end
        if b_1_digito
            if (nro_1_digito!=0)
                push!(l_conocidos,nro_1_digito)
            end
            nro_digitos_conocidos+=1
        else
            if (nro_2_digitos!=0)
                push!(l_conocidos,nro_2_digitos)
            end
            nro_digitos_conocidos+=2
        end
    end
    # Evaluación de un posible último nro.
    if (nro_digitos_conocidos<length(l_cifras))
        if (l_cifras[end]!=0)
            push!(l_conocidos,l_cifras[end])
        end
    end
    l_conocidos
end

function usar_numeros(l_valores)
    dicc_casas=Dict()
    l_arcanos_usados=[]
    nro_casa=1
    for i in l_valores
        cifras_nro = conocer_nro(i)
        println(cifras_nro)
        for arcano in cifras_nro
            # El arcano aun no ha sido usado
            if !(arcano in l_arcanos_usados)
                if !(string(nro_casa) in keys(dicc_casas))
                    dicc_casas[string(nro_casa)]=[arcano]
                else 
                    push!(dicc_casas[string(nro_casa)],arcano)
                end
                push!(l_arcanos_usados,arcano)
            end
        end
        nro_casa=nro_casa+1
        if (nro_casa>9)
            nro_casa=1
        end
    end
    dicc_casas
    diccionario_ordenado_casas = sort(collect(dicc_casas), by=x->x[1])
    diccionario_ordenado_casas
end

function situar_loco(nro_pasos,dicc)
    arcano_loco=sum(conocer_nro(nro_pasos))
    if (arcano_loco>21) 
        return 0
    else
        for (clave,valor) in dicc
            if (arcano_loco in valor)
                return clave
            end
        end
        return 0
    end
end

function arcanos_sin_uso(dicc)
    l_arcanos_usados=[]
    l_arcanos_sin_usar=[]
    for (clave,valor) in dicc
        for arcano in valor
            push!(l_arcanos_usados,arcano)
        end
    end
    for arcano in 1:21
        if !(arcano in l_arcanos_usados)
            push!(l_arcanos_sin_usar,arcano)
        end 
    end
    l_arcanos_sin_usar
end

function pasar_a_dioses(dicc,dioses)
    dicc_dioses=Dict()
    for (clave,valor) in dicc
        cambio_clave=parse(Int,clave)
        dios=dioses[cambio_clave]
        dicc_dioses[dios]=valor
    end
    dicc_dioses
end