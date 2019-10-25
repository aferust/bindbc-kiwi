module bindbc.kw.tilerenderer;

import bindbc.kw.renderdriver;
import bindbc.kw.kwbool;
import bindbc.kw.rect;

__gshared const TILESIZE = 8;

version(BindKiwi_Static){
    extern (C) @nogc nothrow {
        void KW_RenderTile(KW_RenderDriver * renderer, KW_Texture * tileset, int column, int line, int x, int y);
        void KW_BlitTile(KW_RenderDriver * renderer, KW_Surface * dst, KW_Surface * tileset, int column, int line, int x, int y);
        void KW_RenderTileFill(KW_RenderDriver * renderer, KW_Texture * tileset, int column, int line, int x, int y, int w, int h, KW_bool stretch);
        void KW_BlitTileFill(KW_RenderDriver * renderer, KW_Surface * dst,  KW_Surface * tileset, int column, int line, int x, int y, int w, int h, KW_bool stretch);
        void KW_RenderTileFrame(KW_RenderDriver * renderer, KW_Texture * tileset, int startcolumn, int startline, const(KW_Rect)* fillrect, KW_bool stretchcenter, KW_bool stretchsides);
        void KW_BlitTileFrame(KW_RenderDriver * renderer, KW_Surface * dst, KW_Surface * tileset, int startcolumn, int startline, const KW_Rect * fillrect, KW_bool stretchcenter, KW_bool stretchsides);
        KW_Texture * KW_CreateTileFrameTexture(KW_RenderDriver * renderer, KW_Surface * tileset, int startcolumn, int startline, int w, int h, KW_bool stretchcenter, KW_bool stretchsides);
        KW_bool KW_IsTileStretchable(KW_RenderDriver * renderer, KW_Surface * tileset, int line, int column);
    }
} else {
    extern (C) @nogc nothrow {
        alias pKW_RenderTile = void function(KW_RenderDriver * renderer, KW_Texture * tileset, int column, int line, int x, int y);
        alias pKW_BlitTile = void function(KW_RenderDriver * renderer, KW_Surface * dst, KW_Surface * tileset, int column, int line, int x, int y);
        alias pKW_RenderTileFill = void function(KW_RenderDriver * renderer, KW_Texture * tileset, int column, int line, int x, int y, int w, int h, KW_bool stretch);
        alias pKW_BlitTileFill = void function(KW_RenderDriver * renderer, KW_Surface * dst,  KW_Surface * tileset, int column, int line, int x, int y, int w, int h, KW_bool stretch);
        alias pKW_RenderTileFrame = void function(KW_RenderDriver * renderer, KW_Texture * tileset, int startcolumn, int startline, const(KW_Rect)* fillrect, KW_bool stretchcenter, KW_bool stretchsides);
        alias pKW_BlitTileFrame = void function(KW_RenderDriver * renderer, KW_Surface * dst, KW_Surface * tileset, int startcolumn, int startline, const KW_Rect * fillrect, KW_bool stretchcenter, KW_bool stretchsides);
        alias pKW_CreateTileFrameTexture = KW_Texture* function(KW_RenderDriver * renderer, KW_Surface * tileset, int startcolumn, int startline, int w, int h, KW_bool stretchcenter, KW_bool stretchsides);
        alias pKW_IsTileStretchable = KW_bool function(KW_RenderDriver * renderer, KW_Surface * tileset, int line, int column);
    }
    __gshared {
        pKW_RenderTile KW_RenderTile;
        pKW_BlitTile KW_BlitTile;
        pKW_RenderTileFill KW_RenderTileFill;
        pKW_BlitTileFill KW_BlitTileFill;
        pKW_RenderTileFrame KW_RenderTileFrame;
        pKW_BlitTileFrame KW_BlitTileFrame;
        pKW_CreateTileFrameTexture KW_CreateTileFrameTexture;
        pKW_IsTileStretchable KW_IsTileStretchable;
    }
}
