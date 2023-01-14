
#include <stdio.h>

double HornerRule( double x, double *coeff , int nCoeff){
    
    double accum = coeff[0];
    int index = 1;

    do{
        accum = accum*x + coeff[index];
        index ++;
    } while(index < nCoeff); // Es una macro me sirve 
    //para saber el tamaño de un arreglo que ya esta declarado
    
    return accum;
    
}

int main(){
    


    double coeff[] = {2,-5, 10};
    
    double x = -3;
    int n = 100;
    
    do{
        printf("%8.3lf, %8.3lf\n", x, 
        HornerRule(x, coeff, sizeof(coeff) / sizeof(double)));
        x += 0.1;
        
    } while(-- n);
    
    return 0;
    
}