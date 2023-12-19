#include <stdio.h>
#include <string.h>

int main()
{

    char pilihan[4];

    printf("masukan pilihan yes atau no :");
    scanf("%3s", &pilihan);

    if (strcmp(pilihan, "yes") == 0) {
        printf("Iya\n");
    } else if (strcmp(pilihan, "no") == 0) {
        printf("Tidak\n");
    } else {
        printf("Tolol, cie baca nih apa gaya cung to!!\n");
    }
}