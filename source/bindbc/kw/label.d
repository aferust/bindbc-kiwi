module bindbc.kw.label;

import bindbc.kw.widget;
import bindbc.kw.renderdriver;
import bindbc.kw.rect;
import bindbc.kw.kwbool;

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

version(BindKiwi_Static){
    extern (C) @nogc nothrow {
        KW_Widget * KW_CreateLabel(KW_GUI * gui, KW_Widget * parent, const char * text, const KW_Rect * geometry);
        void KW_SetLabelText(KW_Widget * widget, const(char)* text);
        void KW_SetLabelStyle(KW_Widget * widget, int style);
        void KW_SetLabelTextColor(KW_Widget * widget, KW_Color color);
        void KW_SetLabelFont(KW_Widget * widget, KW_Font * font);
        void KW_SetLabelAlignment(KW_Widget * widget, int halign, int hoffset, int valign, int voffset);
        void KW_SetLabelIcon(KW_Widget * widget, const KW_Rect * iconclip);
        KW_Font * KW_GetLabelFont(KW_Widget * widget);
        KW_Color KW_GetLabelTextColor(KW_Widget * widget);
        KW_bool KW_WasLabelTextColorSet(KW_Widget * widget);
    }
} else {
    extern (C) @nogc nothrow {
        alias pKW_CreateLabel = KW_Widget* function(KW_GUI * gui, KW_Widget * parent, const char * text, const KW_Rect * geometry);
        alias pKW_SetLabelText = void function(KW_Widget * widget, const(char)* text);
        alias pKW_SetLabelStyle = void function(KW_Widget * widget, int style);
        alias pKW_SetLabelTextColor = void function(KW_Widget * widget, KW_Color color);
        alias pKW_SetLabelFont = void function(KW_Widget * widget, KW_Font * font);
        alias pKW_SetLabelAlignment = void function(KW_Widget * widget, int halign, int hoffset, int valign, int voffset);
        alias pKW_SetLabelIcon = void function(KW_Widget * widget, const KW_Rect * iconclip);
        alias pKW_GetLabelFont = KW_Font * function(KW_Widget * widget);
        alias pKW_GetLabelTextColor = KW_Color function(KW_Widget * widget);
        alias pKW_WasLabelTextColorSet = KW_bool function(KW_Widget * widget);
    }
    __gshared {
        pKW_CreateLabel KW_CreateLabel;
        pKW_SetLabelText KW_SetLabelText;
        pKW_SetLabelStyle KW_SetLabelStyle;
        pKW_SetLabelTextColor KW_SetLabelTextColor;
        pKW_SetLabelFont KW_SetLabelFont;
        pKW_SetLabelAlignment KW_SetLabelAlignment;
        pKW_SetLabelIcon KW_SetLabelIcon;
        pKW_GetLabelFont KW_GetLabelFont;
        pKW_GetLabelTextColor KW_GetLabelTextColor;
        pKW_WasLabelTextColorSet KW_WasLabelTextColorSet;
    }
}


