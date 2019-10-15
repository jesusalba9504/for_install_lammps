using DelimitedFiles,Distributions



function distancia(p1,p2)
    return sqrt((p1[1]-p2[1])^2+(p1[2]-p2[2])^2+(p1[3]-p2[3])^2)
end

function verifica(lista,pos,dist)
    t=[0];
    for k=1:length(lista)
        if distancia(pos,lista[k]) < dist
            push!(t,1);
        else push!(t,0);
        end
    end
    return sum(t);
end

a=[[1 [1 1 1]],[2 [1 1 2]]]
a[1]

function genera_particles(ion_number)
    dist_zn_o = 1.9;
    dist_zn_zn = 2.6;
    dist_o_o = 1.25;
    zn_lista = [];
    i = 1;
    while length(zn_lista) < ion_number
        new_pos=[rand(Uniform(0,60)) rand(Uniform(0,60)) rand(Uniform(14,50))];
        if verifica(zn_lista,new_pos,dist_zn_zn)==0
            push!(zn_lista,new_pos)
            i+=1
        end
    end

    o_lista = [];
    while length(o_lista) < ion_number
        new_pos=[rand(Uniform(0,60)) rand(Uniform(0,60)) rand(Uniform(14,50))];;
        if verifica(zn_lista,new_pos,dist_zn_o)==0 && verifica(o_lista,new_pos,dist_o_o)==0
            push!(o_lista,new_pos)
            i+=1
        end
    end
    return append!(zn_lista,o_lista)
end

function escribe(n)
    a=genera_particles(n/2)
    b=[i for i in 1:n]
    c=append!(["Zn" for i in 1:n/2],["O" for i in 1:n/2])
    d=[]

    for i in 1:n
        push!(d,[c[i] a[i]])
    end
    return d
end



open("/home/simulations/Documents/electric_field_proyect/generate_nr/ini2.dat","w") do io
    writedlm(io,escribe(2000))
end

# open("/home/jesus/Documents/electric_field_proyect/file_for_math","w") do io
#     writedlm(io,genera_particles(360,zn_zn,zn_o,o_o))
# end
