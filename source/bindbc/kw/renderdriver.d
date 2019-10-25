module bindbc.kw.renderdriver;

import bindbc.kw.rect;
import bindbc.kw.kwbool;

struct KW_Texture {
    void * texture;
}

struct KW_Font {
    void * font;
}

struct KW_Surface {
    void * surface;
}

struct KW_Color {
    ubyte r;
    ubyte g;
    ubyte b;
    ubyte a;
}

enum /*KW_RenderDriver_TextStyle*/ {
    KW_TTF_STYLE_NORMAL        = 0x00,
    KW_TTF_STYLE_BOLD          = 0x01,
    KW_TTF_STYLE_ITALIC        = 0x02,
    KW_TTF_STYLE_UNDERLINE     = 0x04,
    KW_TTF_STYLE_STRIKETHROUGH = 0x08
}

struct KW_RenderDriver {
    KW_RenderCopyFunction        renderCopy;
    KW_RenderTextFunction        renderText;
    KW_RenderRectFunction        renderRect;
    KW_UTF8TextSizeFunction      utf8TextSize;
    KW_LoadFontFunction          loadFont;
    KW_LoadFontFromMemoryFunction loadFontFromMemory;
    KW_CreateTextureFunction     createTexture;
    KW_CreateSurfaceFunction     createSurface;
    KW_LoadTextureFunction       loadTexture;
    KW_LoadSurfaceFunction       loadSurface;

    KW_GetSurfaceExtentsFunction getSurfaceExtents;
    KW_GetTextureExtentsFunction getTextureExtents;
    KW_BlitSurfaceFunction       blitSurface;

    KW_GetViewportSizeFunction           getViewportSize;

    KW_ReleaseTextureFunction    releaseTexture;
    KW_ReleaseSurfaceFunction    releaseSurface;
    KW_ReleaseFontFunction       releaseFont;

    KW_SetClipRectFunction       setClipRect;
    KW_GetClipRectFunction       getClipRect;

    KW_GetPixelFunction          getPixel;

    KW_ReleaseDriverFunction     release;

    void * priv;
}

extern (C) @nogc nothrow {
    KW_Color KW_MultiplyColor(KW_Color color, float amount);
    alias KW_RenderCopyFunction = void function(KW_RenderDriver * driver, KW_Texture * src, const KW_Rect * clip, const KW_Rect * dstRect);
    alias KW_UTF8TextSizeFunction = void function(KW_RenderDriver * driver, KW_Font * font, const char * text, uint * width, uint * height);
    alias KW_RenderTextFunction = KW_Texture* function(KW_RenderDriver * driver, KW_Font * font, const char * text, KW_Color color, int style);
    alias KW_LoadFontFunction = KW_Font * function(KW_RenderDriver * driver, const char * fontFile, uint ptSize);
    alias KW_LoadFontFromMemoryFunction = KW_Font * function(KW_RenderDriver * driver, const void * fontMemory, ulong memSize, uint ptSize);
    alias KW_CreateTextureFunction = KW_Texture * function(KW_RenderDriver * driver, KW_Surface * src);
    alias KW_LoadTextureFunction = KW_Texture * function(KW_RenderDriver * driver, const char * file);

    alias KW_LoadSurfaceFunction = KW_Surface * function(KW_RenderDriver * driver, const char * file);
    alias KW_ReleaseTextureFunction = void function(KW_RenderDriver * driver, KW_Texture * texture);
    alias KW_ReleaseSurfaceFunction = void function(KW_RenderDriver * driver, KW_Surface * surface);
    alias KW_ReleaseFontFunction = void function(KW_RenderDriver * driver, KW_Font * font);
    alias KW_CreateSurfaceFunction = KW_Surface * function(KW_RenderDriver * driver, uint width, uint height);
    alias KW_GetSurfaceExtentsFunction = void function(KW_RenderDriver * driver, const KW_Surface * surface, uint * width, uint * height);
    alias KW_GetTextureExtentsFunction = void function(KW_RenderDriver * driver, KW_Texture * texture, uint * width, uint * height);
    alias KW_BlitSurfaceFunction = void function(KW_RenderDriver * driver, KW_Surface * src, const KW_Rect * srcRect, KW_Surface * dst, const KW_Rect * dstRect);
    alias KW_SetClipRectFunction = void function(KW_RenderDriver * driver, const KW_Rect * clip, int force);
    alias KW_GetClipRectFunction = KW_bool function(KW_RenderDriver * driver, KW_Rect * clip);
    alias KW_GetPixelFunction = uint function(KW_RenderDriver * driver, KW_Surface * surface, uint px, uint py);
    alias KW_RenderRectFunction = void function(KW_RenderDriver * driver, KW_Rect * rect, KW_Color color);
    alias KW_GetViewportSizeFunction = void function(KW_RenderDriver * driver, KW_Rect * rect);

    alias KW_ReleaseDriverFunction = void function(KW_RenderDriver * driver);
}

