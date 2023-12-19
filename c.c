#include <stdio.h>



int peler(int a,int b, int c){
    int pepek = 0;

    return pepek = a > b ? a > c ? a : c : b > c ? b : c;

}


int main(int argc, char const *argv[]){
    int a = 27, b= 35, c=500;

    printf("%d", peler(a,b,c));
    return 0;
}