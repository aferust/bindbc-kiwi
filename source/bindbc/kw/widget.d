module bindbc.kw.widget;

import bindbc.sdl;

import bindbc.kw.renderdriver;
import bindbc.kw.kwbool;
import bindbc.kw.gui;
import bindbc.kw.rect;

struct KW_Widget;
struct KW_GUI;

enum /*KW_WidgetChildrenChangeEvent*/ {
    KW_CHILDRENCHANGE_ADDED,
    KW_CHILDRENCHANGE_REMOVED
}

enum /*KW_WidgetHint*/ {
    /** Allow widgets to stretch tiles */
    KW_WIDGETHINT_ALLOWTILESTRETCH = 1 << 0, 
    
    /** Makes KiWi avoid reporting input events to this widget and its children
    *  widget */
    KW_WIDGETHINT_BLOCKINPUTEVENTS = 1 << 1,
    
    /** Makes KiWi avoid reporting input event to this widget but still passes to
    * its children widgets */
    KW_WIDGETHINT_IGNOREINPUTEVENTS = 1 << 2,
    
    /** Hints widget implementations that, if possible, the user wants a
    * frameless version of it */
    KW_WIDGETHINT_FRAMELESS = 1 << 3,

    /** Makes KiWi not paint this widget */
    KW_WIDGETHINT_HIDDEN = 1 << 4,

    /** Makes KiWi draw debug information over this widget */
    KW_WIDGETHINT_DEBUG = 1 << 5
}

extern (C) @nogc nothrow {
    alias KW_WidgetPaintFunction = void function(KW_Widget*, const(KW_Rect)*, void* data);
    alias KW_WidgetDestroyFunction = void function (KW_Widget * widget);
    alias KW_CustomRenderFunction = KW_Texture* function(KW_RenderDriver * renderer, KW_Widget * widget, KW_Surface * tileset, int w, int h);

    /* mouse callbacks */
    alias KW_OnMouseOver = void function(KW_Widget * widget);
    alias KW_OnMouseLeave = void function(KW_Widget * widget);
    alias KW_OnMouseDown = void function(KW_Widget * widget, int button);
    alias KW_OnMouseUp = void function(KW_Widget * widget, int button);

    /* drag callbacks */
    alias KW_OnDragStart = void function(KW_Widget * widget, int x, int y);
    alias KW_OnDragStop = void function(KW_Widget * widget, int x, int y);
    alias KW_OnDrag = void function(KW_Widget * widget, int x, int y, int relx, int rely);

    /* focus callbacks */
    alias KW_OnFocusGain = void function(KW_Widget * widget);
    alias KW_OnFocusLose = void function(KW_Widget * widget);

    /* text and keyboard callbacks */
    alias KW_OnTextInput = void function(KW_Widget * widget, const(char)* text);
    alias KW_OnKeyDown = void function(KW_Widget * widget, SDL_Keycode sym, SDL_Scancode code);
    alias KW_OnKeyUp = void function(KW_Widget * widget, SDL_Keycode sym, SDL_Scancode code);

    /* widget internal events */
    alias KW_OnGeometryChange = void function(KW_Widget * widget, const(KW_Rect)* newgeom, const(KW_Rect)* oldgeom);
    alias KW_OnWidgetTilesetChange = void function(KW_Widget * widget);

    alias KW_OnWidgetChildrenChange = void function(KW_Widget * widget, int what, KW_Widget * child);
}

