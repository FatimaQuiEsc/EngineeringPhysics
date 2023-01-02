#ifndef UINT
#define UINT unsigned int
#endif

void Variance(double sum_array[], double CovM[], double DatM[], UINT N, UINT M )
{
    
    // POINT
    double* sum_xPtr = sum_array;
    double* CovPtr = CovM;
    double* DatPtr = DatM;
    
    double sum_x, sum_x2;  
    
    int i = 0, k = 0;
    
    do {  
    
        sum_x = 0, sum_x2 = 0;    
    
            do {
                
                // Sums of x and x^2
                sum_x2 += *(DatPtr) * *(DatPtr);
                sum_x += *DatPtr;
                
                DatPtr ++;

                i++;
            
            } while(i<M);
    
        // The value of sum x is stored in an array
        *sum_xPtr = sum_x;
        sum_xPtr++;
        
        /*
        The variance is calculated and 
		these values are stored directly in the covariance matrix
        */
        *CovPtr = (M * (sum_x2) - (sum_x) * (sum_x)) / ( M*(M-1) );
        
        // The pointer is moved to have only the values of the diagonal
        CovPtr  = CovPtr + (N+1);
        
        k ++;
        i = 0;
    
    } while(k < N);
    
    
}

void Covariance(double sum_array[], double CovM[], double DatM[], UINT N, UINT M ){
    
    // POINT
    double* sum_xPtr = sum_array;
    double* CovPtr = CovM + 1;
    double* DatPtr = DatM;

    int i = 0, k = 0;
    
    do {
        
        do {
            
            *CovPtr = (M * DotProd(DatPtr,  (DatPtr + ((k+1)*M)), M) - 
            (*sum_xPtr)* *(sum_xPtr + (k+1)) ) / ( M*(M-1) );
            
            
            *(CovPtr + (k+1)*(N-1)) = *CovPtr;
            
            CovPtr ++;
            
            k ++;    
        
        
         } while( k < (N - 1) - i );

        DatPtr += M;

        CovPtr = CovPtr + (i+2);
        sum_xPtr ++;
        
        k = 0;
        i ++;
    } while( i < N-1);

}

UINT CondParo( double t1[], double t2[],UINT tam, double Error ){
	UINT i = tam, r, n =0;
	double* t1Ptr = t1;
  	double* t2Ptr = t2;
	double temp;
	do{
		temp = fabs( *t1Ptr - *t2Ptr );
		r = fabs( *t1Ptr++ - *t2Ptr++ ) <= Error ;
		n = n+r;
	} while (-- i && r != 0);
	return n;
}

void EigenVaLs(double MatrixCov[], UINT TamCov, double EiVal[],double eLes[], double Us[]){

	double* MatCov = MatrixCov;
	//double* V = eigVal;
	double* Ls = eLes;
	//double* Uptr = U;
	UINT TMCov[] = {TamCov, TamCov}; //{ren, col}
	double e = 0.00001;

	//double V[ TMCov[1]*TMCov[1] ], Ls[ TMCov[0] ];
	
	double Norm,Max ;
	double t1[TMCov[0]], t2[TMCov[0]];
	//double EiVal[ TMCov[0]*TMCov[1] ];
	//double Us[ TMCov[0]*TMCov[1] ];
	double nS[ TMCov[0]*TMCov[1] ];
	double nSTmp[ TMCov[0]*TMCov[1] ];
	double St[ TMCov[0] ];
	double EiValT[ TMCov[0]*TMCov[1] ];
	double tmp[TMCov[0]*TMCov[1]];
	double* EiValptr = EiVal;
	double* EiValTptr = EiValT;
	double* lPtr = Ls;
	double* u = Us;
	UINT TMts[] = {TMCov[0],1};
	UINT TMSt[] = {1,TMCov[0]};
	
	// ----------- Calculate eigenvalues ----------
	UINT i = 0;
	UINT j=1;

	MatrixEsc(  EiVal, TMCov, 0 );	
	MatrixDivEsc( MatCov, 1, TMCov[0]*TMCov[0], nS ); //nS = MatrixCov
	

	//St = sum(MatrixCov)'
	SumColMat( nS, TMCov , St ); 

	//t = ones( size(St) );
	MatrixEsc( t1,TMts, 1 ); 

	//t2 = St/max(St);
	Max = FindMax( St, TMCov[0]*TMCov[1] );
	MatrixDivEsc( St, Max, TMCov[0], t2 );
	UINT k = 0;
	do{
		k = 0;
		do{
			//t = t2
			MatrixDivEsc( t2, 1, TMCov[0], t1 ); 
			//St = nS*t;
			MatrixTimes( nS, TMCov, t1, TMts, St); 
			//t2 = St/max(St);
			Max = FindMax( St, TMCov[0]*TMCov[1] );
			MatrixDivEsc( St, Max, TMCov[0], t2 ); 
			k++;
			if (k == 1000) {
            break;
			}
		}while ( CondParo( t1, t2, TMCov[0], e ) != TMCov[0] );

		//u = t./sqrt( t' * t );
		Norm = NormVec( t1, TMCov[0]); 
		MatrixDivEsc( t1, Norm, TMts[0], u );

		// l(i,i) = max(St)
        *lPtr++ = Max;

		//eigenval(:,i) = sqrt( max(St) ) * u;
		MatrixDivEsc( u, 1/sqrt(Max), TMCov[0], EiValptr ); 


		//nS = nS - eigenval(:,i)*eigenval(:,i)';
		TMatrix( TMSt, EiValptr, EiValTptr );
		MatrixTimes( EiValptr, TMts, EiValTptr, TMSt, tmp);
		MatrixSubs( nS, tmp, TMCov, nSTmp );
		MatrixDivEsc( nSTmp, 1, TMCov[0]*TMCov[0], nS );

		//St = sum(nS)';
		SumColMat( nS, TMCov , St ); 

		//t = ones( size(St) );
		MatrixEsc( t1,TMts, 1 );
		Max = FindMax( St, TMCov[0]*TMCov[1] );

		//t2 = St/max(St);
		MatrixDivEsc( St, Max, TMCov[0], t2 );
		EiValptr += TMCov[0];
		EiValTptr += TMCov[0];
		u += TMCov[0];
		j++;
		i++;
	}while(i<TMCov[0]);
	k = 1;
	
}

void CalcUs(double uVs[],UINT tam, double eLs[], double Us[]){
	double* V = uVs;
	double* l = eLs;
	double* U = Us;
	double sqtmp;
	
	int i = 0, j = 0, c =0;
	do{
		do
		{
			sqtmp = sqrt(l[j]);
			U[c] = V[c] / sqtmp;
			j++;
			c++;
		} while (j < tam );
		l = eLs;
		i++;
		j = 0;
	}while (i < tam);
}



void MRXp(double Xs[], double Sum_x[], double xSubsxprom[], UINT N, UINT M ){
    double* XsPtr = Xs;
    double* Sx = Sum_x ;
    double* xNew = xSubsxprom;
    double PromTmp;
    double Ren = M;

    int i = 0, j =0, c=0;
    
    do{
        PromTmp = Sx[j]*(1/Ren);
        i = 0;
        do{
            xNew[c] = XsPtr[c] - PromTmp;
            i++; c++;
        }while ( i < M );
        j++;
        
    }while ( j < N );
    
}



