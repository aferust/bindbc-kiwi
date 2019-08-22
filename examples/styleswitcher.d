module app;

import core.stdc.stdlib;

import std.stdio;
import std.conv;
import std.string;

import derelict.sdl2.sdl;
import derelict.sdl2.image;

import kw;

// translated from: https://github.com/mobius3/KiWi/blob/master/examples/styleswitcher/styleswitcher.c
// you will need some resources from https://github.com/mobius3/KiWi/tree/master/examples/tileset to run the example

KW_Widget * frame;

KW_Surface * setalloy;
KW_Surface * setfutter;
KW_Surface * setflat;
KW_Surface * set;

KW_Font * fontin;
KW_Font * sourcepro;
KW_Font * dejavu;
SDL_bool quit = SDL_FALSE;

void kthxbaiClicked(KW_Widget * widget, int b) {
    quit = SDL_TRUE;
}

void SwitchTo(KW_Widget * widget, KW_Font * font, KW_Surface * surface, ubyte r, ubyte g, ubyte b) {
    KW_GUI * gui = KW_GetGUI(widget);
    SDL_Renderer * renderer = KW_RenderDriverGetSDL2Renderer(KW_GetRenderer(gui));
    KW_SetFont(gui, font);
    SDL_SetRenderDrawColor(renderer, r, g, b, 1);
    KW_SetTilesetSurface(gui, surface);
}

void SwitchFlatClicked(KW_Widget * widget, int b) {
    SwitchTo(frame, sourcepro, setflat, 200, 100, 100);
}

void SwitchAlloyClicked(KW_Widget * widget, int b) {
    SwitchTo(frame, sourcepro, setalloy, 64, 67, 70);
}

void SwitchNormalClicked(KW_Widget * widget, int b) {
    SwitchTo(frame, fontin, set, 100, 100, 200);
}

void SwitchFutterClicked(KW_Widget * widget, int b) {
    SwitchTo(frame, fontin, setfutter, 118, 152, 162);
}

int main() {
    DerelictSDL2.load();
    DerelictSDL2Image.load();
    
    SDL_Init(SDL_INIT_EVERYTHING);
    SDL_Window * window;
    SDL_Renderer * renderer;
    SDL_CreateWindowAndRenderer(320, 240, 0, &window, &renderer);
    SDL_SetRenderDrawColor(renderer, 118, 152, 162, 1);

    KW_RenderDriver * driver = KW_CreateSDL2RenderDriver(renderer, window);
    setalloy = KW_LoadSurface(driver, "tileset-alloy.png");
    setfutter = KW_LoadSurface(driver, "tileset-futterpedia.png");
    setflat = KW_LoadSurface(driver, "tileset-flat.png");
    set = KW_LoadSurface(driver, "tileset.png");

    KW_GUI * gui = KW_Init(driver, setfutter);
    fontin = KW_LoadFont(driver, "Fontin-Regular.ttf", 12);
    sourcepro = KW_LoadFont(driver, "SourceSansPro-Semibold.ttf", 12);
    dejavu = KW_LoadFont(driver, "DejaVuSans.ttf", 11);
    KW_SetFont(gui, fontin);

    KW_Rect framegeom;

    /* top frame */  
    framegeom.x = 10, framegeom.y = 10, framegeom.w = 300, framegeom.h = 220;
    frame = KW_CreateFrame(gui, null, &framegeom);

    /* buttons frame */
    framegeom.x = 10, framegeom.y = 160, framegeom.w = 280, framegeom.h = 48;
    KW_Widget * buttonsframe = KW_CreateFrame(gui, frame, &framegeom);

    KW_Rect buttongeom = { x: 10, y: 8, w: 32, h: 32 };
    KW_Widget * button;
    button = KW_CreateButton(gui, buttonsframe, null, &buttongeom);
    KW_SetWidgetTilesetSurface(button, set);
    KW_OnMouseDown cb1 = cast(KW_OnMouseDown)(&SwitchNormalClicked);
    KW_AddWidgetMouseDownHandler(button, cb1);

    buttongeom.x += 290/4;
    button = KW_CreateButton(gui, buttonsframe, null, &buttongeom);
    KW_SetWidgetTilesetSurface(button, setalloy);

    KW_OnMouseDown cb2 = cast(KW_OnMouseDown)(&SwitchAlloyClicked);
    KW_AddWidgetMouseDownHandler(button, cb2);

    buttongeom.x += 290/4;
    button = KW_CreateButton(gui, buttonsframe, null, &buttongeom);
    KW_SetWidgetTilesetSurface(button, setfutter);

    KW_OnMouseDown cb3 = cast(KW_OnMouseDown)(&SwitchFutterClicked);
    KW_AddWidgetMouseDownHandler(button, cb3);

    buttongeom.x += 290/4;
    button = KW_CreateButton(gui, buttonsframe, null, &buttongeom);
    KW_SetWidgetTilesetSurface(button, setflat);

    KW_OnMouseDown cb4 = cast(KW_OnMouseDown)(&SwitchFlatClicked);
    KW_AddWidgetMouseDownHandler(button, cb4);

    /* reset framegeom */
    framegeom.x = 10, framegeom.y = 10, framegeom.w = 300, framegeom.h = 220;
    framegeom.w -= 20; framegeom.h = 100;

    /* create the editbox frames */
    KW_Rect editgeom = { x: 120, y: 20, w: 150, h: 35 };
    KW_Rect labelgeom = { x: 10, y: 20, w: 110, h: 35 };
    frame = KW_CreateFrame(gui, frame, &framegeom);
    KW_Widget * editbx = KW_CreateEditbox(gui, frame, "βέβαιος (sure)", &editgeom);
    KW_SetEditboxFont(editbx, dejavu);
    KW_Widget * label = KW_CreateLabel(gui, frame, "Can you do UTF-8?", &labelgeom);
    KW_SetLabelAlignment(label, KW_LABEL_ALIGN_RIGHT, 0, KW_LABEL_ALIGN_MIDDLE, 0);

    buttongeom = editgeom;
    buttongeom.y = 60; buttongeom.h -= 10;
    KW_Widget * kthxbai = KW_CreateButtonAndLabel(gui, frame, "kthxbai", &buttongeom);

    KW_OnMouseDown cb5 = cast(KW_OnMouseDown)(&kthxbaiClicked);
    KW_AddWidgetMouseDownHandler(kthxbai, cb5);
  
    while (!SDL_QuitRequested() && !quit) {
        SDL_RenderClear(renderer);
        KW_ProcessEvents(gui);
        KW_Paint(gui);
        SDL_RenderPresent(renderer);
        SDL_Delay(1);
    }

    /* free stuff */
    KW_Quit(gui);

    KW_ReleaseFont(driver, fontin);
    KW_ReleaseFont(driver, dejavu);
    KW_ReleaseSurface(driver, set);
    KW_ReleaseSurface(driver, setalloy);
    KW_ReleaseSurface(driver, setflat);
    KW_ReleaseSurface(driver, setfutter);
    SDL_Quit();

    return 0;
}
