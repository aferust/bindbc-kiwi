module kw.scrollbox;

import kw.gui;
import kw.widget;
import kw.rect;

extern(C) @nogc nothrow:
KW_Widget * KW_CreateScrollbox(KW_GUI * gui, KW_Widget * parent, const KW_Rect * geometry);
void KW_ScrollboxVerticalScroll(KW_Widget * scrollbox, int amount);
void KW_ScrollboxHorizontalScroll(KW_Widget * scrollbox, int amount);
