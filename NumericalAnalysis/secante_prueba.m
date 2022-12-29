
fx=0;
fx(1)=input('Ingrese el intervalo inferior: ');
fx(2)=input('Ingrese el intervalo superior: ');
tol=input('Ingrese el porcentaje de error: ');
syms x;
f=input('Ingrese la funciòn: ');
 
f1=subs(f,x,fx(1));
f2=subs(f,x,fx(2));
 
ea(1)=100;
 
i=1;
j=2;

 
while abs(ea(i))>=tol
   xf(j+1)=(xf(j-1)*f2-xf(j)*f1)/(f2-f1);  f1=f2; f2=subs(f,x,xf(j+1));
   ea(i+1)=(xf(j+1)-xf(j))/xf(j+1)*100;
   j=j+1;
   i=i+1;     
end
 
fprintf(' i     xf(i)         Error aprox (i) \n');
%fprintf('%2d\t%11.7f\t\n',0,x(1));
for k=2:j;
    fprintf('%2d\t%11.7f\t%7.3f\n',k-1,xf(k),ea(k-1));
end