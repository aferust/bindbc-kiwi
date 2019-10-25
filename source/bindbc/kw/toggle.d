module bindbc.kw.toggle;

import bindbc.kw.gui;
import bindbc.kw.widget;
import bindbc.kw.rect;
import bindbc.kw.kwbool;

version(BindKiwi_Static){
    extern (C) @nogc nothrow {
        KW_Widget * KW_CreateToggle(KW_GUI * gui, KW_Widget * parent, const KW_Rect * geometry);
        KW_bool KW_IsToggleChecked(KW_Widget * widget);
        void KW_SetToggleChecked(KW_Widget * widget, KW_bool checked);
    }
} else {
    extern (C) @nogc nothrow {
        alias pKW_CreateToggle = KW_Widget* function(KW_GUI * gui, KW_Widget * parent, const KW_Rect * geometry);
        alias pKW_IsToggleChecked = KW_bool function(KW_Widget * widget);
        alias pKW_SetToggleChecked = void function(KW_Widget * widget, KW_bool checked);
    }

    __gshared {
        pKW_CreateToggle KW_CreateToggle;
        pKW_IsToggleChecked KW_IsToggleChecked;
        pKW_SetToggleChecked KW_SetToggleChecked;
    }
}
