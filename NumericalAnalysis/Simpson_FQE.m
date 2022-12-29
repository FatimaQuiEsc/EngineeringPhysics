% ***********************
% Regla de Smpson compuesta 1/3
% 
% Q.E Fatima
% 18-nov-2020, DCI-UG
% ***********************

clc;
clearvars;

% Descripcion del codigo
fprintf('       Regla de Smpson compuesta 1/3   \n\n');
fprintf('   Da una funcion arbitraria f(x), en un intervalo [a, b]\n');
fprintf(' y una particion n, estima la integral de la función \n\n');

%Función e intervalos
f_aux=input('Inserte su función f(x)=','s');
f=str2func(['@(x)',f_aux]);
syms x;
a=input('\nInserte el límite inferior a:');
b=input('\nInserte el límite superior b:');
n=input('\nInserte el número de particiones:');
    

h=(b-a)/n;
Int(1)=a;
    
%Particiones
    for i=2:n+1
        Int(i)=Int(i-1)+h;
    end 

Sum_1 = 0;
Sum_2 = 0;
Sus_par = 0;
Sus_imp = 0;

 %Sustitucion
        for i=2:n 
            if mod(i,2)==0
                Sus_par(i)=subs(f,x,Int(i));
            else
                Sus_imp(i)=subs(f,x,Int(i));
            end 
        end
        %Sumas
        for i=2:n
           Sum_1= Sus_par(i)+Sum_1;
           Sum_2= Sus_imp(i-1)+Sum_2; 
        end 
        
    %Integral estimada 
    X_1=subs(f,x,Int(1));
    X_1=double(X_1);
    X_n1=subs(f,x,Int(n+1));
    X_n1=double(X_n1);
    I=((b-a)/(3*n))*(X_1+4*Sum_1+2*Sum_2+X_n1);
    fprintf('\nLa integral estimada es %f',I);
    
    %FIN