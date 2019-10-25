module bindbc.kw.gui;

import bindbc.kw.widget;
import bindbc.kw.renderdriver;

extern (C) @nogc nothrow {
    alias KW_OnGUIFontChanged = void function(KW_GUI*, void*, KW_Font*);
    alias KW_OnGUITextColorChanged = void function(KW_GUI*, void*, KW_Color);
}

version(BindKiwi_Static){
    extern (C) @nogc nothrow {
        KW_GUI * KW_Init(KW_RenderDriver * renderer, KW_Surface * tileset);
        void KW_Quit(KW_GUI * gui);
        void KW_SetRenderer(KW_GUI * gui, KW_RenderDriver * renderer);
        KW_RenderDriver * KW_GetRenderer(KW_GUI * gui);
        void KW_SetTilesetSurface(KW_GUI * gui, KW_Surface * tileset);
        KW_Texture * KW_GetTilesetTexture(KW_GUI * gui);
        KW_Surface * KW_GetTilesetSurface(KW_GUI * gui);
        void KW_SetFont(KW_GUI * gui, KW_Font * font);
        void KW_SetTextColor(KW_GUI * gui, KW_Color color);
        void KW_AddGUIFontChangedHandler(KW_GUI * gui, KW_OnGUIFontChanged handler, void * priv);
        void KW_RemoveGUIFontChangedHandler(KW_GUI * gui, KW_OnGUIFontChanged handler, void * priv);
        void KW_AddGUITextColorChangedHandler(KW_GUI*, KW_OnGUITextColorChanged, void*);
        void KW_RemoveGUITextColorChangedHandler(KW_GUI * gui, KW_OnGUITextColorChanged handler, void * priv);
        KW_Font * KW_GetFont(KW_GUI * gui);
        KW_Color KW_GetTextColor(KW_GUI * gui);
        void KW_Paint(KW_GUI * gui);
        void KW_ProcessEvents(KW_GUI * gui);
    }
} else {
    extern (C) @nogc nothrow {
        alias pKW_Init = KW_GUI * function(KW_RenderDriver*, KW_Surface*);
        alias pKW_Quit = void function(KW_GUI*);
        alias pKW_SetRenderer = void function(KW_GUI*, KW_RenderDriver*);
        alias pKW_GetRenderer = KW_RenderDriver * function(KW_GUI*);
        alias pKW_SetTilesetSurface = void function(KW_GUI*, KW_Surface*);
        alias pKW_GetTilesetTexture = KW_Texture * function(KW_GUI*);
        alias pKW_GetTilesetSurface = KW_Surface * function(KW_GUI*);
        alias pKW_SetFont = void function(KW_GUI*, KW_Font*);
        alias pKW_SetTextColor = void function(KW_GUI*, KW_Color);
        alias pKW_AddGUIFontChangedHandler = void function(KW_GUI*, KW_OnGUIFontChanged, void*);
        alias pKW_RemoveGUIFontChangedHandler = void function(KW_GUI*, KW_OnGUIFontChanged, void*);
        alias pKW_AddGUITextColorChangedHandler = void function(KW_GUI*, KW_OnGUITextColorChanged, void*);
        alias pKW_RemoveGUITextColorChangedHandler = void function(KW_GUI*, KW_OnGUITextColorChanged, void*);
        alias pKW_GetFont = KW_Font * function(KW_GUI*);
        alias pKW_GetTextColor = KW_Color function(KW_GUI*);
        alias pKW_Paint = void function(KW_GUI*);
        alias pKW_ProcessEvents = void function(KW_GUI*);
    }

    __gshared {
        pKW_Init KW_Init;
        pKW_Quit KW_Quit;
        pKW_SetRenderer KW_SetRenderer;
        pKW_GetRenderer KW_GetRenderer;
        pKW_SetTilesetSurface KW_SetTilesetSurface;
        pKW_GetTilesetTexture KW_GetTilesetTexture;
        pKW_GetTilesetSurface KW_GetTilesetSurface;
        pKW_SetFont KW_SetFont;
        pKW_SetTextColor KW_SetTextColor;
        pKW_AddGUIFontChangedHandler KW_AddGUIFontChangedHandler;
        pKW_RemoveGUIFontChangedHandler KW_RemoveGUIFontChangedHandler;
        pKW_AddGUITextColorChangedHandler KW_AddGUITextColorChangedHandler;
        pKW_RemoveGUITextColorChangedHandler KW_RemoveGUITextColorChangedHandler;
        pKW_GetFont KW_GetFont;
        pKW_GetTextColor KW_GetTextColor;
        pKW_Paint KW_Paint;
        pKW_ProcessEvents KW_ProcessEvents;
    }
}

