
// Horner's algorithm

// It deals with the factorization of a polynomial. 
// It is one of the most efficient ways to evaluate a polynomial.

#include <stdio.h>

int main()
{

    double coeff[] = {2,-5,10};
    double accum = coeff[0];
    double x = -3;
    int index = 1;

    do{
        accum = accum*x + coeff[index];
        index ++;
    } while(index <sizeof(coeff) / sizeof(double)); // Es una macro me sirve 
    //para saber el tamaño de un arreglo que ya esta declarado
    
    printf("%8.3lf", accum); //1234.123 tenemos 8 caracteres 3 decimales
    return 0;
}