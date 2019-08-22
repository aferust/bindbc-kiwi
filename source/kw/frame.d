module kw.frame;

import kw.widget;
import kw.rect;

extern (C) @nogc nothrow:
KW_Widget * KW_CreateFrame(KW_GUI * gui, KW_Widget * parent, const KW_Rect * geometry);
