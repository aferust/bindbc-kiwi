module kw.toggle;

import kw.gui;
import kw.widget;
import kw.rect;
import kw.kwbool;

extern(C) @nogc nothrow:
KW_Widget * KW_CreateToggle(KW_GUI * gui, KW_Widget * parent, const KW_Rect * geometry);
KW_bool KW_IsToggleChecked(KW_Widget * widget);
void KW_SetToggleChecked(KW_Widget * widget, KW_bool checked);
