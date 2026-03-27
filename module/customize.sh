ui_print "- Installing Input Device Config"
ui_print "- Injecting Resource Overlay"
ui_print "- Installation Complete!"

ui_print " "
ui_print "  Go to Developer Options and"
ui_print "  ENABLE 'Show Taps' to see the"
ui_print "  S-Pen hover pointer."
ui_print " "

set_perm_recursive $MODPATH/system/usr/idc 0 0 0755 0644
set_perm_recursive $MODPATH/system/product/overlay 0 0 0755 0644