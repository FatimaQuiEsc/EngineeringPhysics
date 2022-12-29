% ***********************
% Diferencias finitas centrales
% 
% Q.E Fatima
% 22-nov-2020, DCI-UG
% ***********************


clc;
clearvars;

% Descripcion del codigo
fprintf('       Diferencias finitas centrales    \n\n');
fprintf('   Da una funcion arbitraria f(x),deriva  \n');
fprintf(' usando diferencias finitas centrales, para h\n ');
fprintf('  arbitraria y dado un punto x0 \n\n');

%Función y punto a evaluar
f_aux=input('Inserte su función f(x)=','s');
r=str2func(['@(x, y)',f_aux]);
g=dsolve(r, x)
f=input('\nIngrese la ecuacion diferencial de la forma: dy/dx=f(x,y)\n','s');
x0=input('\nIngrese el primer punto x0:\n');
x1=input('\nIngrese el segundo punto x1:\n');
y0=input('\nIngrese la condicion inicial y(x0):\n');
n=input('\nIngrese el numero de pasos n:\n');
h=(x1-x0)/n;
xs=x0:h:x1;
y1=y0;
fprintf('\n''i     x0     x1      y1');
for i=1:n
    it=i-1;
    x0=xs(i);
    x=x0;
    x1=xs(i+1);
    y=y0;
    y1=y0+h*eval(f);
    
    
    fprintf('\n%f  %f   %f   %f\n',it,x0,x1,y1);
    y0=y1;
end
fprintf('\n El punto aproximado y(x1) es = %10.6f\n',y1);

% f_aux=input('Inserte su función f(x)=','s');
% syms 
% eqn = diff(y,x) == f_aux;
% cond = y(0) == 3;
% ySol(t) = dsolve(eqn,cond)

% z = dsolve(r);
% z
% z=simplify(z)
% z=pretty(z)



pause(1000);