version(BindKiwi_Static){
    extern (C) @nogc nothrow {
        void KW_RenderRect(KW_RenderDriver * driver, KW_Rect * rect, KW_Color color);
        void KW_BlitSurface(KW_RenderDriver * driver, KW_Surface * src, const KW_Rect * srcRect, KW_Surface * dst, const KW_Rect * dstRect);
        KW_Surface * KW_CreateSurface(KW_RenderDriver * driver, uint width, uint height);
        void KW_GetSurfaceExtents(KW_RenderDriver * driver, const KW_Surface * surface, uint * width, uint * height);
        void KW_GetTextureExtents(KW_RenderDriver * driver, KW_Texture * texture, uint * width, uint * height);
        void KW_RenderCopy(KW_RenderDriver * driver, KW_Texture * src, const KW_Rect * clip, const KW_Rect * dstRect);
        KW_Texture * KW_RenderText(KW_RenderDriver * driver, KW_Font * font, const char * text, KW_Color color, int style);
        KW_Font * KW_LoadFont(KW_RenderDriver * driver, const char * fontFile, uint ptSize);
        KW_Font * KW_LoadFontFromMemory(KW_RenderDriver * driver, const void * fontMemory, ulong memSize, uint ptSize);
        KW_Texture * KW_CreateTexture(KW_RenderDriver * driver, KW_Surface * surface);
        KW_Texture * KW_LoadTexture(KW_RenderDriver * driver, const char * file);
        KW_Surface * KW_LoadSurface(KW_RenderDriver * driver, const char * file);
        void KW_ReleaseTexture(KW_RenderDriver * driver, KW_Texture * texture);
        void KW_ReleaseSurface(KW_RenderDriver * driver, KW_Surface * surface);
        void KW_ReleaseFont(KW_RenderDriver * driver, KW_Font * font);
        KW_bool KW_GetClipRect(KW_RenderDriver * driver, KW_Rect * clip);
        void KW_GetViewportSize(KW_RenderDriver * driver, KW_Rect * rect);
        void KW_SetClipRect(KW_RenderDriver * driver, const KW_Rect * clip, int force);
        void KW_ReleaseRenderDriver(KW_RenderDriver * driver);
        void KW_UTF8TextSize(KW_RenderDriver * driver, KW_Font * font, const char * text, uint * width, uint * height);
        uint KW_GetPixel(KW_RenderDriver * driver, KW_Surface * surface, uint x, uint y);
    }
} else {
    extern (C) @nogc nothrow {
        alias pKW_RenderRect = void function(KW_RenderDriver * driver, KW_Rect * rect, KW_Color color);
        alias pKW_BlitSurface = void function(KW_RenderDriver * driver, KW_Surface * src, const KW_Rect * srcRect, KW_Surface * dst, const KW_Rect * dstRect);
        alias pKW_CreateSurface = KW_Surface* function(KW_RenderDriver * driver, uint width, uint height);
        alias pKW_GetSurfaceExtents = void function(KW_RenderDriver * driver, const KW_Surface * surface, uint * width, uint * height);
        alias pKW_GetTextureExtents = void function(KW_RenderDriver * driver, KW_Texture * texture, uint * width, uint * height);
        alias pKW_RenderCopy = void function(KW_RenderDriver * driver, KW_Texture * src, const KW_Rect * clip, const KW_Rect * dstRect);
        alias pKW_RenderText = KW_Texture* function(KW_RenderDriver * driver, KW_Font * font, const char * text, KW_Color color, int style);
        alias pKW_LoadFont = KW_Font* function(KW_RenderDriver * driver, const char * fontFile, uint ptSize);
        alias pKW_LoadFontFromMemory = KW_Font* function(KW_RenderDriver * driver, const void * fontMemory, ulong memSize, uint ptSize);
        alias pKW_CreateTexture = KW_Texture* function(KW_RenderDriver * driver, KW_Surface * surface);
        alias pKW_LoadTexture = KW_Texture* function(KW_RenderDriver * driver, const char * file);
        alias pKW_LoadSurface = KW_Surface* function(KW_RenderDriver * driver, const char * file);
        alias pKW_ReleaseTexture = void function(KW_RenderDriver * driver, KW_Texture * texture);
        alias pKW_ReleaseSurface = void function(KW_RenderDriver * driver, KW_Surface * surface);
        alias pKW_ReleaseFont = void function(KW_RenderDriver * driver, KW_Font * font);
        alias pKW_GetClipRect = KW_bool function(KW_RenderDriver * driver, KW_Rect * clip);
        alias pKW_GetViewportSize = void function(KW_RenderDriver * driver, KW_Rect * rect);
        alias pKW_SetClipRect = void function(KW_RenderDriver * driver, const KW_Rect * clip, int force);
        alias pKW_ReleaseRenderDriver = void function(KW_RenderDriver * driver);
        alias pKW_UTF8TextSize = void function(KW_RenderDriver * driver, KW_Font * font, const char * text, uint * width, uint * height);
        alias pKW_GetPixel = uint function(KW_RenderDriver * driver, KW_Surface * surface, uint x, uint y);
    }
    __gshared {
        pKW_RenderRect KW_RenderRect;
        pKW_BlitSurface KW_BlitSurface;
        pKW_CreateSurface KW_CreateSurface;
        pKW_GetSurfaceExtents KW_GetSurfaceExtents;
        pKW_GetTextureExtents KW_GetTextureExtents;
        pKW_RenderCopy KW_RenderCopy;
        pKW_RenderText KW_RenderText;
        pKW_LoadFont KW_LoadFont;
        pKW_LoadFontFromMemory KW_LoadFontFromMemory;
        pKW_CreateTexture KW_CreateTexture;
        pKW_LoadTexture KW_LoadTexture;
        pKW_LoadSurface KW_LoadSurface;
        pKW_ReleaseTexture KW_ReleaseTexture;
        pKW_ReleaseSurface KW_ReleaseSurface;
        pKW_ReleaseFont KW_ReleaseFont;
        pKW_GetClipRect KW_GetClipRect;
        pKW_GetViewportSize KW_GetViewportSize;
        pKW_SetClipRect KW_SetClipRect;
        pKW_ReleaseRenderDriver KW_ReleaseRenderDriver;
        pKW_UTF8TextSize KW_UTF8TextSize;
        pKW_GetPixel KW_GetPixel;
    }
}

