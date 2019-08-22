module kw.label;

import kw.widget;
import kw.renderdriver;
import kw.rect;
import kw.kwbool;

enum /*KW_LabelVerticalAlignment*/ {
  KW_LABEL_ALIGN_TOP,     /** Vertically align label in the top of the geometry. */
  KW_LABEL_ALIGN_MIDDLE,  /** Vertically align label in the middle of the geometry. */
  KW_LABEL_ALIGN_BOTTOM   /** Vertically align label in the bottom of the geometry. */
}

enum /*KW_LabelHorizontalAlignment*/ {
  KW_LABEL_ALIGN_LEFT,    /** Horizontally align label in the left part of the geometry. */
  KW_LABEL_ALIGN_CENTER,  /** Horizontally align label in the center part of the geometry. */
  KW_LABEL_ALIGN_RIGHT    /** Horizontally align label in the right part of the geometry. */
}

extern (C) @nogc nothrow:
KW_Widget * KW_CreateLabel(KW_GUI * gui, KW_Widget * parent, const char * text, const KW_Rect * geometry);
void KW_SetLabelText(KW_Widget * widget, const char * text);
void KW_SetLabelStyle(KW_Widget * widget, int style);
void KW_SetLabelTextColor(KW_Widget * widget, KW_Color color);
void KW_SetLabelFont(KW_Widget * widget, KW_Font * font);
void KW_SetLabelAlignment(KW_Widget * widget, int halign, int hoffset, int valign, int voffset);
void KW_SetLabelIcon(KW_Widget * widget, const KW_Rect * iconclip);
KW_Font * KW_GetLabelFont(KW_Widget * widget);
KW_Color KW_GetLabelTextColor(KW_Widget * widget);
KW_bool KW_WasLabelTextColorSet(KW_Widget * widget);
