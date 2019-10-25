module bindbc.kw.scrollbox;

import bindbc.kw.gui;
import bindbc.kw.widget;
import bindbc.kw.rect;

version(BindKiwi_Static){
    extern (C) @nogc nothrow {
        KW_Widget * KW_CreateScrollbox(KW_GUI * gui, KW_Widget * parent, const KW_Rect * geometry);
        void KW_ScrollboxVerticalScroll(KW_Widget * scrollbox, int amount);
        void KW_ScrollboxHorizontalScroll(KW_Widget * scrollbox, int amount);
    }
} else {
    extern (C) @nogc nothrow {
        alias pKW_CreateScrollbox = KW_Widget* function(KW_GUI * gui, KW_Widget * parent, const KW_Rect * geometry);
        alias pKW_ScrollboxVerticalScroll = void function(KW_Widget * scrollbox, int amount);
        alias pKW_ScrollboxHorizontalScroll = void function(KW_Widget * scrollbox, int amount);
    }
    __gshared {
        pKW_CreateScrollbox KW_CreateScrollbox;
        pKW_ScrollboxVerticalScroll KW_ScrollboxVerticalScroll;
        pKW_ScrollboxHorizontalScroll KW_ScrollboxHorizontalScroll;
    }
}
