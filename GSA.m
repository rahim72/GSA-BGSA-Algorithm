%%  A Gravitational Search Algorithm
%%
global choice
% Call Function And Selection Benchmark
%
choice = SelectBenchmark;
%% Inititation Parameter
%%
prompt={ ' Maximum Number of Iterations', ' Population Size', 'Number Of Variable', ' alfa','go',...
    };
title='Enter a Value';
nline=([1 40;1 40;1 40;1 40;1 40]);
default={ '1000', '50', '5', '20', '100'};
ev=inputdlg(prompt,title,nline,default);
aa=ev(1,:);aa=str2num(aa{:});                        max_iteration=aa;        % Maximum Number of Iterations
bb=ev(2,:);bb=str2num(bb{:});                   num_pop=bb;                 % Population Size
cc=ev(3,:);cc=str2num(cc{:});                       nvar=cc;                               % Number Of Variable
dd=ev(4,:);dd=str2num(dd{:});                     alfa=dd;
ff=ev(5,:);ff=str2num(ff{:});                             G0=ff;
%%
%%

lower_b=-10*ones(1,nvar);    % Lower Bound
upper_b= 10*ones(1,nvar);    % Upper Bound

Rpower=1;
final_per=2;  % In the last iter, only 2 percent of agents apply force to the others.
%% Initial Population
tic
for run=1:3
temp.x=[];
temp.fit=[];
temp.velocity=[];
temp.mass=[];
temp.gfield=[];
object=repmat(temp,num_pop,1);
for i=1:num_pop
    
    object(i).x=unifrnd(lower_b,upper_b);
    object(i).fit=ob_fucn(object(i).x);
    object(i).velocity=0;
    object(i).mass=0;
    object(i).gfield=0;
    
end
[~,index]=min([object.fit]);
gpop=object(index);


    %% Main Loop GSA
    Best=zeros(max_iteration,1);
    Mean=zeros(max_iteration,1);
    for iter=1:max_iteration
        %Calculation of M
        %%
        npop=length(object);
        f=[object.fit];
        best=min(f);
        worst=max(f);
        f=(f-worst)./(best-worst);
        f=f./sum(f);
        for i=1:npop
            object(i).mass=f(i);
        end
        %%
        %%
        %Calculation of Gravitational constant
        G=G0*exp(-alfa*(iter/max_iteration));
        
        %%
        %Calculation of accelaration in gravitational field
        %%
        npop=length(object);
        kbest=final_per+(1-(iter/max_iteration))*(100-final_per);
        kbest=round(npop*kbest/100);
        [~,index]=sort([object.mass],'descend');
        bestindex=index(1:kbest);
            for i=1:npop
                object(i).gfield=zeros(1,nvar);
                for j=bestindex
                    if i~=j
                        d=object(j).x-object(i).x;      % distanse
                        R=norm(object(i).x-object(j).x);%Euclidian distanse
                        E=(d*object(j).mass.*rand(1,nvar))./(R^Rpower+eps);
                        object(i).gfield=object(i).gfield+E;
                    end
                end
                object(i).gfield=object(i).gfield*G;
            end
        %%
        %%
        npop=length(object);
        lim=0.04*(upper_b-lower_b);
        
        for i=1:npop
            
            object(i).velocity=rand.*object(i).velocity+object(i).gfield;
%             object(i).velocity=CB(object(i).velocity,-lim,lim); 
            object(i).x=object(i).x+object(i).velocity;
            object(i).x=CB(object(i).x,lower_b,upper_b);     
            object(i).fit=ob_fucn(object(i).x);
        end
        
        [value,index]=min([object.fit]);
        
        if value<gpop.fit
            gpop=object(index);
        end
        Best(iter)=gpop.fit;
        beeest=Best;
        Mean(iter)=mean([object.fit]);
        
        disp([' Number of Iterations = '  num2str(iter)   ' Best Fitness = ' num2str(gpop.fit)])
    end
    ListBestCost(run,1)=beeest(iter);
    
end

%% Results


disp('===============================================')
disp([ ' Best Popution = '  num2str(gpop.x)])
disp([ ' Best Fitness = '  num2str(gpop.fit)])
disp([ ' Time = '  num2str(toc)])
disp('===============================================')

Average=mean(ListBestCost);
disp (' ' )
disp (' ' )
disp ('--------------------------------------------------------------------------------------------' )
disp ('List Best Cost : ')
disp (ListBestCost)
disp ('--------------------------------------------------------------------------------------------' )
disp (' ' )
disp ('--------------------------------------------------------------------------------------------' )
disp (['Average : ', num2str(Average)])
disp (['Time : ', num2str(toc)])
disp ('--------------------------------------------------------------------------------------------' )

figure(1)
plot(Best,'r');
hold on
plot(Mean,'b');
xlabel('Iteration')
ylabel(' Fitness')
legend(' BEST' , 'MEAN')
hold off

clear aa bb cc dd ee ff ee choice i j index iter