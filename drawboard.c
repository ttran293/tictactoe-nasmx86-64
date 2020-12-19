#include <stdio.h>

void drawboard(char ch[])
{
	
	printf("%c", ch[0]); printf("%s", " | "); printf("%c", ch[1]); printf("%s", " | "); printf("%c", ch[2]); printf("%s", " | "); printf("%c", ch[3]);
	printf("\n");
    	printf("%s","---------------");
	printf("\n");
    	printf("%c", ch[4]); printf("%s", " | "); printf("%c", ch[5]); printf("%s", " | "); printf("%c", ch[6]); printf("%s", " | "); printf("%c", ch[7]);
    	printf("\n");
   	printf("%s","---------------");
	printf("\n");
   	printf("%c", ch[8]); printf("%s", " | "); printf("%c", ch[9]); printf("%s", " | "); printf("%c", ch[10]); printf("%s", " | "); printf("%c", ch[11]);
   	printf("\n");
   	printf("%s","---------------");
	printf("\n");
   	printf("%c", ch[12]); printf("%s", " | "); printf("%c", ch[13]); printf("%s", " | "); printf("%c", ch[14]); printf("%s", " | "); printf("%c", ch[15]);
   	printf("\n"); 

}