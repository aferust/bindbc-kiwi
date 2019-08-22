module kw.renderdriversdl2;

import derelict.sdl2.sdl;

import kw.renderdriver;

extern (C) @nogc nothrow:
KW_RenderDriver *KW_CreateSDL2RenderDriver(SDL_Renderer *renderer, SDL_Window *window);
SDL_Renderer *KW_RenderDriverGetSDL2Renderer(KW_RenderDriver *driver);
SDL_Window *KW_RenderDriverGetSDL2Window(KW_RenderDriver *driver);





