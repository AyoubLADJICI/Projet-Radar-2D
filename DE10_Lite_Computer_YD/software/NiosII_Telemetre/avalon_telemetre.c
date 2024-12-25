#include "system.h"
#include "io.h"
#include <stdio.h>
#include "unistd.h"


unsigned int SevenSeg[16] = {0x3F, // 0
    0x06, //1
    0x5B, //2
    0x4F, //3
    0x66, //4
    0x6D, //5
    0x7D, //6
    0x07, //7
    0x7F, //8
    0x6F, //9
    0x77, //A
    0x7C, //b
    0x39, //C
    0x5E, //d
    0x79, //E
    0x71, //F
};

void decode_distance(unsigned int value) {
    unsigned int display_data[4] = {0, 0, 0, 0};

    display_data[0] = SevenSeg[(value/1) % 10];      //Chiffre des unites
    display_data[1] = SevenSeg[(value/10) % 10];     //Chiffre des dizaines
    display_data[2] = SevenSeg[(value/100) % 10];    //Chiffre des centaines
    display_data[3] = SevenSeg[(value/1000) % 10];   //Chiffre des milliers

    //Ecriture des valeurs sur les registres des afficheurs
    IOWR(HEX3_HEX0_BASE, 0, (display_data[3]) << 24 | (display_data[2] << 16) | (display_data[1] << 8) | (display_data[0]));
}

int main() {
    printf("Test de l'IP telemetre \n");
    printf("Affichage des distances \n");
    while (1) {
        unsigned int aller_retour = IORD(AVALON_TELEMETRE_0_BASE, 0);
        unsigned int distance = aller_retour/2;
        decode_distance(distance);
        printf("Distance mesuree : %u cm\n", distance);
        usleep(10000); //pause de 100ms
    }
    return 0;
}
