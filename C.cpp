#include<stdio.h>

int increment( int blah ) {
  unsigned int i;
  for (i = 1; i; i <<= 1) {
    if (!(blah & i)) {
      blah |= i;
      break;
    } else {
      blah ^= i;
    }
  }
  return blah;
}

int add ( int a, int b ) {
  b = ~b;
  while ( (b=increment(b)) != 0 ) a = increment( a );
  return a;
}

int mul321 ( int value ) {
  int result = 0;
  result = add( result, value << 8 );
  result = add( result, value << 6 );
  result = add( result, value      );
  return result;
}

int main ( ) {
    int i;
    for ( i = 0 ; i < 20 ; i++ ) {
        printf( "%2d %5d %5d\n", i, i*321, mul321(i) );
    }
    return 0;
}