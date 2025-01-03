#include "system.h"
#include "io.h"
#include <stdio.h>
#include <unistd.h>


int main() {
    printf("Affichage des obstacles :\n");
    while (1) {
        // Balayer de 0� � 90�
        for (unsigned int position = 0; position < 511; position++) {
        	//Envoyer la position au servomoteur
            IOWR(AVALON_SERVOMOTEUR_0_BASE, 0, position);
            //Conversion de la position (en binaire) en degr� �
            int angle = (position * 180 / 511);
            //Lecture de la distance avec le t�l�m�tre
            unsigned int aller_retour = IORD(AVALON_TELEMETRE_0_BASE, 0);
            unsigned int distance = aller_retour/2;
            printf("%u� -> %u cm\n", angle, distance);
            usleep(3000); // Pause pour assurer un mouvement fluide (20 ms)
        }

        // Balayer de 180� � 0�
        for (unsigned int position = 511; position > 0; position--) {
        	//Envoyer la position au servomoteur
        	IOWR(AVALON_SERVOMOTEUR_0_BASE, 0, position);
        	//Conversion de la position (en binaire) en degr� �
        	int angle = (position * 180 / 511);
        	//Lecture de la distance avec le t�l�m�tre
        	unsigned int aller_retour = IORD(AVALON_TELEMETRE_0_BASE, 0);
        	unsigned int distance = aller_retour/2;
        	printf("%u� -> %u cm\n", angle, distance);
        	usleep(3000); // Pause pour assurer un mouvement fluide (20 ms)
        }
        // Pause avant de recommencer un nouveau balayage
        printf("Fin du programme.\n");
        printf("Red�marrage dans 1 seconde.\n");
        usleep(1000000);
    }
    return 0;
}
