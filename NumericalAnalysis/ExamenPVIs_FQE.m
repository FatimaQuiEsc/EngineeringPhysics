% ***********************
% Tercer Examen Parcial código 3 de 3
% 
% Resolver el PVI de una ecuación diferencial ordinaria, para el mismo
% intervalo y paso dado, a través de los métodos: Euler, RK2, RK4 y solución
% exacta.
%
% Q.E Fatima
% 06-dic-2020, DCI-UG
% ***********************

clc;
clearvars;

uno_todos = menu('Elige una opcion','Comparar los métodos', 'Ejecutar un método en particular');
%Eliminamos la ventana de eleccion
clc
switch uno_todos 
%___________________________________________________________________
      case 1
          fprintf('\n            COMPARAR LOS MÉTODOS \n \n');
          
       syms y(x) x 
f=input('Inserte su función f(x)=');
    x0    =input('Inserte el primer valor del intervlo:');
    x1    =input('Inserte el último valor del intervlo:');
    y0  =input('Inserte el valor de y evaluado en el punto a:');
    n    =input('Inserte el numero de particiones:');
    h=(x1-x0)/n;
    
    
    %Solucion analitica
eqn = diff(y,x) == f;
cond = y(x0) == y0;
ySol_(x) = dsolve(eqn,cond);

fprintf('La solución analitica es:\n');
ySol_(x)

f_aux= input('\nInserte su función f(x,y)=','s');
    f    = str2func(['@(x,y)',f_aux]); syms x; syms y;    
 fprintf('        Método de Euler    \n\n');
%Método de Euler
    x=zeros(1,n+1);
    y=zeros(1,n+1);
    x(1)=x0;
    y(1)=y0;
    for i=1:n
        y(i+1)=y(i)+h*feval(f,x(i),y(i));
        x(i+1)=x(i)+h;
    end
    plot(x,y,'-','LineWidth',2);
    hold on;
%Calculamos el valor de y con el procedimiento que ya sabemos
    [ts,y_ex] = ode45(f,x,y0);
    edo         = [ts,y_ex];
    edo1        = [ts];
    edo2        = [y_ex];
    plot(x,edo2,'cd','LineWidth',2);
    legend({'Método Euler','Solución EDO'})
    
%Tabulamos
fprintf('i\t\t\t\t X \t\t\t\tY \t\t\t\tY exacta\n');
for i=1:n+1
   fprintf('%f\t\t%f\t\t%f\t\t%f\n',i-1,x(i),y(i),edo2(i));
end

fprintf('\n\n');
  %RK4  
  fprintf('        Método de Runge–Kutta de cuarto orden (RK4)    \n\n');
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
     
     
    %RK2
    
    fprintf('\n        Método de Runge–Kutta de segundo orden (RK2)    \n\n');
     x=zeros(1,n+1);
    y=zeros(1,n+1);
    x(1)=x0;
    y(1)=y0;
    for i=1:n
        x(i+1)=x(i)+h;
    end
    for i=1:n
        k1   =(feval(f,x(i),y(i)))*h;
        k2   =(feval(f,x(i+1),y(i)+k1))*h;
        y(i+1)=y(i)+(0.5)*(k1+k2);
        x(i+1)=x(i)+h;
    end
    plot(x,y,'-','LineWidth',2);
    hold on;
%Calculamos el valor de y con el procedimiento que ya sabemos
    [ts,y_ex] = ode45(f,x,y0);
    edo         = [ts,y_ex];
    edo1        = [ts];
    edo2        = [y_ex];
    plot(x,edo2,'cd','LineWidth',2);
    legend({'Método RK2','Solución EDO'})
    
%Tabulamos
fprintf('i\t\t\t\t X \t\t\t\tY \t\t\t\tY exacta\n');
for i=1:n+1
   fprintf('%f\t\t%f\t\t%f\t\t%f \n',i-1,x(i),y(i),edo2(i));
end

 %____________________________________________________________________________        
    case 2
Unit = menu('Elige el método','Método de Euler', 'Runge–Kutta de segundo orden (RK2)', 'Runge–Kutta de cuarto orden (RK4)'); %pop up display
clc

        switch Unit %switich is the command, unit is the vaiable that we want to use
      case 1
          % Descripcion del codigo
fprintf('        Método de Euler    \n\n');
fprintf('  Dado cualquier PVI de una EDO, para un intervalo y h arbitrarios \n');
fprintf(' Encuentra iterativamente la solución de un problema de\n');
fprintf(' valor inicial (PVI) de una ecuación diferencial de primer orden.\n ');

