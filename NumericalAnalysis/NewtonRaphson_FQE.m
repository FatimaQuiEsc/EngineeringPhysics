% ***********************
% Metodo Newton-Raphson
% 
% Q.E Fatima
% 08-sep-2020, DCI-UG
% ***********************

% Limpiamos
clc;
clear all;

% Descripcion del codigo
fprintf('         Metodos abiertos: Newton-Raphson \n\n');
fprintf(' Encuentra al menos una raiz de f(x)dado un punto inicial x0\n\n');


%Damos de alta la variable simbólica X
syms x
%Introducimos la función,el punto de inicio y porcentaje de error
    f=input('Introduzca la función f(x):');
    pi=input('Introduzca el punto de inicio:');
    err=input('Porcentaje de error:');
    
    %Calculamos la derivada de la función
    d=diff(f)
    d=inline(d);
    f=inline(f);
    ea=100;

% Encabezado de la tabla
fprintf('\n\ti \t\t\tx \t\t\t\tx+i \t\t\t\tea \n\n');
while ea>err
    %Aproximamos la raiz con la fórmula correpondiente
    xi=pi-(f(pi)/d(pi));
    %Calculamos el porcentaje de error
    ea=abs(((xi-pi)/xi)*100);
    
    i=i+1;
%Tabla
    fprintf('\t%i \t %.10f \t %.10f \t %.10f \t \n', i, pi, xi, ea);
    pi=xi;
end
%Mostramos los resultados en pantalla (con 3 decimales)
fprintf('\nRaiz= %10.3f en %d Iteraciones',pi, i);
pause(5);