version(BindKiwi_Static){
    extern (C) @nogc nothrow {
        /* forward declarations of these */
        //KW_RenderDriver * KW_GetRenderer(KW_GUI * gui);
        KW_GUI * KW_GetGUI(const(KW_Widget)* widget);
        KW_Widget * KW_CreateWidget(KW_GUI * gui, 
                                KW_Widget * parent, 
                                const(KW_Rect)* geometry,
                                KW_WidgetPaintFunction widgetpaint,
                                KW_WidgetDestroyFunction widgetdestroy,
                                void * data);

        void KW_ReparentWidget(KW_Widget * widget, KW_Widget * parent);
        KW_Widget * KW_GetWidgetParent(const(KW_Widget)* widget);
        const(KW_Widget)** KW_GetWidgetChildren(const(KW_Widget)* widget, uint * count); /// I am not sure about returning type of this
        void * KW_GetWidgetData(const(KW_Widget)* widget, KW_WidgetPaintFunction paint);
        void KW_SetWidgetUserData(KW_Widget * widget, void * userdata);
        void * KW_GetWidgetUserData(const(KW_Widget)* widget);
        void KW_DestroyWidget(KW_Widget * widget, int destroychildren);
        KW_GUI * KW_GetWidgetGUI(const(KW_Widget)* widget);
        KW_RenderDriver * KW_GetWidgetRenderer(const(KW_Widget)* widget);
        KW_CustomRenderFunction KW_GetWidgetCustomRenderFunction(const(KW_Widget)* widget);
        void KW_SetWidgetCustomRenderFunction(KW_Widget * widget, KW_CustomRenderFunction renderfunction);
        void KW_SetWidgetGeometry(KW_Widget * widget, const(KW_Rect)* geometry);
        void KW_GetWidgetGeometry(const(KW_Widget)* widget, KW_Rect * geometry);
        const(KW_Rect)* KW_ReturnWidgetGeometry(const(KW_Widget)* widget);
        void KW_GetWidgetAbsoluteGeometry(const(KW_Widget)* widget, KW_Rect * geometry);
        void KW_GetWidgetComposedGeometry(const(KW_Widget)*  widget, KW_Rect * composed);
        void KW_PaintWidget(KW_Widget * widget);
        void KW_BringToFront(KW_Widget * widget);
        void KW_SetFocusedWidget(KW_Widget * widget);
        void KW_HideWidget(KW_Widget * widget);
        void KW_ShowWidget(KW_Widget * widget);
        KW_bool KW_IsWidgetHidden(KW_Widget * widget);
        void KW_EnableWidgetDebug(KW_Widget * widget, KW_bool enableInChildren);
        void KW_DisableWidgetDebug(KW_Widget * widget, KW_bool disableInChildren);
        KW_bool KW_IsDebugWidgetEnabled(KW_Widget * widget);
        void KW_BlockWidgetInputEvents(KW_Widget * widget);
        void KW_UnblockWidgetInputEvents(KW_Widget * widget);
        KW_bool KW_IsWidgetInputEventsBlocked(KW_Widget * widget);

        void KW_EnableWidgetHint(KW_Widget * widget, int hint, KW_bool down);
        void KW_DisableWidgetHint(KW_Widget * widget, int hint, KW_bool down);
        KW_bool KW_QueryWidgetHint(const(KW_Widget)* widget, int hint);
        void KW_AddWidgetMouseOverHandler(KW_Widget * widget, KW_OnMouseOver handler);
        void KW_RemoveWidgetMouseOverHandler(KW_Widget * widget, KW_OnMouseOver handler);
        void KW_AddWidgetMouseLeaveHandler(KW_Widget * widget, KW_OnMouseLeave handler);
        void KW_RemoveWidgetMouseLeaveHandler(KW_Widget * widget, KW_OnMouseLeave handler);
        void KW_AddWidgetMouseDownHandler(KW_Widget * widget, KW_OnMouseDown handler);
        void KW_RemoveWidgetMouseDownHandler(KW_Widget * widget, KW_OnMouseDown handler);
        void KW_AddWidgetMouseUpHandler(KW_Widget * widget, KW_OnMouseUp handler);
        void KW_RemoveWidgetMouseUpHandler(KW_Widget * widget, KW_OnMouseUp handler);
        void KW_AddWidgetFocusGainHandler(KW_Widget * widget, KW_OnFocusGain handler);
        void KW_RemoveWidgetFocusGainHandler(KW_Widget * widget, KW_OnFocusGain handler);
        void KW_AddWidgetFocusLoseHandler(KW_Widget * widget, KW_OnFocusLose handler);
        void KW_RemoveWidgetFocusLoseHandler(KW_Widget * widget, KW_OnFocusLose handler);
        void KW_AddWidgetTextInputHandler(KW_Widget * widget, KW_OnTextInput handler);
        void KW_RemoveWidgetTextInputHandler(KW_Widget * widget, KW_OnTextInput handler);
        void KW_AddWidgetKeyDownHandler(KW_Widget * widget, KW_OnKeyDown handler);
        void KW_RemoveWidgetKeyDownHandler(KW_Widget * widget, KW_OnKeyDown handler);
        void KW_AddWidgetKeyUpHandler(KW_Widget * widget, KW_OnKeyUp handler);
        void KW_RemoveWidgetKeyUpHandler(KW_Widget * widget, KW_OnKeyUp handler);
        void KW_AddWidgetDragStartHandler(KW_Widget * widget, KW_OnDragStart handler);
        void KW_RemoveWidgetDragStartHandler(KW_Widget * widget, KW_OnDragStart handler);
        void KW_AddWidgetDragStopHandler(KW_Widget * widget, KW_OnDragStop handler);
        void KW_RemoveWidgetDragStopHandler(KW_Widget * widget, KW_OnDragStop handler);
        void KW_AddWidgetDragHandler(KW_Widget * widget, KW_OnDrag handler);
        void KW_AddWidgetGeometryChangeHandler(KW_Widget * widget, KW_OnGeometryChange handler);
        void KW_RemoveWidgetGeometryChangeHandler(KW_Widget * widget, KW_OnGeometryChange handler);
        void KW_AddWidgetChildrenChangeHandler(KW_Widget * widget, KW_OnWidgetChildrenChange handler);
        void KW_RemoveWidgetChildrenChangeHandler(KW_Widget * widget, KW_OnWidgetChildrenChange handler);
        void KW_RemoveWidgetDragHandler(KW_Widget * widget, KW_OnDrag handler);
        void KW_AddWidgetTilesetChangeHandler(KW_Widget * widget, KW_OnWidgetTilesetChange handler);
        void KW_RemoveWidgetTilesetChangeHandler(KW_Widget * widget, KW_OnWidgetTilesetChange handler);
        void KW_SetWidgetTilesetSurface(KW_Widget * widget, KW_Surface * tileset);
        KW_Texture * KW_GetWidgetTilesetTexture(KW_Widget * widget);
        KW_Surface * KW_GetWidgetTilesetSurface(KW_Widget * widget);
        KW_bool KW_IsCursorOverWidget(KW_Widget * widget);
        KW_bool KW_IsCursorReleasedOnWidget(KW_Widget * widget);
    }
} else {
    extern (C) @nogc nothrow {
        alias pKW_GetGUI = KW_GUI* function(const(KW_Widget)* widget);
        alias pKW_CreateWidget = KW_Widget* function(KW_GUI * gui, 
                                KW_Widget* parent, 
                                const(KW_Rect)* geometry,
                                KW_WidgetPaintFunction widgetpaint,
                                KW_WidgetDestroyFunction widgetdestroy,
                                void* data);

        alias pKW_ReparentWidget = void function(KW_Widget * widget, KW_Widget * parent);
        alias pKW_GetWidgetParent = KW_Widget* function(const(KW_Widget)* widget);
        alias pKW_GetWidgetChildren = const(KW_Widget)** function(const(KW_Widget)* widget, uint * count); /// I am not sure about returning type of this
        alias pKW_GetWidgetData = void* function(const(KW_Widget)* widget, KW_WidgetPaintFunction paint);
        alias pKW_SetWidgetUserData = void function(KW_Widget * widget, void * userdata);
        alias pKW_GetWidgetUserData = void * function(const(KW_Widget)* widget);
        alias pKW_DestroyWidget = void function(KW_Widget * widget, int destroychildren);
        alias pKW_GetWidgetGUI = KW_GUI * function(const(KW_Widget)* widget);
        alias pKW_GetWidgetRenderer = KW_RenderDriver * function(const(KW_Widget)* widget);
        alias pKW_GetWidgetCustomRenderFunction = KW_CustomRenderFunction function(const(KW_Widget)* widget);
        alias pKW_SetWidgetCustomRenderFunction = void function(KW_Widget * widget, KW_CustomRenderFunction renderfunction);
        alias pKW_SetWidgetGeometry = void function(KW_Widget * widget, const(KW_Rect)* geometry);
        alias pKW_GetWidgetGeometry = void function(const(KW_Widget)* widget, KW_Rect * geometry);
        alias pKW_ReturnWidgetGeometry = const(KW_Rect)* function(const(KW_Widget)* widget);
        alias pKW_GetWidgetAbsoluteGeometry = void function(const(KW_Widget)* widget, KW_Rect * geometry);
        alias pKW_GetWidgetComposedGeometry = void function(const(KW_Widget)*  widget, KW_Rect * composed);
        alias pKW_PaintWidget = void function(KW_Widget * widget);
        alias pKW_BringToFront = void function(KW_Widget * widget);
        alias pKW_SetFocusedWidget = void function(KW_Widget * widget);
        alias pKW_HideWidget = void function(KW_Widget * widget);
        alias pKW_ShowWidget = void function(KW_Widget * widget);
        alias pKW_IsWidgetHidden = KW_bool function(KW_Widget * widget);
        alias pKW_EnableWidgetDebug = void function(KW_Widget * widget, KW_bool enableInChildren);
        alias pKW_DisableWidgetDebug = void function(KW_Widget * widget, KW_bool disableInChildren);
        alias pKW_IsDebugWidgetEnabled = KW_bool function(KW_Widget * widget);
        alias pKW_BlockWidgetInputEvents = void function(KW_Widget * widget);
        alias pKW_UnblockWidgetInputEvents = void function(KW_Widget * widget);
        alias pKW_IsWidgetInputEventsBlocked = KW_bool function(KW_Widget * widget);

        alias pKW_EnableWidgetHint = void function(KW_Widget * widget, int hint, KW_bool down);
        alias pKW_DisableWidgetHint = void function(KW_Widget * widget, int hint, KW_bool down);
        alias pKW_QueryWidgetHint = KW_bool function(const(KW_Widget)* widget, int hint);
        alias pKW_AddWidgetMouseOverHandler = void function(KW_Widget * widget, KW_OnMouseOver handler);
        alias pKW_RemoveWidgetMouseOverHandler = void function(KW_Widget * widget, KW_OnMouseOver handler);
        alias pKW_AddWidgetMouseLeaveHandler = void function(KW_Widget * widget, KW_OnMouseLeave handler);
        alias pKW_RemoveWidgetMouseLeaveHandler = void function(KW_Widget * widget, KW_OnMouseLeave handler);
        alias pKW_AddWidgetMouseDownHandler = void function(KW_Widget * widget, KW_OnMouseDown handler);
        alias pKW_RemoveWidgetMouseDownHandler = void function(KW_Widget * widget, KW_OnMouseDown handler);
        alias pKW_AddWidgetMouseUpHandler = void function(KW_Widget * widget, KW_OnMouseUp handler);
        alias pKW_RemoveWidgetMouseUpHandler = void function(KW_Widget * widget, KW_OnMouseUp handler);
        alias pKW_AddWidgetFocusGainHandler = void function(KW_Widget * widget, KW_OnFocusGain handler);
        alias pKW_RemoveWidgetFocusGainHandler = void function(KW_Widget * widget, KW_OnFocusGain handler);
        alias pKW_AddWidgetFocusLoseHandler = void function(KW_Widget * widget, KW_OnFocusLose handler);
        alias pKW_RemoveWidgetFocusLoseHandler = void function(KW_Widget * widget, KW_OnFocusLose handler);
        alias pKW_AddWidgetTextInputHandler = void function(KW_Widget * widget, KW_OnTextInput handler);
        alias pKW_RemoveWidgetTextInputHandler = void function(KW_Widget * widget, KW_OnTextInput handler);
        alias pKW_AddWidgetKeyDownHandler = void function(KW_Widget * widget, KW_OnKeyDown handler);
        alias pKW_RemoveWidgetKeyDownHandler = void function(KW_Widget * widget, KW_OnKeyDown handler);
        alias pKW_AddWidgetKeyUpHandler = void function(KW_Widget * widget, KW_OnKeyUp handler);
        alias pKW_RemoveWidgetKeyUpHandler = void function(KW_Widget * widget, KW_OnKeyUp handler);
        alias pKW_AddWidgetDragStartHandler = void function(KW_Widget * widget, KW_OnDragStart handler);
        alias pKW_RemoveWidgetDragStartHandler = void function(KW_Widget * widget, KW_OnDragStart handler);
        alias pKW_AddWidgetDragStopHandler = void function(KW_Widget * widget, KW_OnDragStop handler);
        alias pKW_RemoveWidgetDragStopHandler = void function(KW_Widget * widget, KW_OnDragStop handler);
        alias pKW_AddWidgetDragHandler = void function(KW_Widget * widget, KW_OnDrag handler);
        alias pKW_AddWidgetGeometryChangeHandler = void function(KW_Widget * widget, KW_OnGeometryChange handler);
        alias pKW_RemoveWidgetGeometryChangeHandler = void function(KW_Widget * widget, KW_OnGeometryChange handler);
        alias pKW_AddWidgetChildrenChangeHandler = void function(KW_Widget * widget, KW_OnWidgetChildrenChange handler);
        alias pKW_RemoveWidgetChildrenChangeHandler = void function(KW_Widget * widget, KW_OnWidgetChildrenChange handler);
        alias pKW_RemoveWidgetDragHandler = void function(KW_Widget * widget, KW_OnDrag handler);
        alias pKW_AddWidgetTilesetChangeHandler = void function(KW_Widget * widget, KW_OnWidgetTilesetChange handler);
        alias pKW_RemoveWidgetTilesetChangeHandler = void function(KW_Widget * widget, KW_OnWidgetTilesetChange handler);
        alias pKW_SetWidgetTilesetSurface = void function(KW_Widget * widget, KW_Surface * tileset);
        alias pKW_GetWidgetTilesetTexture = KW_Texture * function(KW_Widget * widget);
        alias pKW_GetWidgetTilesetSurface = KW_Surface * function(KW_Widget * widget);
        alias pKW_IsCursorOverWidget = KW_bool function(KW_Widget * widget);
        alias pKW_IsCursorReleasedOnWidget = KW_bool function(KW_Widget * widget);
    }

    __gshared {
        pKW_GetGUI KW_GetGUI;
        pKW_CreateWidget KW_CreateWidget;
        pKW_ReparentWidget KW_ReparentWidget;
        pKW_GetWidgetParent KW_GetWidgetParent;
        pKW_GetWidgetChildren KW_GetWidgetChildren;
        pKW_GetWidgetData KW_GetWidgetData;
        pKW_SetWidgetUserData KW_SetWidgetUserData;
        pKW_GetWidgetUserData KW_GetWidgetUserData;
        pKW_DestroyWidget KW_DestroyWidget;
        pKW_GetWidgetGUI KW_GetWidgetGUI;
        pKW_GetWidgetRenderer KW_GetWidgetRenderer;
        pKW_GetWidgetCustomRenderFunction KW_GetWidgetCustomRenderFunction;
        pKW_SetWidgetCustomRenderFunction KW_SetWidgetCustomRenderFunction;
        pKW_SetWidgetGeometry KW_SetWidgetGeometry;
        pKW_GetWidgetGeometry KW_GetWidgetGeometry;
        pKW_ReturnWidgetGeometry KW_ReturnWidgetGeometry;
        pKW_GetWidgetAbsoluteGeometry KW_GetWidgetAbsoluteGeometry;
        pKW_GetWidgetComposedGeometry KW_GetWidgetComposedGeometry;
        pKW_PaintWidget KW_PaintWidget;
        pKW_BringToFront KW_BringToFront;
        pKW_SetFocusedWidget KW_SetFocusedWidget;
        pKW_HideWidget KW_HideWidget;
        pKW_ShowWidget KW_ShowWidget;
        pKW_IsWidgetHidden KW_IsWidgetHidden;
        pKW_EnableWidgetDebug KW_EnableWidgetDebug;
        pKW_DisableWidgetDebug KW_DisableWidgetDebug;
        pKW_IsDebugWidgetEnabled KW_IsDebugWidgetEnabled;
        pKW_BlockWidgetInputEvents KW_BlockWidgetInputEvents;
        pKW_UnblockWidgetInputEvents KW_UnblockWidgetInputEvents;
        pKW_IsWidgetInputEventsBlocked KW_IsWidgetInputEventsBlocked;
        pKW_EnableWidgetHint KW_EnableWidgetHint;
        pKW_DisableWidgetHint KW_DisableWidgetHint;
        pKW_QueryWidgetHint KW_QueryWidgetHint;
        pKW_AddWidgetMouseOverHandler KW_AddWidgetMouseOverHandler;
        pKW_RemoveWidgetMouseOverHandler KW_RemoveWidgetMouseOverHandler;
        pKW_AddWidgetMouseLeaveHandler KW_AddWidgetMouseLeaveHandler;
        pKW_RemoveWidgetMouseLeaveHandler KW_RemoveWidgetMouseLeaveHandler;
        pKW_AddWidgetMouseDownHandler KW_AddWidgetMouseDownHandler;
        pKW_RemoveWidgetMouseDownHandler KW_RemoveWidgetMouseDownHandler;
        pKW_AddWidgetMouseUpHandler KW_AddWidgetMouseUpHandler;
        pKW_RemoveWidgetMouseUpHandler KW_RemoveWidgetMouseUpHandler;
        pKW_AddWidgetFocusGainHandler KW_AddWidgetFocusGainHandler;
        pKW_RemoveWidgetFocusGainHandler KW_RemoveWidgetFocusGainHandler;
        pKW_AddWidgetFocusLoseHandler KW_AddWidgetFocusLoseHandler;
        pKW_RemoveWidgetFocusLoseHandler KW_RemoveWidgetFocusLoseHandler;
        pKW_AddWidgetTextInputHandler KW_AddWidgetTextInputHandler;
        pKW_RemoveWidgetTextInputHandler KW_RemoveWidgetTextInputHandler;
        pKW_AddWidgetKeyDownHandler KW_AddWidgetKeyDownHandler;
        pKW_RemoveWidgetKeyDownHandler KW_RemoveWidgetKeyDownHandler;
        pKW_AddWidgetKeyUpHandler KW_AddWidgetKeyUpHandler;
        pKW_RemoveWidgetKeyUpHandler KW_RemoveWidgetKeyUpHandler;
        pKW_AddWidgetDragStartHandler KW_AddWidgetDragStartHandler;
        pKW_RemoveWidgetDragStartHandler KW_RemoveWidgetDragStartHandler;
        pKW_AddWidgetDragStopHandler KW_AddWidgetDragStopHandler;
        pKW_RemoveWidgetDragStopHandler KW_RemoveWidgetDragStopHandler;
        pKW_AddWidgetDragHandler KW_AddWidgetDragHandler;
        pKW_AddWidgetGeometryChangeHandler KW_AddWidgetGeometryChangeHandler;
        pKW_RemoveWidgetGeometryChangeHandler KW_RemoveWidgetGeometryChangeHandler;
        pKW_AddWidgetChildrenChangeHandler KW_AddWidgetChildrenChangeHandler;
        pKW_RemoveWidgetChildrenChangeHandler KW_RemoveWidgetChildrenChangeHandler;
        pKW_RemoveWidgetDragHandler KW_RemoveWidgetDragHandler;
        pKW_AddWidgetTilesetChangeHandler KW_AddWidgetTilesetChangeHandler;
        pKW_RemoveWidgetTilesetChangeHandler KW_RemoveWidgetTilesetChangeHandler;
        pKW_SetWidgetTilesetSurface KW_SetWidgetTilesetSurface;
        pKW_GetWidgetTilesetTexture KW_GetWidgetTilesetTexture;
        pKW_GetWidgetTilesetSurface KW_GetWidgetTilesetSurface;
        pKW_IsCursorOverWidget KW_IsCursorOverWidget;
        pKW_IsCursorReleasedOnWidget KW_IsCursorReleasedOnWidget;
    }
}
