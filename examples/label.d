module app;

import core.stdc.stdlib;

import std.stdio;
import std.conv;
import std.string;

import derelict.sdl2.sdl;
import derelict.sdl2.image;

import kw;

// translated from: https://github.com/mobius3/KiWi/blob/master/examples/label/label.c
// you will need some resources from https://github.com/mobius3/KiWi/tree/master/examples/tileset to run the example

int main()
{
    DerelictSDL2.load();
    DerelictSDL2Image.load();
    
    SDL_Init(SDL_INIT_EVERYTHING);
    SDL_Renderer * renderer;
    SDL_Window * window;
    SDL_CreateWindowAndRenderer(320, 240, 0, &window, &renderer);
    SDL_SetRenderDrawColor(renderer, 100, 100, 100, 1); /* pretty background */
    
    /* Now we are going to use the SDL2 Render Driver. Users can implement their own
    * render driver, as long as it complies to the KW_RenderDriver structure */
    KW_RenderDriver * driver = KW_CreateSDL2RenderDriver(renderer, window);

    /* Loads the "tileset.png" file as a surface */
    KW_Surface * set = KW_LoadSurface(driver, "tileset.png");

    /* At this point we can create the GUI. You can have multiple GUI instances
    * in the same window (or even different windows, its up to the Render Driver) */
    KW_GUI * gui = KW_Init(driver, set);

    /* Loads a font and sets it. KiWi does not manage foreign memory (it does not own
    * your pointers), so you must keep them to release later. */
    KW_Font * font = KW_LoadFont(driver, "Fontin-Regular.ttf", 12);
    KW_SetFont(gui, font);

    /* Define a geometry and create a frame */
    KW_Rect geometry = { x: 0, y: 0, w: 320, h: 240 };
    KW_Widget * frame = KW_CreateFrame(gui, null, &geometry);

    /* Now create a label that has the frame as the parent, reutilizing
    * the same geometry. Children widgets offset they x and y coordinates by their parent. */
    KW_Widget * label = KW_CreateLabel(gui, frame, "Label with an icon :)", &geometry);

    /* Sets the rect in the tileset to extract the icon from, and sets it in the label */
    KW_Rect iconrect = { x: 0, y: 48, w: 24, h: 24 };
    KW_SetLabelIcon(label, &iconrect);

    /* Just call KW_Paint(gui) in your game loop. */
    while (!SDL_QuitRequested()) {
        SDL_RenderClear(renderer);
        KW_ProcessEvents(gui);
        KW_Paint(gui);
        SDL_Delay(1);
        SDL_RenderPresent(renderer);
    }

    /* All widgets are free'd after a KW_Quit */
    KW_Quit(gui);

    /* Releases things */
    KW_ReleaseSurface(driver, set);
    KW_ReleaseFont(driver, font);
    KW_ReleaseRenderDriver(driver);
    SDL_Quit();
    
    return 0;
}
