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
f=str2func(['@(x)',f_aux]);
syms x;
x_0=input('\nInserte el punto donde desea evaluar la derivada:');

h = 0.001;
%Calculo de la derivada aprox
dfdx_central=(f(x_0+h)-f(x_0-h))/(2*h);
fprintf('La derivada aproximada de f evaluada en %f es: %f\n', x_0,dfdx_central );

%Derivada analitica 
d_a=diff(f,x);
y=subs(d_a, x, x_0);
fprintf('La derivada analitica de f evaluada en %f es: %f\n',x_0, y);
