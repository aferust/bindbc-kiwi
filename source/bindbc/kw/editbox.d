module bindbc.kw.editbox;

import bindbc.kw.widget;
import bindbc.kw.rect;
import bindbc.kw.renderdriver;
import bindbc.kw.kwbool;

version(BindKiwi_Static){
    extern (C) @nogc nothrow {
        KW_Widget * KW_CreateEditbox(KW_GUI * gui, KW_Widget * parent,
                                                    const char * text,
                                                    const KW_Rect * geometry);
        void KW_SetEditboxText(KW_Widget * widget, const char * text);
        const(char)* KW_GetEditboxText(KW_Widget * widget);
        void KW_SetEditboxCursorPosition(KW_Widget * widget, uint pos);
        uint KW_GetEditboxCursorPosition(KW_Widget * widget);
        void KW_SetEditboxFont(KW_Widget * widget, KW_Font * font);
        KW_Font * KW_GetEditboxFont(KW_Widget * widget);
        KW_Color KW_GetEditboxTextColor(KW_Widget * widget);
        KW_bool KW_WasEditboxTextColorSet(KW_Widget * widget);
        void KW_SetEditboxTextColor(KW_Widget * widget, KW_Color color);
    }

}else{
    extern(C) @nogc nothrow {
        alias pKW_CreateEditbox = KW_Widget* function(KW_GUI*, KW_Widget*, const char*, const KW_Rect*);
        alias pKW_SetEditboxText = void function(KW_Widget*, const char*);
        alias pKW_GetEditboxText = const char* function(KW_Widget*);
        alias pKW_SetEditboxCursorPosition = void function (KW_Widget*, uint);
        alias pKW_GetEditboxCursorPosition = uint function(KW_Widget*);
        alias pKW_SetEditboxFont = void function(KW_Widget*, KW_Font*);
        alias pKW_GetEditboxFont = KW_Font* function(KW_Widget*);
        alias pKW_GetEditboxTextColor = KW_Color function(KW_Widget*);
        alias pKW_WasEditboxTextColorSet = KW_bool function(KW_Widget*);
        alias pKW_SetEditboxTextColor = void function(KW_Widget*, KW_Color);
    }

    __gshared {
        pKW_CreateEditbox KW_CreateEditbox;
        pKW_SetEditboxText KW_SetEditboxText;
        pKW_GetEditboxText KW_GetEditboxText;
        pKW_SetEditboxCursorPosition KW_SetEditboxCursorPosition;
        pKW_GetEditboxCursorPosition KW_GetEditboxCursorPosition;
        pKW_SetEditboxFont KW_SetEditboxFont;
        pKW_GetEditboxFont KW_GetEditboxFont;
        pKW_GetEditboxTextColor KW_GetEditboxTextColor;
        pKW_WasEditboxTextColorSet KW_WasEditboxTextColorSet;
        pKW_SetEditboxTextColor KW_SetEditboxTextColor;
    }
}