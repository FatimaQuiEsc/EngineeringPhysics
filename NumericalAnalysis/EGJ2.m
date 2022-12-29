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
A=input('Ingrese la matriz A = \n');
% Columna de terminos independientes
b=input('\nIngrese el vector b, de terminos independientes b=\n');

%obtener el tamaño de la matriz A
[n,m]=size(A);
%matriz aumentada [Ab]
C=[A,b];

fprintf('\nLa Matriz aumentada [Ab] es = \n');
disp(C); %imprimir 



%Eliminacion hacia adelante 
%comienzan a hacerse ceros los elementos que estan debajo de la diagonal
%principal
for k=1:n
    for n= m+1:n
        C(n,:)=C(n,:)+C(m,:)*(-C(n,m)/C(n,m)); %formula, toma toda la fila, toma el valor que ya tiene y lo multiplica por una constante que lo haga cero  
    end
end

fprintf(C);
pause