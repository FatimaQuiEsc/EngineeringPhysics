% ***********************
% Tercer Examen Parcial código 2 de 3
% 
% Resolver la integral definida de un función, para el mismo intervalo y
% particiones dadas, mediante los métodos: trapecio compuesto, Simpson 1/3
% compuesto, Simpson 3/8 compuesto y la solución exacta.
%
% Q.E Fatima
% 06-dic-2020, DCI-UG
% ***********************

clc;
clearvars;

fprintf('\n    Resuelve la integral definida de una función \n \n');
uno_todos = menu('Elige una opcion','Comparar los métodos', 'Ejecutar un método en particular');
%Eliminamos la ventana de eleccion
clc
switch uno_todos 
%_____________________________________________________________
      case 1 %Todos los metodos
        fprintf('\n            COMPARAR LOS MÉTODOS \n \n');
        fprintf('Ingrese los siguientes datos: \n');
        f_str=input('f(x)=','s');
        f=str2func(['@(x)',f_str]);
        syms x;
        a=input('\nInserte el límite inferior a:');
        b=input('Inserte el límite superior b:');
        n=input('Inserte el número de particiones:');
        a_or=a;
        b_or=b;
        n_or=n;
        
        %1/3
        fprintf('\n      \t Por Simpson 1/3 compuesto \n');
       % EMPIEZA
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
            fprintf('La integral estimada es %f',I);
            
            a=a_or;
             b=b_or;
             n=n_or;
        
        fprintf('\n\n\t    Por Trapecio compuesto \n');
            
            c=n;
            h=(b-a)/c; 
              z=0; 
            for x=a:h:b
            k=eval(f_str);
            if x==a,d=k;
            end
            if x==b,e=k;
            end
            z=z+k;
            end 
              z=z-d-e; 
                z=z*2; 
                  z=z+d+e; 
                 z=z/(2*c); 
                  z=z*(b-a);
                  fprintf('La integral estimada es %f ', z);
             a=a_or;
             b=b_or;
             n=n_or;  
%             3/8
            fprintf('\n\n     \tPor Simpson 3/8 compuesto ');
            %Particiones
            h=(b-a)/(2*n);

            f0=0;
            for i=1:n-1
                x=a+h*(2*i);
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
            fprintf('\nLa integral estimada es %f \n',aprox);
            %Analitica
            syms x;
            f_sym=input('\n Vuelva a itroducir f(x)=');
            I_exa = int(f_sym, a,b);
            fprintf('\nLa integral exacta es %f',I_exa);
            
 %______________________________________________________________   
    case 2
         fprintf('\n\t   Primero es necesario que ingrese los siguientes datos: \n');
         f_str=input('\nf(x)=','s');
         f=str2func(['@(x)',f_str]);
         syms x;
         a=input('\nInserte el límite inferior a:');
         b=input('Inserte el límite superior b:');
         n=input('Inserte el número de particiones:');

        Unit = menu('Elige el método','Trapecio compuesto', 'Simpson 1/3 compuesto', 'Simpson compuesta 3/8', 'Exacta'); %pop up display

        %Eliminamos la ventana de eleccion
        clc

        switch Unit 
%....................................
              case 1 %Trapecio compuesto
            fprintf('\n\t   Trapecio compuesto \n\n');
            c=n;
            h=(b-a)/c; 
              z=0; 
            for x=a:h:b
            k=eval(f_str);
            if x==a,d=k;
            end
            if x==b,e=k;
            end
            z=z+k;
            end 
              z=z-d-e; 
                z=z*2; 
                  z=z+d+e; 
                 z=z/(2*c); 
                  z=z*(b-a);
                  fprintf('La integral estimada es %f ', z);
            %analitica
            syms x;
            fprintf('\n\nIntegral exacta');
            f_sym=input('\n Vuelva a itroducir f(x)=');
            I_exa = int(f_sym, a,b);
            fprintf('\nLa integral exacta es %f',I_exa)

%...............................................
            case 2 % Simpon 1/3
           % Descripcion del codigo
        fprintf('       Regla de Smpson compuesta 1/3   \n\n');
        fprintf('   Dada una funcion arbitraria f(x), en un intervalo [a, b]\n');
        fprintf(' y una particion n, estima la integral de la función \n\n');
        % EMPIEZA
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
            %analitica
            syms x;
            f_sym=input('\n Vuelva a itroducir f(x)=');
            I_exa = int(f_sym, a,b);
            fprintf('\nLa integral exacta es %f',I_exa);
            %FIN
%......................................................
            case 3 %Simpson compuesta 3/8
            % Descripcion del codigo
            fprintf('\n    \tRegla de Simpson compuesta 3/8   \n\n');
            fprintf('   Dada una funcion arbitraria f(x), en un intervalo [a, b]\n');
            fprintf(' y una particion n, estima la integral de la función \n\n');          
            %Particiones
            h=(b-a)/(2*n);
            f0=0;
            for i=1:n-1
                x=a+h*(2*i);
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
            fprintf('Aproximación a la integral=%f \n',aprox);
            
            syms x;
            f_sym=input('\n Vuelva a itroducir f(x)=');
            I_exa = int(f_sym, a,b);
            fprintf('\nLa integral exacta es %f\n',I_exa);
%...............................
            case 4 %integral exacta                
            fprintf('\n\t     Integral exacta   \n');
            syms x;
%           no es posible f=str2sym(f_str); en matlab 2017a :(
            f_sym=input('\n Ingrese la funcion f(x)=');
            I_exa = int(f_sym, a,b);
            fprintf('\nLa integral exacta es %f\n',I_exa);
            
              otherwise 
                disp('Something went wrong')
        end

otherwise 
        disp('Something went wrong')
end



