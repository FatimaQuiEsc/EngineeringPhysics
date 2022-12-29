% ***********************
% Metodo del punto fijo
% 
% Q.E Fatima
% 02-sep-2020, DCI-UG
% ***********************

% Limpiamos
clc;
clear all;

% Descripcion del codigo
fprintf('         Metodos abiertos: Punto fijo \n\n');
fprintf('   Encuentra al menos una raiz de f(x)\n');
fprintf('dado un punto inicial x0, rescribiendo f(x) \nde la forma x=g(x)\n\n');

% x = intup(abc)    x= str2...(abc)

%aux 
n=10;
error=0.5*10^(2-n);

%1 Se ubica la función del problema
    g_aux=input('Inserte su función g(x)=:','s');
    g=str2func(['@(x)',g_aux]);
            
% Convergencia de g(x)
    syms x
    g_d = diff((g_aux),x);
    
%3 Se propone x
    Xo=input('\nInserte el valor de Xo:');
    
%4 Evaluamos la función
    g_ev=subs(g_d,x,Xo);
    %Evaluamos para ver si converge
    while abs(g_ev)>=1
        fprintf('\nError de convergencia.\n')
        %Inserta función nuevamente
             g_aux=input('Inserte su función g(x)=:','s');
                %convierte la cadena a funcion
                    g=str2func(['@(x)',g_aux]);
        %Se saca la derivada
            syms x
            g_d = diff((g_aux),x);
        %Evaluamos la función
            g_ev=subs(g_d,x,Xo);
    end 
    
  %5 Tabulación
     %Encabezado de la tabla
        fprintf('i \t\tX \t\tg(x) \t\tError \n')
  for i=1:500
        %Tabla
        
        %Evaluar función
         g_x = subs(g,x,Xo);
         g_xo= double(g_x);
         
        %Error
        ea =((Xo-g_xo)/Xo)*100;
        if ea<0
            ea=ea*-1;
        end
      
            fprintf('\n%i \t%f \t%f \t%f  \t%f\n',i,Xo,g_xo,ea)
        %Error
        if i>1
            if ea<error
               return
            end 
        end 
        Xo=g_xo;
end 