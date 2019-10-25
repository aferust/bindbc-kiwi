module app;

import core.stdc.stdlib;
import core.stdc.stdio;

import bindbc.sdl;
import bindbc.sdl.image;

import bindbc.kw;

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

    if (loadLibs() != 0) return -1;

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