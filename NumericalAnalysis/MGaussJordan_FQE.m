
% *****************************
% Eliminacion Gauss Jordan
% 
% Q.E Fatima
% 02-oct-2020, DCI-UG
% *****************************

clc;
clear all;
format rat %formato de fracciones

% Descripcion del codigo
fprintf('       Eliminación Gauss Jordan   \n\n');
fprintf('   Resuelve sistemas de ecuaciones n x n \n\n');

%Matriz  
A=input('Ingrese la matriz A = \n Escribiendola en la forma (a1, a2, a3; b1, b2 ...)');
% Columna de terminos independientes
b=input('\nIngrese el vector b, de terminos independientes b=\n');


%obtener el tamaño de la matriz A
[n,m]=size(A);
%matriz aumentada [Ab]
C=[A,b];


fprintf('\nLa Matriz aumentada [Ab] es = \n');
disp(C); %imprimir 

if n==m 
    for k=1:(n-1)
        
         fprintf('\n Matriz %g=\n\n',k)
         fprintf('\nLa matriz antes del proceso:\n')
         disp(C)
         fprintf('\n Multiplicadores:\n')
         
        for i=(k+1):n
            m(i,k)=C(i,k)/C(k,k); %formula para multiplicadores
            fprintf('\nm(%g,%g)=',i,k)
            disp(m(i,k));
            for j=k:(n+1)
                C(i,j)= C(i,j) - m(i,k)*C(k,j); %formula de la nueva fila
            end
        end
        fprintf('\nMatriz despues del proceso:\n')
         disp(C)
    end
    for i=n:-1:1
        suma=0;
        for p=(i+1):n
            suma = suma + C(i,p)*X(p);
        end
        X(i)=(C(i,n+1)-suma)/C(i,i);
        %formula de la susticion regresiva y solucion de las variables
    end
else 
    fprintf('\nERROR: La matriz NO es cuadrada\n');
    
end

fprintf('\n\nMatriz final:\n');
disp(C)
fprintf('\n\nSolucion de las variables:\n');
%Muestra resultados de una manera mas ordena
for i=1:n
    Xi=X(1,i);
    fprintf('\nx%g=',i)
    disp(Xi);
end
pause(1000);