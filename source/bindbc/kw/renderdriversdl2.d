module bindbc.kw.renderdriversdl2;

import bindbc.sdl;

import bindbc.kw.renderdriver;

version(BindKiwi_Static){
    extern (C) @nogc nothrow {
        KW_RenderDriver *KW_CreateSDL2RenderDriver(SDL_Renderer *renderer, SDL_Window *window);
        SDL_Renderer *KW_RenderDriverGetSDL2Renderer(KW_RenderDriver *driver);
        SDL_Window *KW_RenderDriverGetSDL2Window(KW_RenderDriver *driver);
    }
} else {
    extern (C) @nogc nothrow {
        alias pKW_CreateSDL2RenderDriver = KW_RenderDriver* function(SDL_Renderer*, SDL_Window*);
        alias pKW_RenderDriverGetSDL2Renderer = SDL_Renderer* function(KW_RenderDriver*);
        alias pKW_RenderDriverGetSDL2Window = SDL_Window* function(KW_RenderDriver*);
    }

    __gshared {
        pKW_CreateSDL2RenderDriver KW_CreateSDL2RenderDriver;
        pKW_RenderDriverGetSDL2Renderer KW_RenderDriverGetSDL2Renderer;
        pKW_RenderDriverGetSDL2Window KW_RenderDriverGetSDL2Window;
    }
}





