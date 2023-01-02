#define UINT unsigned int
enum { SUCCESS, NO_INPUT, INVALID_HEADER, TOO_MANY_INPUTS, OUT_OF_MEMORY };

#define SizePag 1024
#define Cell_pag SizePag/sizeof(double)

UINT ReadCommandLine( int nArg, char* argumentos[], UINT* header ) {
  
 *header = 0;
  if( nArg == 3 )
    return sscanf( argumentos[2], "%d", header ) == 1 ?
           SUCCESS : INVALID_HEADER;

  else if( nArg < 3 )
    return 2 - nArg;
  
  return TOO_MANY_INPUTS;
}  

UINT GrowVector(double ** vector, UINT* CellDisp, UINT* pages){
	CellDisp[0] += Cell_pag;
	pages[0]++;
	
	
	UINT code = OUT_OF_MEMORY;
	double* tmp = realloc(*vector, pages[0]*SizePag);
	if(tmp != 0){
		if(tmp == *vector){return SUCCESS;}
	*vector = tmp;
	code = SUCCESS;
	}
}


int ReadCSV(char name[], double** matrix, int* nCol, int* nRow, UINT header){
	FILE *Doc;
	Doc = fopen ( name, "r" ); //File name
	if (Doc == NULL) { return 1; }
	else{
		//Buffer of 100
		char buffer[50000]; 
		int colum = 0, i = 0;
		if(header > 0){
			do{
			fgets(buffer, 100, Doc);
			i ++;
			}while(i < header);
		}
		
		//Get first line
		fgets(buffer, 100, Doc);
		
		//Column calculation
		char *current = buffer;
		do{ 
			colum += ( *current == ',' );
		}while(*current++);
		
		double *vector = malloc(SizePag);
		UINT pages = 1;
		UINT CellDisp = Cell_pag;

		// Convert first line to binary
		current = buffer;
		int length=0;
		double* cell = vector;
		i = colum;
		do{
			current += length;
			sscanf(current, "%lf,%n", cell++, &length );
			CellDisp--;
			if( CellDisp == 0 ){
				GrowVector(&vector, &CellDisp, &pages);
			}
		}while(i -- );
		current += length;
		
		// Finish reading file
		int Error = 0, col = colum+1; char dummy;
		do{
			Error = fscanf(Doc, "%lf%c", cell++, &dummy);
			CellDisp--;
			if( CellDisp == 0 ){
				GrowVector(&vector, &CellDisp, &pages);
				cell = vector + (pages-1)*Cell_pag;
			}
		}while( Error == 2 );
		*nCol = colum+1;
		*nRow = (cell - vector)/ *nCol;
		*matrix = vector;
		
		fclose ( Doc );

		return (cell - vector)% *nCol ? 2 : 0 ; 
	}
}