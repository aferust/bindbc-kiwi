module app;

import core.stdc.stdlib;
import core.stdc.stdio;

import bindbc.sdl;
import bindbc.sdl.image;

import bindbc.kw;

// translated from: https://github.com/mobius3/KiWi/tree/master/examples/editbox
// you will need some resources from https://github.com/mobius3/KiWi/tree/master/examples/tileset to run the example

KW_Widget * e_box;
/* Callback for when the OK button is clicked */
KW_bool quit = KW_FALSE;
extern (C) void OKClicked(KW_Widget * widget, int b) {
    const(char*) text = KW_GetEditboxText(e_box);
    writeln(text.to!string);
    //quit = KW_TRUE;
}

int main() {
    
    if (loadLibs() != 0) return -1;
	
    /* Initialize SDL */
    SDL_Init(SDL_INIT_EVERYTHING);
    SDL_Window * window;
    SDL_Renderer * renderer;
    KW_Rect windowrect = { 0, 0, 320, 240 };
    SDL_CreateWindowAndRenderer(windowrect.w, windowrect.h, 0, &window, &renderer);
    SDL_SetRenderDrawColor(renderer, 100, 100, 200, 1);

    /* Initialize KiWi */
    KW_RenderDriver * driver = KW_CreateSDL2RenderDriver(renderer, window);
    KW_Surface * set = KW_LoadSurface(driver, "tileset.png");
    KW_GUI * gui = KW_Init(driver, set);

    /* Create the top-level framve */
    KW_Rect framerect = { x: 10, y: 10, w: 300, h: 220 };
    KW_RectCenterInParent(&windowrect, &framerect);
    KW_Widget * frame = KW_CreateFrame(gui, null, &framerect);

    /* Create the title, label and edibox widgets */
    KW_Rect titlerect = { x: 0, y: 10, w: 300, h: 30 };
    KW_Rect labelrect = { y: 100, w: 60, h: 30 };
    KW_Rect editboxrect = { y: 100, w: 100, h: 40 };
    KW_Rect*[] rects = [&labelrect, &editboxrect];
    uint[] weights = [ 1, 4 ];
    KW_RectFillParentHorizontally(&framerect, rects.ptr, weights.ptr, 2, 10, KW_RECT_ALIGN_MIDDLE);
    KW_CreateLabel(gui, frame, "Editbox example", &titlerect);
    KW_CreateLabel(gui, frame, "Label", &labelrect);
    e_box = KW_CreateEditbox(gui, frame, "Edit me!", &editboxrect);
    KW_Rect buttonrect = { x: 250, y: 170, w: 40, h: 40 };
    KW_Widget * okbutton = KW_CreateButtonAndLabel(gui, frame, "OK", &buttonrect);

    KW_OnMouseDown cb = cast(KW_OnMouseDown)(&OKClicked);
    KW_AddWidgetMouseDownHandler(okbutton, cb);

    /* Main loop */
    while (!SDL_QuitRequested() && !quit) {
        SDL_RenderClear(renderer);
        KW_ProcessEvents(gui);
        KW_Paint(gui);
        SDL_RenderPresent(renderer);
        SDL_Delay(1);
    }
  
    /* free stuff */
    KW_Quit(gui);
    KW_ReleaseSurface(driver, set);
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