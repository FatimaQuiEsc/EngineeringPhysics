% ***********************
% Tercer Examen Parcial código 1 de 3
%
% Encontrar raíces reales de funciones de una variable, a través de los
% métodos: bisección, regula falsi, Newton–Raphson y secante.
%
% Q.E Fatima
% 06-dic-2020, DCI-UG
% ***********************


clc;
clearvars;

fprintf('Encuentra raíces de funciones de una variable');
uno_todos = menu('Elige una opcion','Comparar los métodos', 'Ejecutar un método en particular');
%Eliminamos la ventana de eleccion
clc
switch uno_todos %switich is the command, unit is the vaiable that we want to use
%__________________________________________________________      
    case 1
      fprintf('\n            COMPARAR LOS MÉTODOS \n \n');
      f_aux= input('Escribe una funcion =  ','s');
      f= str2func(['@(x)',f_aux]);
        a= input('a= ');
        b= input('b= ');
        a_or=a;
        b_or=b;
        
        %REGULA FALSI
        fprintf('\nMétodo regula falsi \n');
z= f(a);
y= f(b);
x= (((b*z)-(a*y))/(z-y));
n=10;
err= 0.5*10^(2-n);
for ii=1:250
    x_ant=x;
    z= f(a);
    y= f(b);
    x= (((b*z)-(a*y))/(z-y));
    ea= abs((x - x_ant)/x)*100;
    if f(a)*f(x)<0 %la raiz esta en este intervalo
        b= x;
    else
        a= x;
    end
    % Error absoluto
    if ii>1
        if ea < err
        
            if i<1
                i=2;
            fprintf('\t Raíz encontrada es x= %.10f \n\n',x);
            end
        end
    end
end

a=a_or;
b=b_or;
x=0;
i=0;

fprintf('Método de Bisección \n');
% Bisección
x= (a+b)/2;
n=10;
err= 0.5*10^(2-n);
for ii=1:250
    x_ant=x;
    x= (a+b)/2;
    ea= abs((x - x_ant)/x)*100;
    if f(a)*f(x)<0 %la raiz esta en este intervalo
        b= x;
    else
        a= x;
    end
    if ii>1
        if ea < err
            
            if i<1
                i=2;
            fprintf('\t Raíz encontrada es x= %.10f \n\n',x);
            end
        end
    end
end

pi=a_or;

%NEWTON_R
fprintf('Método Newton-Raphson \n');
syms x 
    f=input('Vuelve a escribir la funcion=  ');
%     f= str2sym(f)
%     pi=input('Introduzca el punto de inicio=  ');
    err=0.0001;
    derivada_de_f = diff(f);
    derivada_de_f=inline(derivada_de_f);
    f=inline(f);
    ea=100;
while ea>err
    xi=pi-(f(pi)/derivada_de_f(pi));
    ea=abs(((xi-pi)/xi)*100);
    i=i+1;
    pi=xi;
end
fprintf('\t Raíz encontrada es x= %f\n',pi);

a=a_or;
b=b_or;
x=0;
i=0;

n=10;
  error= 0.5*10^(2-n);
        fprintf('\nMétodo de secante\n');
                    syms x
                    ea=1;
                    i=0;
                    while(ea > error)
                        i=i+1;
                        %Metodo de la secante 
                        c= b-(f(b)*(a-b)/(f(a)-f(b)));
                        % Error aproximado
                        ea  = abs((c-b)/c)*100;
                        %Guardando las nuevas variables.x
                        a=b;
                        b=c;
                    end 
fprintf('\t Raíz encontrada es x= %f\n',c);
%__________________________________________________________---
      case 2
        
Unit = menu('Elige el método','Método de Bisección', 'Método regula falsi', 'Método Newton-Raphson', 'Secante'); %pop up display
clc
switch Unit %switich is the command, unit is the vaiable that we want to use
      case 1 %given inches %case must be given as a number, starting with 1=first option, 2=second option, and so on
   % Método de Bisección{
  
   fprintf('\n\t   Método de Bisección \n\n');
   f_aux= input('Escribe una funcion=','s');
%combierte la cadena a funcion
f= str2func(['@(x)',f_aux]);

% Paso 1
a= input('a= ');
b= input('b= ');

% Auxiliares
x= (a+b)/2;
n=10;
err= 0.5*10^(2-n);

% Encabezado de la tabla
fprintf('\ti \t\ta \t\t\tb \t\t\tx \t\t\tea \n');

% Método
for ii=1:250
    
    % x anterior
    x_ant=x;
    
    % Paso 2
    x= (a+b)/2;
    
    ea= abs((x - x_ant)/x)*100;
    
    %Tabla
    fprintf('\t %i \t %.10f \t %.10f \t %.10f \t %.10f\n', ii, a , b, x, ea);

    %Paso 3
    if f(a)*f(x)<0 %la raiz esta en este intervalo
        b= x;
    else
        a= x;
    end
   
    % Condicional del error
    if ii>1
        if ea < err
            fprintf('\n\t La raíz encontrada es: x= %.10f \n\n',x);
            return %detiene el codigo, stop se usa en otros
        end
        pause(0.1);
    end
end

%..........................................................
      case 2 %given feet
          % Funcion
          fprintf('\n \t   Método regula falsi \n\n');
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
%.....................................................
      case 3
      fprintf('\n \t   Método Newton-Raphson \n\n');
syms x
%Introducimos la función,el punto de inicio y porcentaje de error
    f=input('Escribe una funcion=');
    pi=input('Introduzca el punto de inicio=');
    err=input('Porcentaje de error=');
    
    %Calculamos la derivada de la función
    derivada_de_f=diff(f)
    derivada_de_f=inline(derivada_de_f);
    f=inline(f);
    ea=100;

% Encabezado de la tabla
fprintf('\ti\t\t\tx \t\t\t x+i \t\t\t ea \n\n');
while ea>err
    %Aproximamos la raiz con la fórmula correpondiente
    xi=pi-(f(pi)/derivada_de_f(pi));
    %Calculamos el porcentaje de error
    ea=abs(((xi-pi)/xi)*100);
    
    i=i+1;
%Tabla
    fprintf('\t%i \t %.10f \t %.10f \t %.10f \t \n', i, pi, xi, ea);
    pi=xi;
end
%Mostramos los resultados en pantalla (con 3 decimales)
fprintf('\nRaiz= %10.3f en %d Iteraciones \n',pi, i);
pause(5);
%......................................................
    case 4
        fprintf('\n \tMétodo de secante\n\n');
        f_aux=input('Inserte su función f(x)=','s');
  f=str2func(['@(x)',f_aux]);
  a=input('a= ');
  b=input('b= ');
  n=10;
  error= 0.5*10^(2-n);
                    syms x
                    fprintf('\t i \t\t x_i-1 \t\t\t x_i \t\t\tx_i+1  \t\t\tError \n');
                    ea=1;
                    i=0;
                    while(ea > error)
                        i=i+1;
                        %Metodo de la secante 
                        c= b-(f(b)*(a-b)/(f(a)-f(b)));
                        % Error aproximado
                        ea  = abs((c-b)/c)*100;
                        %Imprimiendo la tabla
                        fprintf(' \t%i \t%.12f \t%.12f \t%.12f \t%.12f\n ',i,a,b,c,ea);
                        %Guardando las nuevas variables.x
                        a=b;
                        b=c;
                    end 
                    
        
        otherwise 
        disp('Something went wrong')
end
   
          otherwise 
        disp('Something went wrong')
end