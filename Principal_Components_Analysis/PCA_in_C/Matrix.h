#ifndef UINT
#define UINT unsigned int
#endif

#define PI 3.14159265358979323846

void ShowMatrix( int tam[], double array[] ){
    //Tam must be [Col Renglon]
	int i = 0, c = 0;
	do{
	   	int j = 0;
		do{
			printf( "%1.3lf\t", array[c] );
			c++;
		}while ( ++j < tam[1] );
		printf( "\n ");
	} while( ++i < tam[0] );
} 

void TMatrix( int tam[] , double array[], double vectorTrnsp[] ){
	UINT n = tam[0];
	UINT m = tam[1];
	double* VecTPtr = vectorTrnsp;
	double* arrPtr = array;

	int i = 0, j = 0;
	do {
    	do {
        
	       	*VecTPtr = *arrPtr;
    	    VecTPtr++; 
        	arrPtr += m;
      		j ++;
    	} while (j<n);   
    arrPtr = array+(i+1);
    j = 0;
    i ++;
  	} while (i<m);

}


double DotProd(double x[], double y[], int n){
	double* xPtr = x;
	double* yPtr = y;
    
    double sum = 0;
    int i=0;
    
	do {
		sum += *( xPtr++ ) * *(yPtr ++ );
        i ++;
    } while (i<n);
    
    return sum;
}

double FindMax( double array[], double tam ) { 
	int i=0;
	double num = array[i];
	i++;
	do{
		if( num < array[i] ){
			num = array[i] ;
		}
		i++;
	}while(i < tam);
	return num;
}

void MatrixTimes( double Matrix1[], UINT size1[],
double Matrix2[], UINT size2[], double result[] ) {
	// M1 = M*N ; M2 = N*P

  	double* m1Ptr = Matrix1;
  	double* m2Ptr = Matrix2;

  	double VTemp[ size2[0] ];
  	double* tmpPtr = VTemp;
    
  	int i = 0, j = 0, k = 0;
    
  	double* rPtr = result;
    
  	do {
        
      	do {
            
          	tmpPtr = VTemp;
          	Matrix2;
          	j = 0;
           
          	do {
              	*tmpPtr = *(m2Ptr + i + j*size2[1]);
              	tmpPtr ++;
    	        j ++;
            } while ( j<size2[0] );
            
        tmpPtr = VTemp;

        *rPtr = DotProd(m1Ptr, tmpPtr, size1[1]);
        rPtr ++;
            
        i ++;
            
      } while(i<size2[1]);
      i = 0;
      k ++;
      m1Ptr = m1Ptr + size2[0];
    
  } while(k<size1[0]);

}

void MatrixSubs( double Matrix1[], double Matrix2[], 
UINT size[], double result[] ) { 
	double* m1Ptr = Matrix1;
  	double* m2Ptr = Matrix2;
	double* rPtr = result;	 
	UINT tam = size[0]*size[1];
	int i = 0;
	do{  // Scroll Matrix Rows 1
		*rPtr++ = *m1Ptr++ - *m2Ptr++;
		i++;
	}while(i < tam ); 
}

void MatrixDivEsc( double Matrix1[], double Escalar, 
UINT size1, double result[] ) { 	 
	UINT i = 0;
	do{  // Scroll Matrix Rows 1
		*result++ = *Matrix1++ / Escalar;
		i++;
	}while(i < size1); 
}

void MatrixMulEsc( double Matrix1[], double Escalar, 
UINT size1[], double result[] ) { 	 
	UINT tam = size1[0]*size1[1];
	int i = 0;
	do{  // Scroll Matrix Rows 1
		result[i] = Matrix1[i] * Escalar;
		i++;
	}while(i < tam ); 
}

void MatrixEsc( double Ones[], UINT size[], UINT ESC ) { 	 
	UINT tam = size[0]*size[1];
	double* onPtr = Ones;
	UINT i = 0;
	do{
		*onPtr = ESC; 
		*onPtr++;
		i++;
	}while( i < tam ); 
}


double NormVec( double vec[], UINT tam ) { 	 

	double x = DotProd(vec, vec, tam);
	
	return sqrt( x );
}

