module kw.button;

import kw.widget;
import kw.rect;

extern (C) @nogc nothrow:

KW_Widget * KW_CreateButton(KW_GUI * gui, KW_Widget * parent, KW_Widget * label, const KW_Rect * geometry);
KW_Widget * KW_CreateButtonAndLabel(KW_GUI * gui, KW_Widget * parent, const char * text, const KW_Rect * geometry);
KW_Widget * KW_SetButtonLabel(KW_Widget * button, KW_Widget * label);
KW_Widget * KW_GetButtonLabel(KW_Widget * button);
