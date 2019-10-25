module bindbc.kw.checkbox;

import bindbc.kw.widget;
import bindbc.kw.rect;

version(BindKiwi_Static){
    extern (C) @nogc nothrow {
        KW_Widget * KW_CreateCheckbox(KW_GUI * gui, KW_Widget * parent, KW_Widget * label, const KW_Rect * geometry);
        KW_Widget * KW_GetCheckboxLabel(KW_Widget * widget);
        KW_Widget * KW_SetCheckboxLabel(KW_Widget * widget, KW_Widget * label);

    }
}else{
    extern(C) @nogc nothrow {
        alias pKW_CreateCheckbox = KW_Widget* function(KW_GUI*, KW_Widget*, KW_Widget*, const KW_Rect*);
        alias pKW_GetCheckboxLabel = KW_Widget* function(KW_Widget*);
        alias pKW_SetCheckboxLabel = KW_Widget* function(KW_Widget*, KW_Widget*);
    }
    __gshared {
        pKW_CreateCheckbox KW_CreateCheckbox;
        pKW_GetCheckboxLabel KW_GetCheckboxLabel;
        pKW_SetCheckboxLabel KW_SetCheckboxLabel;
    }
}
