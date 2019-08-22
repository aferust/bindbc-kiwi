module kw.gui;

import kw.widget;
import kw.renderdriver;

extern (C) @nogc nothrow:

alias KW_OnGUIFontChanged = void function(KW_GUI * gui, void * data, KW_Font * font);
alias KW_OnGUITextColorChanged = void function(KW_GUI * gui, void * data, KW_Color color);

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
void KW_AddGUITextColorChangedHandler(KW_GUI * gui, KW_OnGUITextColorChanged handler, void * priv);
void KW_RemoveGUITextColorChangedHandler(KW_GUI * gui, KW_OnGUITextColorChanged handler, void * priv);
KW_Font * KW_GetFont(KW_GUI * gui);
KW_Color KW_GetTextColor(KW_GUI * gui);
void KW_Paint(KW_GUI * gui);
void KW_ProcessEvents(KW_GUI * gui);
