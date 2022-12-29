% ***********************
% Regla de Smpson compuesta 3/8
% 
% Q.E Fatima
% 20-nov-2020, DCI-UG
% ***********************

clc;
clearvars;
format rat
% Descripcion del codigo
fprintf('       Regla de Smpson compuesta 3/8   \n\n');
fprintf('   Da una funcion arbitraria f(x), en un intervalo [a, b]\n');
fprintf(' y una particion n, estima la integral de la funci�n \n\n');

%Funci�n e intervalos
f_aux=input('Inserte su funci�n f(x)=','s');
f=str2func(['@(x)',f_aux]);
syms x;
a=input('\nInserte el l�mite inferior a:');
b=input('\nInserte el l�mite superior b:');
n=input('\nInserte el n�mero de particiones:');
    
%Particiones
h=(b-a)/(2*n);
f0=0;
for i=1:n-1
    x=a+h*(2*i)
    f0=f0+f(x);
end
f1=0;
for i=1:n
    x=a+h*(2*i-1);
    f1=f1+f(x);
end
f0=2*f0+4*f1;
f0=f0+f(a)+f(b);
%Aproximamos la integral
aprox=(h/3)*f0;
%Mostramos los resultados en pantalla (con 3 decimales)
fprintf('\nAproximaci�n a la integral=%f \n',aprox);

pause(10000);