module kw.editbox;

import kw.widget;
import kw.rect;
import kw.renderdriver;
import kw.kwbool;

extern (C) @nogc nothrow:
KW_Widget * KW_CreateEditbox(KW_GUI * gui, KW_Widget * parent,
                                             const char * text,
                                             const KW_Rect * geometry);
void KW_SetEditboxText(KW_Widget * widget, const char * text);
const(char*) KW_GetEditboxText(KW_Widget * widget);
void KW_SetEditboxCursorPosition(KW_Widget * widget, uint pos);
uint KW_GetEditboxCursorPosition(KW_Widget * widget);
void KW_SetEditboxFont(KW_Widget * widget, KW_Font * font);
KW_Font * KW_GetEditboxFont(KW_Widget * widget);
KW_Color KW_GetEditboxTextColor(KW_Widget * widget);
KW_bool KW_WasEditboxTextColorSet(KW_Widget * widget);
void KW_SetEditboxTextColor(KW_Widget * widget, KW_Color color);
