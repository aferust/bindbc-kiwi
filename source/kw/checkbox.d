module kw.checkbox;

import kw.widget;
import kw.rect;

extern (C) @nogc nothrow:
KW_Widget * KW_CreateCheckbox(KW_GUI * gui, KW_Widget * parent, KW_Widget * label, const KW_Rect * geometry);
KW_Widget * KW_GetCheckboxLabel(KW_Widget * widget);
KW_Widget * KW_SetCheckboxLabel(KW_Widget * widget, KW_Widget * label);



