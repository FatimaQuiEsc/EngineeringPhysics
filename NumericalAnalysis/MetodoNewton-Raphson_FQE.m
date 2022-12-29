% ***********************
% Metodo Newton-Raphson
% 
% Q.E Fatima
% 02-sep-2020, DCI-UG
% ***********************

% Limpiamos
clc;
clear all;

% Descripcion del codigo
fprintf('         Metodos abiertos: Newton-Raphson \n\n');
fprintf('   Encuentra al menos una raiz de f(x)\n');
fprintf(' dado un punto inicial x0\n\n');

%aux 
syms x
n=10;
error=0.5*10^(2-n);

% Funcion
f_aux= input('Escribe una funcion=','s');
%combierte la cadena a funcion
f= str2func(['@(x)',f_aux]);

    d = diff(f);
%3 Se propone x
    Xo=input('\nInserte el valor de Xo:');
    

    
    xi = Xo - (f(Xo)/d(Xo));
   
    
      %5 Tabulación
     %Encabezado de la tabla
        fprintf('i \t\tX \t\txi+1 \t\tError \n')
  for i=1:500
        %Tabla
        
        %Evaluar función
         xi = Xo - (f(Xo)/d(Xo));
        
        
        %Error
        ea =((Xo-xi)/Xo)*100;
        if ea<0
            ea=ea*-1;
        end
       Xo = xi;
            fprintf('\n%i \t%f \t%f \t%f  \t%f\n',i,Xo,xi,ea)
        %Error
        if i>1
            if ea<error
               return
            end 
        end 
        Xo=g_xo;
end 
    
    
    
    


    
    
    