syms y(x) x 
f=input('Inserte su función f(x)=');
    x0    =input('Inserte el primer valor del intervlo:');
    x1    =input('Inserte el último valor del intervlo:');
    y0  =input('Inserte el valor de y evaluado en el punto a:');
    n    =input('Inserte el numero de particiones:');
    h=(x1-x0)/n;

    %Solucion analitica
eqn = diff(y,x) == f;
cond = y(x0) == y0;
ySol_(x) = dsolve(eqn,cond);

fprintf('La solución analitica es:\n');
ySol_(x)

f_aux= input('\nInserte su función f(x,y)=','s');
    f    = str2func(['@(x,y)',f_aux]); syms x; syms y;    
    
%Método de Euler
    x=zeros(1,n+1);
    y=zeros(1,n+1);
    x(1)=x0;
    y(1)=y0;
    for i=1:n
        y(i+1)=y(i)+h*feval(f,x(i),y(i));
        x(i+1)=x(i)+h;
    end
    plot(x,y,'-','LineWidth',2);
    hold on;
%Calculamos el valor de y con el procedimiento que ya sabemos
    [ts,y_ex] = ode45(f,x,y0);
    edo         = [ts,y_ex];
    edo1        = [ts];
    edo2        = [y_ex];
    plot(x,edo2,'cd','LineWidth',2);
    legend({'Método Euler','Solución EDO'})
    
%Tabulamos
fprintf('i\t\t\t\t X    \t\t\tY \t\t\t  Y exacta\n');
for i=1:n+1
   fprintf('%f\t\t%f\t\t%f\t\t%f\n',i-1,x(i),y(i),edo2(i));
end


%.................................................
      case 2
        % Descripcion del codigo
fprintf('       Runge–Kutta de segundo orden (RK2)    \n\n');
fprintf('  Dado cualquier PVI de una EDO, para un intervalo y h arbitrarios \n');
fprintf(' Encuentra iterativamente la solución de un problema de\n');
fprintf(' valor inicial (PVI) de una ecuación diferencial ordinaria.\n ');

%Se piden los datos de la edo
syms y(x) x 
% f=input('Inserte su función f(x)=');
f_aux= input('Inserte su función f(x,y)=','s');
f    = str2func(['@(x,y)',f_aux]); syms x; syms y;
x0=input('\n Ingrese el primer punto x0: ');
x1=input(' Ingrese el segundo punto x1: ');
y0=input(' Ingrese la condicion inicial y(x0): ');
n=input(' Ingrese el numero de pasos n (h=(b-a)/n): ');
h=(x1-x0)/n;
xs=x0:h:x1;

x=zeros(1,n+1);
    y=zeros(1,n+1);
    x(1)=x0;
    y(1)=y0;
    for i=1:n
        x(i+1)=x(i)+h;
    end
    for i=1:n
        k1   =(feval(f,x(i),y(i)))*h;
        k2   =(feval(f,x(i+1),y(i)+k1))*h;
        y(i+1)=y(i)+(0.5)*(k1+k2);
        x(i+1)=x(i)+h;
    end
    plot(x,y,'-','LineWidth',2);
    hold on;
%Calculamos el valor de y con el procedimiento que ya sabemos
    [ts,y_ex] = ode45(f,x,y0);
    edo         = [ts,y_ex];
    edo1        = [ts];
    edo2        = [y_ex];
    plot(x,edo2,'cd','LineWidth',2);
    legend({'Método RK2','Solución EDO'})
    
%Tabulamos
fprintf('i\t\t\t\t X \t\t\t\tY \t\t\t\tY exacta\n');
for i=1:n+1
   fprintf('%f\t\t%f\t\t%f\t\t%f \n',i-1,x(i),y(i),edo2(i));
end

    
    
%..............................................................
      case 3                
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
    
%str2sym no esta definida en mi version de MATLAB
% Campo vectorial
    xmax= max(abs(x0),abs(x1))*1.05;
    ymax= max(abs((max(y_rk))),abs((y0)))*1.2;
    dx= xmax/15.001;
    dy= ymax/15.002;
    [X,Y]= meshgrid(-xmax:dx:xmax, -ymax:dy:ymax);
    f_mesh= subs(f,[x,y],{X,Y});
    unos= ones(size(f_mesh));
    quiver(X,Y,unos,f_mesh,'MaxHeadSize',0.01);
    
            
            otherwise 
        disp('Something went wrong')
end

otherwise 
        disp('Something went wrong')
end
