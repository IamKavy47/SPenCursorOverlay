#!/system/bin/sh

get_input() {
  timeout 1s /system/bin/getevent -lc 1 2>&1 | grep VOLUME
}

ui_print " "
ui_print "  --- Select Cursor Color ---"
ui_print "  Vol+ = Light Theme"
ui_print "  Vol- = Dark Theme"
ui_print " "
ui_print "  Waiting 30s for input..."
ui_print "  (Defaults to Dark if no keys pressed)"
ui_print " "

COUNT=0
SELECTED="none"
while [ $COUNT -lt 30 ]; do
  EVENT=$(get_input)
  if echo "$EVENT" | grep -q "KEY_VOLUMEUP"; then
    SELECTED="light"
    break
  elif echo "$EVENT" | grep -q "KEY_VOLUMEDOWN"; then
    SELECTED="dark"
    break
  fi
  COUNT=$((COUNT + 1))
done

TARGET_DIR="$MODPATH/system/product/overlay"
mkdir -p "$TARGET_DIR"

if [ "$SELECTED" = "light" ]; then
  FILE="LightCursor.apk"
  ui_print "- Selected: Light Theme"
else
  FILE="DarkCursor.apk"
  [ "$SELECTED" = "none" ] && ui_print "- Timeout: Defaulting to Dark Theme" || ui_print "- Selected: Dark Theme"
fi
sleep 1.0

if [ -f "$MODPATH/common/$FILE" ]; then
  cp -f "$MODPATH/common/$FILE" "$TARGET_DIR/CursorOverlay.apk"
else
  ui_print "! ERROR: Source $FILE not found in /common/"
fi

rm -rf "$MODPATH/common"

ui_print "- Installing Input Device Config..."
sleep 0.2
ui_print "- Injecting Resource Overlay..."
sleep 0.2

[ -d "$MODPATH/system/usr/idc" ] && set_perm_recursive "$MODPATH/system/usr/idc" 0 0 0755 0644
set_perm "$TARGET_DIR/CursorOverlay.apk" 0 0 0644

ui_print "- Installation Complete!"
sleep 0.5

ui_print " "
ui_print "  Go to Developer Options and"
ui_print "  ENABLE 'Show taps' to see the"
ui_print "  S-Pen hover pointer."
ui_print " "