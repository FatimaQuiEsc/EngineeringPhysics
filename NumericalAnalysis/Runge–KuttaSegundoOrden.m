% ***********************
% Runge–Kutta de segundo orden (RK2)
% 
% Q.E Fatima
% 30-nov-2020, DCI-UG
% ***********************

clc;
clearvars;

% Descripcion del codigo
fprintf('       Runge–Kutta de segundo orden (RK2)    \n\n');
fprintf('  Dado cualquier PVI de una EDO, para un intervalo y h arbitrarios \n');
fprintf(' Encuentra iterativamente la solución de un problema de\n');
fprintf(' valor inicial (PVI) de una ecuación diferencial ordinaria.\n ');

%Se piden los datos de la edo
syms y(x) x 
f=input('Inserte su función f(x)=');
x0=input('\n Ingrese el primer punto x0:\n');
x1=input('\n Ingrese el segundo punto x1:\n');
y0=input('\n Ingrese la condicion inicial y(x0):\n');
n=input('\n Ingrese el numero de pasos n:\n');
h=(x1-x0)/n;
xs=x0:h:x1;


%Solucion analitica
eqn = diff(y,x) == f;
cond = y(x0) == y0;
ySol_(x) = dsolve(eqn,cond);

fprintf('La solución analitica es:\n');
ySol_(x)

%Tuve problemas con la funcion y dsolve. Lo unico que me funcionó 
% fue volver a pedirla al usuario con formato diferente 
f=input('Inserte su función f(x)=', 's');


%tabla
fprintf('          Tabla de datos\n')
fprintf('  i      xi       yi      ya  \n');
for i=1:n+1
    it=i-1;
    x0=xs(i);
    x=x0;
    y=y0;
    k1=h*eval(f);
    x=xs(i);
    y=y0+k1;
    k2=h*eval(f);
    y0=y0+(k1+k2)/2;
    ya=eval(ySol_(x));
    
    fprintf('\n%f %f  %f  %f\n',it,x0,y0, ya);
end
fprintf('\n El punto aproximado y(x1) es = %8.6f\n',y0);


T=(x0:h:x1);
%%Se grafica 
plot(it,y0, '--0',x0,ya,'r-','linewidth',1.5);
grid
xlabel('tiempo (s)');
ylabel('desplazamiento (m)');


pause(1000);


