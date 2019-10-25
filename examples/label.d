module app;

import core.stdc.stdlib;
import core.stdc.stdio;

import bindbc.sdl;
import bindbc.sdl.image;

import bindbc.kw;

// translated from: https://github.com/mobius3/KiWi/blob/master/examples/label/label.c
// you will need some resources from https://github.com/mobius3/KiWi/tree/master/examples/tileset to run the example

int main()
{
    if (loadLibs() != 0) return -1;
    
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

int loadLibs(){
    SDLSupport ret = loadSDL();
	if(ret != sdlSupport) {
		// Handle error. For most use cases, this is enough. The error handling API in
		// bindbc-loader can be used for error messages. If necessary, it's  possible
		// to determine the primary cause programmtically:

		if(ret == SDLSupport.noLibrary) {
			// SDL shared library failed to load
			printf("SDL shared library failed to load!!! \n");
			return -1;
		}
		else if(SDLSupport.badLibrary) {
			// One or more symbols failed to load. The likely cause is that the
			// shared library is for a lower version than bindbc-sdl was configured
			// to load (via SDL_201, SDL_202, etc.)
			printf("One or more symbols failed to load!!! \n");
			return -1;
		}
	}
	SDLImageSupport rsdlim = loadSDLImage();
	if(rsdlim != sdlImageSupport) {
		
		if(ret == SDLSupport.noLibrary) {
			// SDL shared library failed to load
			printf("SDL Image shared library failed to load!!! \n");
			return -1;
		}
		else if(SDLSupport.badLibrary) {
			// One or more symbols failed to load. The likely cause is that the
			// shared library is for a lower version than bindbc-sdl was configured
			// to load (via SDL_201, SDL_202, etc.)
			printf("SDL Image: One or more symbols failed to load!!! \n");
			return -1;
		}
		

	}


	import loader = bindbc.loader.sharedlib;
    import std.stdio;

	KiwiSupport retkiwi = loadKiwi();
	if(retkiwi != KiwiSupport.kiwi) {
		foreach(info; loader.errors) {
            // A hypothetical logging routine
            writeln(info);
        }
		if(retkiwi == KiwiSupport.noLibrary) {
			// SDL shared library failed to load
			printf("KiWi shared library failed to load!!! \n");
			return -1;
		}
		else if(KiwiSupport.badLibrary) {
			// One or more symbols failed to load. The likely cause is that the
			// shared library is for a lower version than bindbc-sdl was configured
			// to load (via SDL_201, SDL_202, etc.)
			printf("KiWi: One or more symbols failed to load!!! \n");
			return -1;
		}
		

	}
    return 0;
}