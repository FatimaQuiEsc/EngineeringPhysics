% ***********************
% Regresión cuadrática
% 
% Q.E Fatima
% 19-oct-2020, DCI-UG
% ***********************

clc;
clear all;
fclose('all');
clf;
hold on;

%%Damos un mensaje de como funciona el codigo
fprintf('Gracias por utilizar nuestro programa, con el puedes calcular\n'),
fprintf('cualquier tipo de ajuste de datos a una curva a traves de regresion\n');
fprintf('lineal, cuadratica, cubica, etc\n');

q = input('Por favor ingresa el grado de ajuste que prefieras: ');
fprintf('Deseas ingresar los datos de forma manual o por un archivo .txt\n');
fprintf('1.- Manual.\n2.-Archivo.\n');
o = input('');

%%Se realiza la captura de los datos
if(o==1)
  fprintf('Ha seleccionado la opcion manual.\n')
  m = input('Ingrese por favor la cantidad de datos a capturar: ');
  fprintf('Ingrese por favor el vector columna X e Y: \n');
  for i=1 : m
    fprintf('x_%d = ',i);
    X(i,:) = input('');
    fprintf('y_%d = ',i);n
    Y(i,:) = input('');
  endfor
%Se realiza la lectura del archivo  

else
  fprintf('Ha seleccionado la opcion de archivo.');
  fprintf('Por favor asegurese de que el archivo extension .txt se\n');
  fprintf('encuentre en el mismo directorio que el archivo del programa.\n');
    m = input('Ingrese por favor la cantidad de datos a leer: ');
  s = input('Ingrese de favor el nombre con extension (.txt) del archivo: ','s');
  fopen(s,'r');
  
  for i = 1 : m
    z = fgets(s);
    v = [str2num(z)];
    X(i) = v(1,1);
    Y(i) = v(1,2);
  endfor
endif
plot(X,Y,'*',e,'b');




%%Se calcula la funcion
y = E = e = 0;
for i=0 : q
  y = y + (C(i+1,q+2)).*(X.^i);
endfor
fprintf('La funcion es de la forma: \n');
fprintf('y = ')
for i=q: -1 : 0
  if i-1 >= 0
    if C(i+1,q+2) ~= 0
      if i > 1
        fprintf('(%s)x^%d + ',num2str(C(i+1,q+2)),i);
      elseif i==1
        fprintf('(%s)x + ',num2str(C(i+1,q+2)));
      else
        fprintf('(%s) + ',num2str(C(i+1,q+2)));
      endif
    elseif C(i+1,q+2) == 1
      fprintf('x^%d + ',i);
    endif
  else
    if C(i+1,q+2)~=0
      if i > 1
        fprintf('(%s)x^%d',num2str(C(i+1,q+2)),i);
      elseif i==1
        fprintf('(%s)x',num2str(C(i+1,q+2)));
      else
        fprintf('(%s)',num2str(C(i+1,q+2)));
      endif
    elseif C(i+1,q+2) == 1
      fprintf('x^%d',i);
    endif
  endif  
endfor
fprintf('\n');  

%%Se calcula el error
E = sum((Y-y).^2);
e = sum(Y);
S = sum((Y-(e/m)).^2);
r = sqrt((S-E)/S);
Rc = r^2;

printf('\nLos valores de E y S son:\nE = %f\nS = %f\n',E,S);

printf('\nLos valores de r y R^2 son:\nr = %f\nR^2 = %f\n',r,Rc);

%%Se grafica la funcion ajustada
plot(X,y,'r','linewidth',1.5);
%xlabel('x');
%ylabel('y');
xlabel('tiempo (s)');
ylabel('desplazamiento (m)');
text(1,(90*ceil(max(Y)))/100,['r = ',num2str(r)]);
text(1,(85*ceil(max(Y)))/100,['R^2 = ',num2str(Rc)]);
axis([0,max(X)+.5,min(Y)-0.5, ceil(max(Y)+0.5)]);

if (o==2)
  fclose(s);
endif  
