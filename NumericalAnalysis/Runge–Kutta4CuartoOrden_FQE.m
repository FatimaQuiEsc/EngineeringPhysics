% ***********************
% Runge–Kutta de cuarto orden (RK4)
% 
% Q.E Fatima
% 1-dic-2020, DCI-UG
% ***********************


clc;
clearvars;
clear all;
format short;

% Descripcion del codigo
fprintf('       Runge–Kutta de cuarto orden (RK4)    \n\n');
fprintf('  Dado cualquier PVI de una EDO, para un intervalo y h arbitrarios \n');
fprintf(' Encuentra iterativamente la solución de un problema de\n');
fprintf(' valor inicial (PVI) de una ecuación diferencial ordinaria.\n\n ');


%Función y punto a evaluar
f_aux= input('Inserte su función f(x,y)=','s');
f    = str2func(['@(x,y)',f_aux]); syms x; syms y;
x0=input('\nIngrese el primer punto:');
x1=input('\nIngrese el segundo punto:');
y0=input('\nIngrese la condicion inicial y(x)=');
n=input('\nIngrese el numero de pasos n (h=(b-a)/n): \n\n');
h=(x1-x0)/n;
    
    fprintf('\n\n');
    
    %Metodo 
    x_rk=zeros(1,n+1);
    y_rk=zeros(1,n+1);
    x_rk(1)=x0;
    y_rk(1)=y0;
    
    for i=1:n
        x_rk(i+1)=x_rk(i)+h;
    end
    for i=1:n
        k1   =(feval(f,x_rk(i),y_rk(i)))*h;
        k2   =(feval(f,x_rk(i)+(h/2),y_rk(i)+(k1/2)))*h;
        k3   =(feval(f,x_rk(i)+(h/2),y_rk(i)+(k2/2)))*h;
        k4   =(feval(f,x_rk(i)+h,y_rk(i)+k3))*h;
        y_rk(i+1)=y_rk(i)+(1/6)*(k1+2*k2+2*k3+k4);
     
    end
    plot(x_rk,y_rk,'-','LineWidth',2);
    hold on;
    
        
%Solucion analitica
    [ts,y_ex]   = ode45(f,x_rk,y0);
    edo         = [ts,y_ex];
    edo1        = [ts];
    edo2        = [y_ex];
    plot(x_rk,edo2,'cd','LineWidth',2);
    legend({'Metodo Euler','Solucion EDO'})
    hold on;
    
%Tabla
    fprintf('i           xi            yi      yi_ex\n');
    for i=1:n+1
       fprintf('%f   %f   %f  %f\n',i-1,x_rk(i),y_rk(i),edo2(i));
    end
    
    
% Campo vectorial
    xmax= max(abs(x0),abs(x1))*1.05;
    ymax= max(abs((max(y_rk))),abs((y0)))*1.2;
    dx= xmax/15.001;
    dy= ymax/15.002;
    [X,Y]= meshgrid(-xmax:dx:xmax, -ymax:dy:ymax);
    f_mesh= subs(f,[x,y],{X,Y});
    unos= ones(size(f_mesh));
    quiver(X,Y,unos,f_mesh,'MaxHeadSize',0.01);
    
    
    pause(10000);