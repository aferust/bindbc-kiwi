module kw.widget;

import derelict.sdl2.sdl;

import kw.renderdriver;
import kw.kwbool;
import kw.gui;
import kw.rect;

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

extern (C) @nogc nothrow:
/* forward declarations of these */
//KW_RenderDriver * KW_GetRenderer(KW_GUI * gui);
KW_GUI * KW_GetGUI(const KW_Widget * widget);

alias KW_WidgetPaintFunction = void function(KW_Widget*, const KW_Rect *, void* data);
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
alias KW_OnTextInput = void function(KW_Widget * widget, const char * text);
alias KW_OnKeyDown = void function(KW_Widget * widget, SDL_Keycode sym, SDL_Scancode code);
alias KW_OnKeyUp = void function(KW_Widget * widget, SDL_Keycode sym, SDL_Scancode code);

/* widget internal events */
alias KW_OnGeometryChange = void function(KW_Widget * widget, const KW_Rect * newgeom, const KW_Rect * oldgeom);
alias KW_OnWidgetTilesetChange = void function(KW_Widget * widget);

alias KW_OnWidgetChildrenChange = void function(KW_Widget * widget, int what, KW_Widget * child);

KW_Widget * KW_CreateWidget(KW_GUI * gui, 
                          KW_Widget * parent, 
                          const KW_Rect * geometry,
                          KW_WidgetPaintFunction widgetpaint,
                          KW_WidgetDestroyFunction widgetdestroy,
                          void * data);

void KW_ReparentWidget(KW_Widget * widget, KW_Widget * parent);
KW_Widget * KW_GetWidgetParent(const KW_Widget * widget);
const(KW_Widget*)* KW_GetWidgetChildren(const KW_Widget * widget, uint * count); /// I am not sure about returning type of this
void * KW_GetWidgetData(const KW_Widget * widget, KW_WidgetPaintFunction paint);
void KW_SetWidgetUserData(KW_Widget * widget, void * userdata);
void * KW_GetWidgetUserData(const KW_Widget * widget);
void KW_DestroyWidget(KW_Widget * widget, int destroychildren);
KW_GUI * KW_GetWidgetGUI(const KW_Widget * widget);
KW_RenderDriver * KW_GetWidgetRenderer(const KW_Widget * widget);
KW_CustomRenderFunction KW_GetWidgetCustomRenderFunction(const KW_Widget * widget);
void KW_SetWidgetCustomRenderFunction(KW_Widget * widget, KW_CustomRenderFunction renderfunction);
void KW_SetWidgetGeometry(KW_Widget * widget, const KW_Rect * geometry);
void KW_GetWidgetGeometry(const KW_Widget * widget, KW_Rect * geometry);
const(KW_Rect*) KW_ReturnWidgetGeometry(const KW_Widget* widget);
void KW_GetWidgetAbsoluteGeometry(const KW_Widget* widget, KW_Rect * geometry);
void KW_GetWidgetComposedGeometry(const KW_Widget*  widget, KW_Rect * composed);
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
KW_bool KW_QueryWidgetHint(const KW_Widget * widget, int hint);
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
