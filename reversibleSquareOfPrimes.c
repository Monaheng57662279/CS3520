#include <stdio.h>
#include <stdbool.h>


int reverse(int num);
bool isPrime(int num);
bool squareOfPrime(int num);
void printReversibleSquares();
 
int main()
{

	printReversibleSquares();
	return 1;
}

int reverse(int num)
{
	int rev = 0; 
	while(num > 0)
	{
		rev = rev * 10 + (num % 10);
		num = num / 10;
	}
	return rev; //the result after reversing
}

bool isPrime(int num)
{
	if(num < 2)
	{
		return false;
	}	
	for (int i = 2; i <= num / 2;i++)
    	{
        if (num % i == 0)
        {
            return false;}
        }
    	
    return true;
}

bool squareOfPrime(int num)
{
if(isPrime(num))
{
	num *= num;
	int revNum = reverse(num);
	if(num != revNum){
	for(int i = 2;i <= (revNum / 2);i++)
	{
		if(i * i == revNum)
		{
			if(isPrime(i))
			
			return true;
		}
	}
	}
}
return false;	
}				

void printReversibleSquares()
{
	int i =2,pos=0;
	while(pos<10)
	{
		if(squareOfPrime(i))
		{
			printf("\n%d",i*i);
			pos++;
		}
		i++;
	}
}	
