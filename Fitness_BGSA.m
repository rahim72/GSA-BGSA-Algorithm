
function   fitness=Fitness_BGSA(X,F_index,dim)
[N,dim]=size(X);
for i=1:N 
    L=X(i,:);
    %calculation of objective function
    fitness(i)=F_function(L,dim);
end
end
function fitness=F_function(L,dim)

    fitness=sum(L);
    
end