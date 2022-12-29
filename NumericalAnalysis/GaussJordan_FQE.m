
% ***********************
% Eliminacion Gauss Jordan
% 
% Q.E Fatima
% 07-oct-2020, DCI-UG
% ***********************

clc;
clear all;
format rat %formato de fracciones


% Descripcion del codigo
fprintf('       Eliminación Gaussiana   \n\n');
fprintf('   Resuelve sistemas de ecuaciones 4 x 3 \n\n');


%Matriz  
AA=input('Ingrese la matriz AA = \n');
% Columna de terminos independientes
b=input('\nIngrese el vector b, de terminos independientes b=\n');


%obtener el tamaño de la matriz A
[n,m]=size(AA);
%matriz aumentada [Ab]
a=[AA,b];


fprintf('\nLa Matriz aumentada [Ab] es = \n');
disp(a); %imprimir 

co=4;
fi=3;

pause
for i=1:co-1      
    
    a(i,:)=a(i,:)/a(i,i);
    
    for j=i+1:fi
    a(j,:)=a(j,:)-a(i,:)*a(j,i);
    j=j+1;
    
%     pause
    end
  i=i+1;
  a  

end 
for i=fi:-1:2
  for j=i-1:-1:1
    a(j,:)=a(j,:)-a(i,:)*a(j,i);
    j=j-1;
    a

  end
  i=i-1;

end

    
        
    