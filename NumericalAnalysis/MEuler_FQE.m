% ***********************
% Método de Euler
% 
% Q.E Fatima
% 25-nov-2020, DCI-UG
% ***********************


clc;
clearvars;

% Descripcion del codigo
fprintf('        Método de Euler    \n\n');
fprintf('  Dado cualquier PVI de una EDO, para un intervalo y h arbitrarios \n');
fprintf(' Encuentra iterativamente la solución de un problema de\n');
fprintf(' valor inicial (PVI) de una ecuación diferencial de primer orden.\n ');

%Función y punto a evaluar
f=input('\nIngrese la ecuacion diferencial de la forma: dy/dx=f(x,y)\n','s');
x0=input('\nIngrese el primer punto:');
x1=input('\nIngrese el segundo punto:');
y0=input('\nIngrese la condicion inicial y(x)=');
n=input('\nIngrese el numero de pasos n (h=(b-a)/n): \n\n');
h=(x1-x0)/n;
xs=x0:h:x1;
y1=y0;


%tabla
fprintf('          Tabla de datos\n')
fprintf('    i           xi           yi\n');
for i=1:n+1
    it=i-1;
    x0=xs(i);
    x=x0;
    x1=xs(i);
    y=y0;
    y1=y0+h*eval(f);
    %datos de la tabla
    fprintf('\n%f     %f     %f     %f \n',it,x0,y1,edo2(i));
    y0=y1;
end

% Campo vectorial
    xmax= max(abs(x0),abs(x1))*1.05;
    ymax= max(abs((max(y_rk))),abs((y0)))*1.2;
    dx= xmax/15.001;
    dy= ymax/15.002;
    [X,Y]= meshgrid(-xmax:dx:xmax, -ymax:dy:ymax);
    f_mesh= subs(f,[x,y],{X,Y});
    unos= ones(size(f_mesh));
    quiver(X,Y,unos,f_mesh,'MaxHeadSize',0.01);

pause(1000);