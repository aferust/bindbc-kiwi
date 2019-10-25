module bindbc.kw.frame;

import bindbc.kw.widget;
import bindbc.kw.rect;

version(BindKiwi_Static){
    extern (C) @nogc nothrow {
        KW_Widget * KW_CreateFrame(KW_GUI * gui, KW_Widget * parent, const KW_Rect * geometry);
    }
} else {
    extern (C) @nogc nothrow {
        alias pKW_CreateFrame = KW_Widget * function(KW_GUI*, KW_Widget*, const KW_Rect*);
    }

    __gshared {
        pKW_CreateFrame KW_CreateFrame;
    }
}