%% BGSA
%% Inititation Parameter
%%
prompt={ ' Maximum Number of Iterations', ' Population Size', 'Number Of Variable', ' alfa','go',...
};
title='Enter a Value';
nline=([1 40;1 40;1 40;1 40;1 40]);
default={ '1000', '10', '5', '20', '100'};
ev=inputdlg(prompt,title,nline,default);
aa=ev(1,:);aa=str2num(aa{:});                        max_iteration=aa;        % Maximum Number of Iterations                                                                       
bb=ev(2,:);bb=str2num(bb{:});                   num_pop=bb;                 % Population Size                                                            
cc=ev(3,:);cc=str2num(cc{:});                       nvar=cc;                               % Number Of Variable                                                    
dd=ev(4,:);dd=str2num(dd{:});                     alfa=dd;                                                                                       
ff=ev(5,:);ff=str2num(ff{:});                             G0=ff;                                                                                              
%%
%%
pop=50; 
F_index=24;  
flag=0; 
 %Allowable range and the dimension 
 down=0;
 up=1;
 dim=160;  
n=dim;
%random initialization of agents.
X=rand(pop,n)>.5;
%create best so far  and average fitnesses
BestC=[];
MeanC=[];
tic
for iter=1:max_iteration
%     iteration
    %Evaluation of agents.
     fitness=Fitness_BGSA(X,dim);       
    if iter>1
        if flag==1   %minimization
            afit=find(fitness>fitnessold);
        else             %maximization
            afit=find(fitness<fitnessold);
        end
    X(afit,:)=Xold(afit,:);
    fitness(afit)=fitnessold(afit);
    end
    if flag==1
    [best best_X]=min(fitness); %minimization.
    else
    [best best_X]=max(fitness); %maximization.
    end          
    if iter==1
       Fbest=best;Lbest=X(best_X,:);
    end
    if flag==1
      if best<Fbest  %minimization.
       Fbest=best;
       Lbest=X(best_X,:);
      end
    else 
      if best>Fbest  %maximization
       Fbest=best;
       Lbest=X(best_X,:);
      end
    end   
BestC=[BestC Fbest];
MeanC=[MeanC mean(fitness)];
%Calculation of M
Fmax=max(fitness); 
Fmin=min(fitness); 
Fmean=mean(fitness); 
[i pop]=size(fitness);

if Fmax==Fmin
   M=ones(pop,1);
else
   if flag==1 
      best=Fmin;
      worst=Fmax; % minimization
   else 
      best=Fmax;
      worst=Fmin; % maximization
   end
  
   M=(fitness-worst)./(best-worst);
end
M=M./sum(M); 
%Calculation of Gravitational constant
 G0=1;
 G=G0*(1-(iter/max_iteration)); 
%Calculation of accelaration in the gravitational field
 final_per=2; 
%% Total Force Calculation
     kbest=final_per+(1-iter/max_iteration)*(100-final_per); 
     kbest=round(pop*kbest/100);
    [Ms ds]=sort(M,'descend');
 for iff=1:pop
     E(iff,:)=zeros(1,n);
     for ii=1:kbest
         jjj=ds(ii);
         if jjj~=ii
            R=sum(X(iff,:)~=X(jjj,:)); R=R/n; %normalized Hamming distance.
         for kk=1:n 
             E(iff,kk)=E(iff,kk)+rand*(M(jjj))*((X(jjj,kk)-X(iff,kk))/(R^1+1/n));
            
         end
         end
     end
 end
a=E.*G; 
%%%
Xold=X;
fitnessold=fitness;
% Agent movement
V=zeros(pop,n);
V=rand(pop,n).*V+a;
S=abs(tanh(V)); 
temp=rand(pop,n)<S;
moving=find(temp==1);
X(moving)=~X(moving);       

    disp([' Number of Iterations = '  num2str(iter)   ' Best Fitness = ' num2str(max(BestC))])
    
end  
 disp('===============================================')
disp([ ' Best Fitness = '  num2str(max(BestC))])
disp([ ' Time = '  num2str(toc)])
disp('===============================================')
 
 figure;
 plot(BestC,'-r');