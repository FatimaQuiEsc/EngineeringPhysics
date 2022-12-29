% ***********************
% Método de Cramer
% 
% Q.E Fatima
% 09-oct-2020, DCI-UG
% ***********************

clc;
clear all;
format rat %formato de fracciones


% Descripcion del codigo
fprintf('       Método de Cramer   \n\n');
fprintf('   Resuelve sistemas de ecuaciones n x n \n\n');


%Matriz  
A=input('Ingrese la matriz A = \n');
% Columna de terminos independientes
b=input('\nIngrese el vector b, de terminos independientes b=\n');


%obtener el tamaño de la matriz A
[n,m]=size(A);
%matriz aumentada [Ab]
a=[A,b];
n=length(b);
x=zeros(n,1);

fprintf('\nLa Matriz aumentada [Ab] es = \n');
disp(a); %imprimir 


for i=1:n
    Ab=[A(:,1:i-1),b,A(:,i+1:n)];
    %Se calcula la incognita
    x(i)=deter(Ab)/deter(A);
    
end
disp('Solución')
disp(x);

%Se crea la funcion para otener el determinante
function dd=deter(C)
n=1:size(C,1);
for k=1:size(C,1)
    if size(C,1)==1
        dd=C;
    else
        f=n(n~=1);
        c=n(n~=k);
        dd(k)=((-1)^(1+k))*C(1,k)*deter(C(f,c));
        dd=sum(dd);
        
    end
end
end
