function z=ob_fucn(x)
global choice
if strcmp(choice,'Ackley')
%     temp1=0;
%     temp2=0;
%     n=size(x,2);
%     for i=1:n
%         temp1=temp1+x(i)^2;
%         temp2=temp2+cos(2*pi*x(i));
%     end
%     z=20+exp(1)-20*exp(-0.2*sqrt(temp1/n))-exp(temp2/n);
    d = length(x);
sum = 0;
for ii = 1:d
	xi = x(ii);
	sum = sum + (xi^2 - 10*cos(2*pi*xi));
end

z = 10*d + sum;


elseif strcmp(choice,'Sphere')
    
    n = size(x,2);
    z = 0;
for i = 1:n
    z = z + x(i).^2;
end  
    
elseif strcmp(choice,'Cigar')
    z=x(1)^2;
n=size(x,2);
for i=2:n
    z=z+(10^4)*x(i)^2;
end
elseif strcmp(choice,'Ellipse')
    z=0;
n=size(x,2);
for i=1:n
    z=z+(10^(4*(i-1)/(n-1)))*x(i)^2;
end
    
elseif strcmp(choice,'Rosenbrock')
    z=0;
for i=1:(size(x,2)-1)
    z=z+100*(x(i+1)-(x(i))^2)^2+(x(i)-1)^2;
end
    
elseif strcmp(choice,'Griewangk')
   
 temp1=0;
temp2=1;
for i=1:size(x,2)
    temp1=temp1+(x(i)^2)/4000;
    temp2=temp2*cos(x(i)/sqrt(i));
end
z=temp1-temp2+1;  

else
    z=sum(x.^2,2);
end
%

end











