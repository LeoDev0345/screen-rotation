#!/bin/bash

# Detect touchscreen device
TOUCH_DEVICE=$(xinput list --name-only | grep -Ei 'touchscreen|tp' | head -n 1)

if [ -z "$TOUCH_DEVICE" ]; then
    echo "No touchscreen device detected."
    exit 1
fi

echo "Touchscreen device detected: $TOUCH_DEVICE"
echo ""
echo "Choose screen orientation:"
echo "1) Portrait (rotate left)"
echo "2) Landscape (normal)"
echo "3) Portrait (rotate right)"
echo ""

read -p "Your choice (1, 2 or 3): " CHOICE

# Change orientation based on the user's choice using a transformation matrix
case "$CHOICE" in
    1)
        echo "Switching to left portrait mode..."
        xrandr -o left
        xinput set-prop "$TOUCH_DEVICE" "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
        echo "Screen and touch set to left portrait mode."
        ;;
    2)
        echo "Switching to landscape mode..."
        xrandr -o normal
        xinput set-prop "$TOUCH_DEVICE" "Coordinate Transformation Matrix" 1 0 0 0 1 0 0 0 1
        echo "Screen and touch set to landscape mode."
        ;;
    3)
        echo "Switching to right portrait mode..."
        xrandr -o right
        xinput set-prop "$TOUCH_DEVICE" "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
        echo "Screen and touch set to right portrait mode."
        ;;
    *)
        echo "Invalid choice."
        exit 1
        ;;
esac