void SumColMat( double array[], UINT tam[] , double Res[] ){
	UINT* tm = tam;
	double *arPtr = array;

	int i = 0, j = 0, c = 0;
	do{
		Res[c] = 0;
		do
		{
			Res[c]  += array[i];
			i += tam[1]; 
			j++;
		
		} while (j < tam[0] );
		j = 0; 
		c++;
		i = c;
	}while (c < tam[1]);
}


void linspace(double bgn, double end, UINT NumTotPoints, double result[]){
    double* Res = result;
    double Delta= (end-bgn)/(NumTotPoints-1);
    *Res++ = bgn;
	UINT i=1;
    do{
        *Res =  *(Res-1) + Delta;
		Res++;
        i++;
    }while (i < NumTotPoints);

}

void CalcElip(double tlsp[], UINT TamTlsp, double MC[], UINT tamMCOV, double L[], double ResultX[]){
    double* t = tlsp;
    double* ResX = ResultX;
    double M1 = MC[0];
    double M2 = MC[tamMCOV+1];
    UINT i = 0;
    do{
        ResX[i] = 2 * cos(t[i]) * M1* sqrt( 5.991*(L[0]) );
        ResX[i+TamTlsp] = 2 * sin(t[i]) * M2* sqrt( 5.991*(L[1]) );
        i++;
    }while(i < TamTlsp);
}

void ElipseRotTras(UINT TMDAT, UINT TMCov,double MatrixCov[], double Ls[], double Us[] , double Sxx[], double Elipse[], UINT StpElip ){
    // TMCOV is the number of columns
    UINT TamCov[] = {TMCov, TMCov};
    UINT TMtot = TMDAT; //Number of rows in the data
    double t[StpElip];
    double Elip[StpElip*2]; 
    double ElipRot[StpElip*2];
    double* MatCov = MatrixCov;
    double* eLs = Ls;
    double* U = Us;

    linspace(0, 2*PI, StpElip, t);
    CalcElip(t, StpElip, MatCov, TMCov, eLs, Elip); // Returns [x, y] as a matrix of [2 ren, 51 col]
    UINT TMElip[] = {TMCov, StpElip};

    /* Rotate Ellipse */
    MatrixTimes( U, TamCov, Elip, TMElip, ElipRot );

    /* Translate ellipse */
    double PromTmp;
    double* SxxPtr = Sxx;
    double* ElipPtr = Elipse;
    double* ElRotPtr = ElipRot;
    UINT j =0, i =0;

    do{
        PromTmp = *SxxPtr/TMtot;
        do
        {
            *ElipPtr++ = *ElRotPtr + PromTmp;
            *ElRotPtr++;
            i++;
        } while (i < StpElip);
        SxxPtr++;
        j++;
        i = 0;
    }while (j < 2);

}

void CalcElipZ(double tlsp[], UINT TamTlsp, double L[], double ResultX[]){
    double* t = tlsp;
    double* ResX = ResultX;
    UINT i = 0;
    do{
        ResX[i] = cos(t[i]) *  sqrt( 8.187*(L[0]) );
        ResX[i+TamTlsp] = sin(t[i]) * sqrt( 8.187*(L[1]) );
        i++;
    }while(i < TamTlsp);
}

void ElipseRotTrasZ(UINT TMDAT, UINT TMCov, double Ls[], double Us[] , double Sxx[], double Elipse[], UINT StpElip ){
   
    UINT TamCov[] = {TMCov, TMCov};
    UINT TMtot = TMDAT; 
    double t[StpElip];
    double Elip[StpElip*2]; 
    double ElipRot[StpElip*2];
    double* eLs = Ls;
    double* U = Us;

    linspace(0, 2*PI, StpElip, t);
    CalcElipZ(t, StpElip, eLs, Elip);
    UINT TMElip[] = {TMCov, StpElip};

    MatrixTimes( U, TamCov, Elip, TMElip, ElipRot );


    double PromTmp;
    double* SxxPtr = Sxx;
    double* ElipPtr = Elipse;
    double* ElRotPtr = ElipRot;
	
    UINT j =0, i =0;

    do{
        PromTmp = *SxxPtr/TMtot;
        do
        {
            *ElipPtr++ = *ElRotPtr + PromTmp;
            *ElRotPtr++;
            i++;
        } while (i < StpElip);
        SxxPtr++;
        j++;
        i = 0;
    }while (j < 2);

}


