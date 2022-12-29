
% ***********************
% Regresión exponencial
% 
% Q.E Fatima
% 26-oct-2020, DCI-UG
% ***********************

clc;
clear all;

% Descripcion del codigo
fprintf('      Regresión exponencial   \n\n');
fprintf('   Cuando los datos a analizar presentan una posible tendencia exponencial, se propone la función y = be^ax \n\n');

%Obtencion de datos   
x = input('Ingrese los valores de x \n');
y = input('\nIngrese los valores de y \n');

sx = 0;
sx2 = 0;
lny = 0;
xlny = 0;
sy = 0;

for i=1 : length(x)
  sx = sx + x(i);               
  sx2 = sx2 + x(i)^2;             
  lny = lny + log(y(i));           
  xlny = xlny + x(i)*log(y(i));
  sy = sy + y(i);
end

a = (((length(x)*xlny)-sx*lny)/((length(x)*sx2)-sx^2));
b = (exp((1/length(x))*(lny-a*sx)));

E = 0;
S = 0;

for j=1 : length(x)
   E = E + ((y(j)-(b*exp(a*x(j))))^2);
   S = S + (y(j)-(1/length(x))*sy)^2;
   
end

r = sqrt((S-E)/S);
R2 = r*r;

fprintf('La forma de la funcion es:\ny = %f*exp(%fx) \n',b,a);
y = b*exp(a.*x);

fprintf('\nLos valores de r y R^2 son: %f %f\n', r, R2);
plot(y,'r','linewidth',1.5);
xlabel('x');
ylabel('y');


