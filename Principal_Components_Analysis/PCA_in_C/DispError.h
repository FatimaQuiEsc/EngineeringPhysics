#ifndef UINT
#define UINT unsigned int
#endif
  
  void DisplayError( UINT code ) {
  static char* errorMsg[] = {
    "",                                            // UNKNOWN ERROR
    "Ingrese el nombre del archivo seguido del número de líneas\n"
    "del encabezado. El último parámetro es opcional",  // NO_INPUT
    "La entrada que indica el numero de líneas en el encabezado\n"
    "no es número",                               // INVALID_HEADER
    "Hay demasiados parámetros de entrada"        //TOO_MANY_INPUTS
  };
  
  // Display error message
  printf( "%s\n", errorMsg[code] );
}


void ErrorCSV( UINT code ){
	static char* errorMsg[] = {
    "",												// UNKNOWN ERROR
    "Error al abrir o no se encontró archivo\n"		// NO_DOC
    "Faltan datos en renglones",                // INVALID_ROW
  };
  
  // Display error message
  printf( "%s\n", errorMsg[code] );
}