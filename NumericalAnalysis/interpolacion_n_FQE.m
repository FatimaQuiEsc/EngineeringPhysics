
% ***********************
% Interpolación de grado n
% 
% Q.E Fatima
% 04-nov-2020, DCI-UG
% ***********************

clc;
clear all;
close all;
format long %formato 

% Descripcion del codigo
fprintf('       Interpolación de grado n   \n\n');
fprintf('   Arrojar la función analítica (forma canónica)\n');
fprintf(' y la gráfica de los puntos con la curva de ajuste. \n\n');

% Introducción de datos
xi=input('Ingrese los puntos x en forma de vector: ');
yi=input('Ingrese los puntos y en forma de vector: ');
n=length(xi);
x=sym('x'); %dejamos la variable  'x' como simbolica

% Ejes centrados en el origen
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin'; 

% Calculo de los limites de ventana
xmax = ceil(max(xi)/10)*10+2;
xmin = -xmax;
ymax = ceil(max(yi)/10)*10+2;
ymin = -ymax;

% Grafica de puntos
hold on;
set(gcf, 'WindowStyle','docked');
plot(xi,yi, 'bo');
axis([xmin xmax ymin ymax], 'square');
box off;

% Se calculan los productos superiores 
for j=1:n
    p=1;
    for i=1:j-1
        p=p*(x-xi(i)); 
    end
    p2=1;
    for i=j+1:n
        p2=p2*(x-xi(i));
    end
    p3=1;
    for i=1:j-1
        p3=p3*(xi(j)-xi(i));
    end
    p4=1;
    for i=j+1:n
        p4=p4*(xi(j)-xi(i)); 
    end
    %calculos de las L para hallar el polinomio
    L(j)=(p*p2)/(p3*p4); 
    fprintf('\n L%d:\n',j-1)                
    disp(L(j)) 
end


% Calculo del polinomio
pn=0;
for j=1:n
    pn=pn+L(j)*yi(j); 
end

   fprintf('\n La funcion de grado %d es: \n', n)
   disp(pn) 
   % Se simplifica la expresion
   fprintf('\n Simplificada: \n')
   pn = simplify(pn);   
    disp(pn)

% Funcion de su grafica
xx = xmin:1/100:xmax;
plot(xx, subs(pn, x, xx));
pause(10000);






