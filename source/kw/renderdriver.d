module kw.renderdriver;

import kw.rect;
import kw.kwbool;

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

extern (C) @nogc nothrow:
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


