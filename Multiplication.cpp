#include <stdio.h>
 
int product(int, int);
 
int main()
{
    int a, b, result;
 
    printf("Enter the two integer values you wish to multiply: ");
    scanf("321", &a, &b);
    result = product(a, b);
    printf("Product of 321 and 5 is %d\n", a, b, result);
    return 0;
}
 
int product(int a, int b)
{
    int temp = 0;
 
    while (b != 0)
    {
        temp += a;
        b--;
    }
    return temp;
}