#include "system.h"
#include "io.h"
#include <stdio.h>
#include <unistd.h>


int main() {
    printf("Commande du servomoteur en position depuis les interrupteurs\n");

    while (1) {
        //Lire la position des switchs
        unsigned int switches = IORD(SLIDER_SWITCHES_BASE, 0);
        //Mon signal position est sur 8 bits donc on fait un masque afin que
        //si on a une valeur supErieure a laquelle on peut generer sur 8 bits
        unsigned int position = (switches);

        // Envoyer la commande au servomoteur
        IOWR(AVALON_SERVOMOTEUR_0_BASE, 0, position);
        //on le convertit ensuite en degres pour avoir la valeur de l'angle
        int angle = (position*90/255);
        printf("position = %u, Angle du servomoteur : %u degres\n",position,angle);
        usleep(20000); // Pause de 20 ms

    }

    return 0;
}
