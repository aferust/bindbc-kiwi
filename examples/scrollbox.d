module app;

import core.stdc.stdlib;

import std.stdio;
import std.conv;
import std.string;

import derelict.sdl2.sdl;
import derelict.sdl2.image;

import kw;

// translated from: https://github.com/mobius3/KiWi/blob/master/examples/scrollbox/scrollbox.c
// you will need some resources from https://github.com/mobius3/KiWi/tree/master/examples/tileset to run the example

int dragmode = 0;

extern(C) void DragStart(KW_Widget * widget, int x, int y) {
    KW_Rect g;
    KW_GetWidgetAbsoluteGeometry(widget, &g);
    if (x> g.x + g.w - 40 && y > g.y + g.h -40) dragmode = 1;
    else dragmode = 0;
}

extern(C) void DragStop(KW_Widget * widget, int x, int y) {
}

extern(C) void Drag(KW_Widget * widget, int x, int y, int xrel, int yrel) {
    KW_Rect g;
    KW_GetWidgetGeometry(widget, &g);
    if (dragmode == 1) {
        g.w += xrel;
        g.h += yrel;
    } else {
        g.x += xrel;
        g.y += yrel;
    }
    KW_SetWidgetGeometry(widget, &g);
}

int main() {
    DerelictSDL2.load();
    DerelictSDL2Image.load();
    SDL_Window * window;
    SDL_Renderer * renderer;
    KW_RenderDriver * driver;
    KW_Surface * set;
    KW_GUI * gui;
    KW_Font * font;
    KW_Rect geometry = {0, 0, 320, 240};
    KW_Widget * frame; KW_Widget * button;
    int i;
    SDL_Event ev;

    /* initialize SDL */
    SDL_Init(SDL_INIT_EVERYTHING);

version(Android){
    /* enjoy all the screen size on android */
    i = SDL_GetNumVideoDisplays();
    if (i < 1) exit(1);
    SDL_GetDisplayBounds(0, &geometry);
}
    SDL_CreateWindowAndRenderer(geometry.w, geometry.h, SDL_WINDOW_RESIZABLE, &window, &renderer);
    SDL_SetRenderDrawColor(renderer, 100, 200, 100, 1);
    driver = KW_CreateSDL2RenderDriver(renderer, window);
    set = KW_LoadSurface(driver, "tileset.png");

    /* initialize gui */
    gui = KW_Init(driver, set);
    font = KW_LoadFont(driver, "SourceSansPro-Semibold.ttf", 12);
    KW_SetFont(gui, font);

    geometry.x = cast(uint)(geometry.w * 0.0625f);
    geometry.y = cast(uint)(geometry.h * .0625f);
    geometry.w = cast(int)(geometry.w * .875f);
    geometry.h = cast(int)(geometry.h * .875f);
    frame = KW_CreateScrollbox(gui, null, &geometry);
    KW_OnDragStart cb1 = cast(KW_OnDragStart)(&DragStart);
    KW_AddWidgetDragStartHandler(frame, cb1);
    KW_OnDrag cb2 = cast(KW_OnDrag)(&Drag);
    KW_AddWidgetDragHandler(frame, cb2);
    KW_OnDragStop cb3 = cast(KW_OnDragStop)(&DragStop);
    KW_AddWidgetDragStopHandler(frame, cb3);

    geometry.x = 10; geometry.y = 0; geometry.h = 40; geometry.w = 230;

    for (i = 0; i < 5; i++) {
    button = KW_CreateButtonAndLabel(gui, frame, "Drag me, resize me.", &geometry);
        KW_AddWidgetDragStartHandler(button, cb1);
        KW_AddWidgetDragHandler(button, cb2);
        KW_AddWidgetDragStopHandler(button, cb3);
        geometry.y += geometry.h;
    }
    
    /* create another parent frame */
    while (!SDL_QuitRequested()) {
        while (SDL_PollEvent(&ev)) {
            if (ev.type == SDL_WINDOWEVENT && ev.window.event == SDL_WINDOWEVENT_SIZE_CHANGED) {
                geometry.w = cast(uint)ev.window.data1;
                geometry.h = cast(uint)ev.window.data2;
                geometry.x = cast(uint)(geometry.w * 0.0625);
                geometry.y = cast(uint)(geometry.h * .0625);
                geometry.w = cast(int)(geometry.w * .875f);
                geometry.h = cast(int)(geometry.h * .875f);
                KW_SetWidgetGeometry(frame, &geometry);
            }
        }
        SDL_RenderClear(renderer);
        KW_ProcessEvents(gui);
        KW_Paint(gui);
        SDL_RenderPresent(renderer);
        SDL_Delay(1);
    }
    
    KW_ReleaseFont(driver, font);
    KW_Quit(gui);
    KW_ReleaseSurface(driver, set);
    SDL_Quit();

    return 0;
}
