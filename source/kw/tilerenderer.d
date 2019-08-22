module kw.tilerenderer;

import kw.renderdriver;
import kw.kwbool;
import kw.rect;

__gshared const TILESIZE = 8;

extern (C) @nogc nothrow:
void KW_RenderTile(KW_RenderDriver * renderer, KW_Texture * tileset, int column, int line, int x, int y);
void KW_BlitTile(KW_RenderDriver * renderer, KW_Surface * dst, KW_Surface * tileset, int column, int line, int x, int y);
void KW_RenderTileFill(KW_RenderDriver * renderer, KW_Texture * tileset, int column, int line, int x, int y, int w, int h, KW_bool stretch);
void KW_BlitTileFill(KW_RenderDriver * renderer, KW_Surface * dst,  KW_Surface * tileset, int column, int line, int x, int y, int w, int h, KW_bool stretch);
void KW_RenderTileFrame(KW_RenderDriver * renderer, KW_Texture * tileset, int startcolumn, int startline, const KW_Rect * fillrect, KW_bool stretchcenter, KW_bool stretchsides);
void KW_BlitTileFrame(KW_RenderDriver * renderer, KW_Surface * dst, KW_Surface * tileset, int startcolumn, int startline, const KW_Rect * fillrect, KW_bool stretchcenter, KW_bool stretchsides);
KW_Texture * KW_CreateTileFrameTexture(KW_RenderDriver * renderer, KW_Surface * tileset, int startcolumn, int startline, int w, int h, KW_bool stretchcenter, KW_bool stretchsides);
KW_bool KW_IsTileStretchable(KW_RenderDriver * renderer, KW_Surface * tileset, int line, int column);
