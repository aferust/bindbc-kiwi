module bindbc.kw.rect;

struct KW_Rect {
    int x;
    int y;
    int w;
    int h;
}

enum /*KW_RectVerticalAlignment*/{
    KW_RECT_ALIGN_VERTICALLY_NONE,    /** Do not align vertically. */
    KW_RECT_ALIGN_TOP,     /** Top align the rectangles */
    KW_RECT_ALIGN_MIDDLE,  /** Make the rectangles centralized on a horizontal lign  */
    KW_RECT_ALIGN_BOTTOM   /** Bottom align the rectangles */
}

enum /*KW_RectHorizontalAlignment*/ {
    KW_RECT_ALIGN_HORIZONTALLY_NONE,  /* Do not align horizontally */
    KW_RECT_ALIGN_LEFT,    /** Left align the rectangles */
    KW_RECT_ALIGN_CENTER,  /** Make the rectangles centralized on a vertical lign */
    KW_RECT_ALIGN_RIGHT    /** Right align the rectangles */
}

version(BindKiwi_Static){
    extern (C) @nogc nothrow {
        void KW_RectCenterInParent(const KW_Rect * outer, KW_Rect * inner);
        void KW_RectVerticallyCenterInParent(const KW_Rect * outer, KW_Rect * inner);
        void KW_RectHorizontallyCenterInParent(const KW_Rect * outer, KW_Rect * inner);
        void KW_RectLayoutVertically(KW_Rect** rects, uint count, int padding, int _align);
        void KW_RectLayoutHorizontally(KW_Rect** rects, uint count, int padding, int _align);
        void KW_RectFillParentVertically(const KW_Rect* outer, KW_Rect**  rects, uint* weights, uint count, int padding);
        void KW_RectFillParentHorizontally(const KW_Rect* outer, KW_Rect**  rects, uint* weights, uint count,
                                                    int padding, int _align);
        void KW_RectCalculateEnclosingRect(const KW_Rect**  rects, uint count, KW_Rect * outer);
        void KW_SetRect(KW_Rect * rect, int x, int y, int w, int h);
        void KW_CopyRect(const KW_Rect * src, KW_Rect * dst);
        void KW_ZeroRect(KW_Rect * rect);
        void KW_MarginRect(const KW_Rect * outer, KW_Rect * inner, int margin);
    }
} else {
    extern (C) @nogc nothrow {
        alias pKW_RectCenterInParent = void function(const KW_Rect* outer, KW_Rect * inner);
        alias pKW_RectVerticallyCenterInParent = void function(const KW_Rect* outer, KW_Rect * inner);
        alias pKW_RectHorizontallyCenterInParent = void function(const KW_Rect* outer, KW_Rect * inner);
        alias pKW_RectLayoutVertically = void function(KW_Rect** rects, uint count, int padding, int _align);
        alias pKW_RectLayoutHorizontally = void function(KW_Rect** rects, uint count, int padding, int _align);
        alias pKW_RectFillParentVertically = void function(const KW_Rect* outer, KW_Rect**  rects, uint* weights, uint count, int padding);
        alias pKW_RectFillParentHorizontally = void function(const KW_Rect* outer, KW_Rect**  rects, uint* weights, uint count,
                                                    int padding, int _align);
        alias pKW_RectCalculateEnclosingRect = void function(const KW_Rect**  rects, uint count, KW_Rect * outer);
        alias pKW_SetRect = void function(KW_Rect * rect, int x, int y, int w, int h);
        alias pKW_CopyRect = void function(const KW_Rect* src, KW_Rect * dst);
        alias pKW_ZeroRect = void function(KW_Rect * rect);
        alias pKW_MarginRect = void function(const KW_Rect* outer, KW_Rect * inner, int margin);
    }

    __gshared {
        pKW_RectCenterInParent KW_RectCenterInParent;
        pKW_RectVerticallyCenterInParent KW_RectVerticallyCenterInParent;
        pKW_RectHorizontallyCenterInParent KW_RectHorizontallyCenterInParent;
        pKW_RectLayoutVertically KW_RectLayoutVertically;
        pKW_RectLayoutHorizontally KW_RectLayoutHorizontally;
        pKW_RectFillParentVertically KW_RectFillParentVertically;
        pKW_RectFillParentHorizontally KW_RectFillParentHorizontally;
        pKW_RectCalculateEnclosingRect KW_RectCalculateEnclosingRect;
        pKW_SetRect KW_SetRect;
        pKW_CopyRect KW_CopyRect;
        pKW_ZeroRect KW_ZeroRect;
        pKW_MarginRect KW_MarginRect;
    }
}