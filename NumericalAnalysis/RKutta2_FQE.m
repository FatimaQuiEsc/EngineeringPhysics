% ***********************
% Runge–Kutta de segundo orden (RK2)
% 
% Q.E Fatima
% 30-nov-2020, DCI-UG
% ***********************

clc;
clearvars;

% Descripcion del codigo
fprintf('       Runge–Kutta de segundo orden (RK2)    \n\n');
fprintf('  Dado cualquier PVI de una EDO, para un intervalo y h arbitrarios \n');
fprintf(' Encuentra iterativamente la solución de un problema de\n');
fprintf(' valor inicial (PVI) de una ecuación diferencial ordinaria.\n ');

%Se piden los datos de la edo
syms y(x) x 
f=input('Inserte su función f(x)=');
x0=input('\n Ingrese el primer punto x0:\n');
x1=input('\n Ingrese el segundo punto x1:\n');
y0=input('\n Ingrese la condicion inicial y(x0):\n');
n=input('\nIngrese el numero de pasos n (h=(b-a)/n): \n\n');
h=(x1-x0)/n;
xs=x0:h:x1;


%Solucion analitica
eqn = diff(y,x) == f;
cond = y(x0) == y0;
ySol_(x) = dsolve(eqn,cond);

fprintf('La solución analitica es:\n');
ySol_(x)

%Tuve problemas con la funcion y dsolve. Lo unico que me funcionó 
% fue volver a pedirla al usuario con formato diferente 
f=input('Inserte su función f(x)=', 's');


%tabla
fprintf('          Tabla de datos\n')
fprintf('  i      xi       yi      ya  \n');
for i=1:n+1
    it=i-1;
    x0=xs(i);
    x=x0;
    y=y0;
    k1=h*eval(f);
    x=xs(i);
    y=y0+k1;
    k2=h*eval(f);
    y0=y0+(k1+k2)/2;
    ya=eval(ySol_(x));
    
    fprintf('\n%f %f  %f  %f\n',it,x0,y0, ya);
end
fprintf('\n El punto aproximado y(x1) es = %8.6f\n',y0);


T=(x0:h:x1);
%%Se grafica 
plot(it,y0, '--0',x0,ya,'r-','linewidth',1.5);
grid
xlabel('tiempo (s)');
ylabel('desplazamiento (m)');


pause(1000);



% ***********************
% Runge–Kutta de segundo orden (RK2)
% 
% Q.E Fatima
% 30-nov-2020, DCI-UG
% ***********************

clc;
clearvars;
clear all;
format short;

% Descripcion del codigo
fprintf('       Runge–Kutta de cuarto orden (RK4)    \n\n');
fprintf('  Dado cualquier PVI de una EDO, para un intervalo y h arbitrarios \n');
fprintf(' Encuentra iterativamente la solución de un problema de\n');
fprintf(' valor inicial (PVI) de una ecuación diferencial ordinaria.\n ');

%Se piden los datos de la edo
    f_aux= input('Inserte su funciÃ³n f(x,y)=','s');
    f    = str2func(['@(x,y)',f_aux]); syms x; syms y;
    a    =input('Inserte el primer valor del intervlo:');
    b    =input('Inserte el Ãºltimo valor del intervlo:');
    y_o  =input('Inserte el valor de y evaluado en el punto a:');
    n    =input('Inserte el numero de particiones:');
    h    =input('Inserte el paso del mÃ©todo:');

    
        kk1   =(feval(f,a,y_o))*h
        kk2   =(feval(f,a+(h/2),y_o+(kk1/2)))*h
        kk3   =(feval(f,a+(h/2),y_o+(kk2/2)))*h
        kk4   =(feval(f,a+h,y_o+kk3))*h
        y_rkv=y_o+(1/6)*(kk1+2*kk2+2*kk3+kk4)
    
    %MÃ©todo de Runge Kutta
    x_rk=zeros(1,n+1);
    y_rk=zeros(1,n+1);
    x_rk(1)=a;
    y_rk(1)=y_o;
    
    
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
    
        
    
%SoluciÃ³n nalÃ­tica de Edo
    [ts,y_ex]   = ode45(f,x_rk,y_o);
    edo         = [ts,y_ex];
    edo1        = [ts];
    edo2        = [y_ex];
    plot(x_rk,edo2,'cd','LineWidth',2);
    legend({'MÃ©todo Euler','SoluciÃ³n EDO'})
    hold on;
    
%Tabulamos
    fprintf('i\t\t\t\t X \t\t\t\tY \t\t\t\tY exacta\n');
    for i=1:n+1
       fprintf('%f\t\t%f\t\t%f\t\t%f\n',i-1,x_rk(i),y_rk(i),edo2(i));
    end
    
    
% Campo vectorial
    xmax= max(abs(a),abs(b))*1.05;
    ymax= max(abs((max(y_rk))),abs((y_o)))*1.2;
    dx= xmax/15.001;
    dy= ymax/15.002;
    [X,Y]= meshgrid(-xmax:dx:xmax, -ymax:dy:ymax);
    f_mesh= subs(f,[x,y],{X,Y});
    unos= ones(size(f_mesh));
    quiver(X,Y,unos,f_mesh,'MaxHeadSize',0.01);
    
    pause(10000);


