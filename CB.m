function x=CB(x,lb,ub)
a=find(x>ub);
b=find(x<lb);
c=[a b];
x(c)=unifrnd(lb(c),ub(c));
end