#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include "DispError.h"
#include "OpenFile.h"
#include "Matrix.h"
#include "Statistics.h"

#define PI 3.14159265358979323846

#ifndef UINT
#define UINT unsigned int
#endif
 

// Command line handling
int main( int nArg, char* argumentos[] ) {

  UINT header;
  UINT error = ReadCommandLine( nArg, argumentos, &header );
  
  if( !error ) {
	double* VectorM; 
	int nCol, nRow;
	int ErCSV = ReadCSV(argumentos[1], &VectorM, &nCol, &nRow, header);
	 if ( !ErCSV){
		double DatM[50000];
		UINT TMDAT[] = {nRow,nCol};
		UINT TMDatT[] = {nCol,nRow};
		//printf("\n");
		//printf("DatosST: \n");
		//ShowMatrix(TMDAT,VectorM);
		//printf("\n\n");
		//printf("\n");
		//printf("Datos: \n");
		TMatrix( TMDAT, VectorM, DatM );
		//ShowMatrix(TMDatT,DatM);
		//printf("\n\n");

		
		UINT TMCov[] = {TMDAT[1],TMDAT[1]}; //{ren, col}
		UINT TMts[] = {TMDAT[1],1};
		
		double Vs[TMCov[0]*TMCov[1]];
		double eLs[ TMCov[0] ]; 
		double U[TMCov[0]*TMCov[1]];
		double UT[TMCov[0]*TMCov[1]];
		double MatCov[TMDAT[1]*TMDAT[1]  ]; 
		double Sxx[ TMDAT[1] ] ;
		double xSXpTmp[ TMDAT[0]*TMDAT[1] ] ;
		double xSubX[ TMDAT[0]*TMDAT[1] ] ;
		double z[ TMDAT[0]*TMDAT[1] ];
		double zT[ TMDAT[0]*TMDAT[1] ];
		UINT StpElip = 61;
		UINT TMElip[] = {2, StpElip};
		double Elip[StpElip*2];
    

		// Calculate covariance
		// [ncol], [nRow]
		Variance( Sxx, MatCov, DatM, TMDAT[1], TMDAT[0] );

		Covariance( Sxx, MatCov, DatM ,  TMDAT[1], TMDAT[0]  );
		printf("Matrix Cov: \n");
		ShowMatrix( TMCov, MatCov );
		printf("\n\n");

		
		/* -------- Calculate SVD ---------- */
		//PowerMethod(MatCov, U, eLs, TMCov[0]);
		EigenVaLs(MatCov, TMCov[0], Vs, eLs, UT); //Calcula *L* y *V*
		printf("L: \n");
		ShowMatrix( TMts, eLs );
		printf("\n\n");
		//printf("U: \n");
		//ShowMatrix( TMCov, U );
		//printf("\n\n");
		
		TMatrix( TMCov , UT, U );
		printf("U: \n");
		ShowMatrix( TMCov, U );
		printf("\n\n");
		
    
	
		// Calculate *z*
		MRXp(DatM, Sxx, xSXpTmp, TMDAT[1], TMDAT[0]  );
		TMatrix( TMDatT , xSXpTmp,  xSubX);
		MatrixTimes( xSubX, TMDAT, U, TMCov, zT ); 
		TMatrix( TMDAT , zT,  z);
		/*printf("z: \n");
		ShowMatrix( TMDatT, z );
		printf("\n\n");*/


		//double* Zap[] = { z, z + nRow}; 
		UINT TMZap[] = {nRow, 2};
		UINT TMCovZ[] = {2, 2};
		UINT TMtsZ[] = {2,1};

		double VsZ[TMCovZ[0]*TMCovZ[1]];
		double eLsZ[ TMCovZ[0] ]; 
		double UZ[TMCovZ[0]*TMCovZ[1]];
		double UTZ[TMCovZ[0]*TMCovZ[1]];
		double MatCovZ[TMZap[1]*TMZap[1]  ]; 
		double SxxZ[ TMZap[1] ] ;

		//Calculate Covariance
		// [ncol], [nRow]
		Variance(SxxZ, MatCovZ, z, TMZap[1], TMZap[0] );
		Covariance(SxxZ, MatCovZ, z ,  TMZap[1], TMZap[0]  );
		MatCovZ[1] = 0; MatCovZ[2] = 0;
/*
		printf("\n\n");
		printf("\n\n");
		printf("Matrix Cov Z comp: \n");
		ShowMatrix( TMCovZ, MatCovZ );
		printf("\n\n"); */

		/* --------- Calculate SVD for Z --------- */
		EigenVaLs(MatCovZ, TMCovZ[0], VsZ, eLsZ, UTZ); //Calculate *L* y *V*
		//printf("U: \n");
		//ShowMatrix( TMCov, U );
		//printf("\n\n");
		TMatrix( TMCovZ , UTZ, UZ );

		// --------- Calcular Elipse de confianza ------------ 
		ElipseRotTrasZ(TMZap[0], TMZap[1], eLsZ, UZ , SxxZ, Elip, StpElip );
		printf("Elipse: \n");
    	ShowMatrix( TMElip, Elip );

		/*
		
		// ---------- Calcular Elipse de confianza ------------  
    	ElipseRotTras(TMDAT[0], TMDAT[1], MatCov, eLs, U , Sxx, Elip, StpElip  );
		printf("Elipse: \n");
    	ShowMatrix( TMElip, Elip );
		
		//free (vector);
		
		*/

	 }
	 else{
		ErrorCSV( ErCSV );
	 }
  } 
  else {
    DisplayError( error );
  }
  
  return 0;
}