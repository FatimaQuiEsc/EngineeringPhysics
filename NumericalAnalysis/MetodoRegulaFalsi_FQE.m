%_________________________________________
% F. Quijas Escalera
% 21-Aug-2020
% Método regula falsi
%_________________________________________
% Limpiamos pantalla y memoria
clc;
clear all; 

%Descripción
fprintf('Esta rutina resuelve dunciones a través del Método regula falsi \n');

% Funcion
f_aux= input('Escribe una funcion=','s');
%combierte la cadena a funcion
f= str2func(['@(x)',f_aux]);

% Paso 1
a= input('a= ');
b= input('b= ');
z= f(a);
y= f(b);
% Auxiliares
x= (((b*z)-(a*y))/(z-y));
n=10;
err= 0.5*10^(2-n);

% Encabezado de la tabla
fprintf('\n\ti \t\t\ta \t\t\t\tb \t\t\t\tx \t\t\t\tea \n\n');

% Método
for ii=1:250
    
    % x anterior
    x_ant=x;
    
    % Paso 2
    z= f(a);
    y= f(b);
    
%     fprintf('\n %f %f %f',z, y, m);
    x= (((b*z)-(a*y))/(z-y));
    
    ea= abs((x - x_ant)/x)*100;
    
    %Tabla
    fprintf('\t%i \t %.10f \t %.10f \t %.10f \t %.10f\n', ii, a , b, x, ea);

    %Paso 3
    if f(a)*f(x)<0 %la raiz esta en este intervalo
        b= x;
    else
        a= x;
    end
        
    % Error absoluto
    if ii>1
        if ea < err
            fprintf('\n\t La raíz encontrada es: x= %.10f \n\n',x);
            return 
        end
        pause(.1);
    end
end

%format long
%double(solve(f))
