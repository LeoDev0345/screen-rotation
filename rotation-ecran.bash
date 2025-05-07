#!/bin/bash

#Detection du peripherique tactile
TOUCH_DEVICE=$(xinput list --name-only | grep -Ei 'touchscreen|tp' | head -n 1)

if [ -z "$TOUCH_DEVICE" ]; then
    echo "Aucun périphérique tactile détecté."
    exit 1
fi

echo "Périphérique tactile détecté : $TOUCH_DEVICE"
echo ""
echo "Choisissez l'orientation de l'écran :"
echo "1) Portrait (rotation à gauche)"
echo "2) Paysage (normal)"
echo "3) Portrait (rotation à droite)"
echo ""

read -p "Votre choix (1, 2 ou 3) : " CHOICE
#changement d'orientation en fonction du choix grace a la valeur qu'on place dans matrix
case "$CHOICE" in
    1)
        echo "Passage en mode portrait gauche..."
        xrandr -o left
        xinput set-prop "$TOUCH_DEVICE" "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
        echo "Écran et tactile en mode portrait gauche."
        ;;
    2)
        echo "Retour en mode paysage..."
        xrandr -o normal
        xinput set-prop "$TOUCH_DEVICE" "Coordinate Transformation Matrix" 1 0 0 0 1 0 0 0 1
        echo "Écran et tactile en mode paysage."
        ;;
    3)
        echo "Passage en mode portrait droite..."
        xrandr -o right
        xinput set-prop "$TOUCH_DEVICE" "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
        echo "Écran et tactile en mode portrait droite."
        ;;
    *)
        echo "choix invalide."
        exit 1
        ;;
esac