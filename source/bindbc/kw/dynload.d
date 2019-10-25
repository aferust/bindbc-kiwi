module bindbc.kw.dynload;

import bindbc.kw.button;
import bindbc.kw.checkbox;
import bindbc.kw.editbox;
import bindbc.kw.frame;
import bindbc.kw.gui;
import bindbc.kw.label;
import bindbc.kw.rect;
import bindbc.kw.renderdriver;
import bindbc.kw.renderdriversdl2;
import bindbc.kw.scrollbox;
import bindbc.kw.tilerenderer;
import bindbc.kw.toggle;
import bindbc.kw.widget;

version(BindKiwi_Static) {}
else version = BindKiwi_Dynamic;

version(BindKiwi_Dynamic):

import bindbc.loader;

private {
    SharedLib lib;
    KiwiSupport loadedVersion;
}

enum KiwiSupport {
    noLibrary,
    badLibrary,
    kiwi
}

void unloadKiwi()
{
    if(lib != invalidHandle) {
        lib.unload();
    }
}

KiwiSupport loadedKiwiVersion() { return loadedVersion; }

bool isKiwiLoaded() { return lib != invalidHandle; }

KiwiSupport loadKiwi()
{
    version(Windows) {
        const(char)[][1] libNames = ["KiWi.dll"];
    }
    else version(OSX) {
        const(char)[][3] libNames = [
            "../Frameworks/KiWi.framework/KiWi",
            "/Library/Frameworks/KiWi.framework/KiWi",
            "/System/Library/Frameworks/KiWi.framework/KiWi"
        ];
    }
    else version(Posix) {
        const(char)[][1] libNames = [
            "KiWi.so"
        ];
    }
    else static assert(0, "bindbc-kiwi is not yet supported on this platform");
    
    KiwiSupport ret;
    foreach(name; libNames) {
        ret = loadKiwi(name.ptr);
        if(ret != KiwiSupport.noLibrary) break;
    }
    return ret;
}

KiwiSupport loadKiwi(const(char)* libName)
{
    // If the library isn't yet loaded, load it now.
    if(lib == invalidHandle) {
        lib = load(libName);
        if(lib == invalidHandle) {
            return KiwiSupport.noLibrary;
        }
    }

    auto errCount = errorCount();

    lib.bindSymbol(cast(void**)&KW_CreateButton, "KW_CreateButton");
    lib.bindSymbol(cast(void**)&KW_CreateButtonAndLabel, "KW_CreateButtonAndLabel");
    lib.bindSymbol(cast(void**)&KW_SetButtonLabel, "KW_SetButtonLabel");
    lib.bindSymbol(cast(void**)&KW_GetButtonLabel, "KW_GetButtonLabel");
    lib.bindSymbol(cast(void**)&KW_CreateCheckbox, "KW_CreateCheckbox");
    lib.bindSymbol(cast(void**)&KW_GetCheckboxLabel, "KW_GetCheckboxLabel");
    lib.bindSymbol(cast(void**)&KW_SetCheckboxLabel, "KW_SetCheckboxLabel");
    lib.bindSymbol(cast(void**)&KW_CreateEditbox, "KW_CreateEditbox");
    lib.bindSymbol(cast(void**)&KW_SetEditboxText, "KW_SetEditboxText");
    lib.bindSymbol(cast(void**)&KW_GetEditboxText, "KW_GetEditboxText");
    lib.bindSymbol(cast(void**)&KW_SetEditboxCursorPosition, "KW_SetEditboxCursorPosition");
    lib.bindSymbol(cast(void**)&KW_GetEditboxCursorPosition, "KW_GetEditboxCursorPosition");
    lib.bindSymbol(cast(void**)&KW_SetEditboxFont, "KW_SetEditboxFont");
    lib.bindSymbol(cast(void**)&KW_GetEditboxFont, "KW_GetEditboxFont");
    lib.bindSymbol(cast(void**)&KW_GetEditboxTextColor, "KW_GetEditboxTextColor");
    lib.bindSymbol(cast(void**)&KW_WasEditboxTextColorSet, "KW_WasEditboxTextColorSet");
    lib.bindSymbol(cast(void**)&KW_SetEditboxTextColor, "KW_SetEditboxTextColor");
    lib.bindSymbol(cast(void**)&KW_CreateFrame, "KW_CreateFrame");
    lib.bindSymbol(cast(void**)&KW_Init, "KW_Init");
    lib.bindSymbol(cast(void**)&KW_Quit, "KW_Quit");
    lib.bindSymbol(cast(void**)&KW_SetRenderer, "KW_SetRenderer");
    lib.bindSymbol(cast(void**)&KW_GetRenderer, "KW_GetRenderer");
    lib.bindSymbol(cast(void**)&KW_SetTilesetSurface, "KW_SetTilesetSurface");
    lib.bindSymbol(cast(void**)&KW_GetTilesetTexture, "KW_GetTilesetTexture");
    lib.bindSymbol(cast(void**)&KW_GetTilesetSurface, "KW_GetTilesetSurface");
    lib.bindSymbol(cast(void**)&KW_SetFont, "KW_SetFont");
    lib.bindSymbol(cast(void**)&KW_SetTextColor, "KW_SetTextColor");
    lib.bindSymbol(cast(void**)&KW_AddGUIFontChangedHandler, "KW_AddGUIFontChangedHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveGUIFontChangedHandler, "KW_RemoveGUIFontChangedHandler");
    lib.bindSymbol(cast(void**)&KW_AddGUITextColorChangedHandler, "KW_AddGUITextColorChangedHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveGUITextColorChangedHandler, "KW_RemoveGUITextColorChangedHandler");
    lib.bindSymbol(cast(void**)&KW_GetFont, "KW_GetFont");
    lib.bindSymbol(cast(void**)&KW_GetTextColor, "KW_GetTextColor");
    lib.bindSymbol(cast(void**)&KW_Paint, "KW_Paint");
    lib.bindSymbol(cast(void**)&KW_ProcessEvents, "KW_ProcessEvents");
    lib.bindSymbol(cast(void**)&KW_CreateLabel, "KW_CreateLabel");
    lib.bindSymbol(cast(void**)&KW_SetLabelText, "KW_SetLabelText");
    lib.bindSymbol(cast(void**)&KW_SetLabelStyle, "KW_SetLabelStyle");
    lib.bindSymbol(cast(void**)&KW_SetLabelTextColor, "KW_SetLabelTextColor");
    lib.bindSymbol(cast(void**)&KW_SetLabelFont, "KW_SetLabelFont");
    lib.bindSymbol(cast(void**)&KW_SetLabelAlignment, "KW_SetLabelAlignment");
    lib.bindSymbol(cast(void**)&KW_SetLabelIcon, "KW_SetLabelIcon");
    lib.bindSymbol(cast(void**)&KW_GetLabelFont, "KW_GetLabelFont");
    lib.bindSymbol(cast(void**)&KW_GetLabelTextColor, "KW_GetLabelTextColor");
    lib.bindSymbol(cast(void**)&KW_WasLabelTextColorSet, "KW_WasLabelTextColorSet");
    lib.bindSymbol(cast(void**)&KW_RectCenterInParent, "KW_RectCenterInParent");
    lib.bindSymbol(cast(void**)&KW_RectVerticallyCenterInParent, "KW_RectVerticallyCenterInParent");
    lib.bindSymbol(cast(void**)&KW_RectHorizontallyCenterInParent, "KW_RectHorizontallyCenterInParent");
    lib.bindSymbol(cast(void**)&KW_RectLayoutVertically, "KW_RectLayoutVertically");
    lib.bindSymbol(cast(void**)&KW_RectLayoutHorizontally, "KW_RectLayoutHorizontally");
    lib.bindSymbol(cast(void**)&KW_RectFillParentVertically, "KW_RectFillParentVertically");
    lib.bindSymbol(cast(void**)&KW_RectFillParentHorizontally, "KW_RectFillParentHorizontally");
    lib.bindSymbol(cast(void**)&KW_RectCalculateEnclosingRect, "KW_RectCalculateEnclosingRect");
    lib.bindSymbol(cast(void**)&KW_SetRect, "KW_SetRect");
    lib.bindSymbol(cast(void**)&KW_CopyRect, "KW_CopyRect");
    lib.bindSymbol(cast(void**)&KW_ZeroRect, "KW_ZeroRect");
    lib.bindSymbol(cast(void**)&KW_MarginRect, "KW_MarginRect");
    lib.bindSymbol(cast(void**)&KW_RenderRect, "KW_RenderRect");
    lib.bindSymbol(cast(void**)&KW_BlitSurface, "KW_BlitSurface");
    lib.bindSymbol(cast(void**)&KW_CreateSurface, "KW_CreateSurface");
    lib.bindSymbol(cast(void**)&KW_GetSurfaceExtents, "KW_GetSurfaceExtents");
    lib.bindSymbol(cast(void**)&KW_GetTextureExtents, "KW_GetTextureExtents");
    lib.bindSymbol(cast(void**)&KW_RenderCopy, "KW_RenderCopy");
    lib.bindSymbol(cast(void**)&KW_RenderText, "KW_RenderText");
    lib.bindSymbol(cast(void**)&KW_LoadFont, "KW_LoadFont");
    lib.bindSymbol(cast(void**)&KW_LoadFontFromMemory, "KW_LoadFontFromMemory");
    lib.bindSymbol(cast(void**)&KW_CreateTexture, "KW_CreateTexture");
    lib.bindSymbol(cast(void**)&KW_LoadTexture, "KW_LoadTexture");
    lib.bindSymbol(cast(void**)&KW_LoadSurface, "KW_LoadSurface");
    lib.bindSymbol(cast(void**)&KW_ReleaseTexture, "KW_ReleaseTexture");
    lib.bindSymbol(cast(void**)&KW_ReleaseSurface, "KW_ReleaseSurface");
    lib.bindSymbol(cast(void**)&KW_ReleaseFont, "KW_ReleaseFont");
    lib.bindSymbol(cast(void**)&KW_GetClipRect, "KW_GetClipRect");
    lib.bindSymbol(cast(void**)&KW_GetViewportSize, "KW_GetViewportSize");
    lib.bindSymbol(cast(void**)&KW_SetClipRect, "KW_SetClipRect");
    lib.bindSymbol(cast(void**)&KW_ReleaseRenderDriver, "KW_ReleaseRenderDriver");
    lib.bindSymbol(cast(void**)&KW_UTF8TextSize, "KW_UTF8TextSize");
    lib.bindSymbol(cast(void**)&KW_GetPixel, "KW_GetPixel");
    lib.bindSymbol(cast(void**)&KW_CreateSDL2RenderDriver, "KW_CreateSDL2RenderDriver");
    lib.bindSymbol(cast(void**)&KW_RenderDriverGetSDL2Renderer, "KW_RenderDriverGetSDL2Renderer");
    lib.bindSymbol(cast(void**)&KW_RenderDriverGetSDL2Window, "KW_RenderDriverGetSDL2Window");
    lib.bindSymbol(cast(void**)&KW_CreateScrollbox, "KW_CreateScrollbox");
    lib.bindSymbol(cast(void**)&KW_ScrollboxVerticalScroll, "KW_ScrollboxVerticalScroll");
    lib.bindSymbol(cast(void**)&KW_ScrollboxHorizontalScroll, "KW_ScrollboxHorizontalScroll");
    lib.bindSymbol(cast(void**)&KW_RenderTile, "KW_RenderTile");
    lib.bindSymbol(cast(void**)&KW_BlitTile, "KW_BlitTile");
    lib.bindSymbol(cast(void**)&KW_RenderTileFill, "KW_RenderTileFill");
    lib.bindSymbol(cast(void**)&KW_BlitTileFill, "KW_BlitTileFill");
    lib.bindSymbol(cast(void**)&KW_RenderTileFrame, "KW_RenderTileFrame");
    lib.bindSymbol(cast(void**)&KW_BlitTileFrame, "KW_BlitTileFrame");
    lib.bindSymbol(cast(void**)&KW_CreateTileFrameTexture, "KW_CreateTileFrameTexture");
    lib.bindSymbol(cast(void**)&KW_IsTileStretchable, "KW_IsTileStretchable");
    lib.bindSymbol(cast(void**)&KW_CreateToggle, "KW_CreateToggle");
    lib.bindSymbol(cast(void**)&KW_IsToggleChecked, "KW_IsToggleChecked");
    lib.bindSymbol(cast(void**)&KW_SetToggleChecked, "KW_SetToggleChecked");
    lib.bindSymbol(cast(void**)&KW_GetGUI, "KW_GetGUI");
    lib.bindSymbol(cast(void**)&KW_CreateWidget, "KW_CreateWidget");
    lib.bindSymbol(cast(void**)&KW_ReparentWidget, "KW_ReparentWidget");
    lib.bindSymbol(cast(void**)&KW_GetWidgetParent, "KW_GetWidgetParent");
    lib.bindSymbol(cast(void**)&KW_GetWidgetChildren, "KW_GetWidgetChildren");
    lib.bindSymbol(cast(void**)&KW_GetWidgetData, "KW_GetWidgetData");
    lib.bindSymbol(cast(void**)&KW_SetWidgetUserData, "KW_SetWidgetUserData");
    lib.bindSymbol(cast(void**)&KW_GetWidgetUserData, "KW_GetWidgetUserData");
    lib.bindSymbol(cast(void**)&KW_DestroyWidget, "KW_DestroyWidget");
    lib.bindSymbol(cast(void**)&KW_GetWidgetGUI, "KW_GetWidgetGUI");
    lib.bindSymbol(cast(void**)&KW_GetWidgetRenderer, "KW_GetWidgetRenderer");
    lib.bindSymbol(cast(void**)&KW_GetWidgetCustomRenderFunction, "KW_GetWidgetCustomRenderFunction");
    lib.bindSymbol(cast(void**)&KW_SetWidgetCustomRenderFunction, "KW_SetWidgetCustomRenderFunction");
    lib.bindSymbol(cast(void**)&KW_SetWidgetGeometry, "KW_SetWidgetGeometry");
    lib.bindSymbol(cast(void**)&KW_GetWidgetGeometry, "KW_GetWidgetGeometry");
    lib.bindSymbol(cast(void**)&KW_ReturnWidgetGeometry, "KW_ReturnWidgetGeometry");
    lib.bindSymbol(cast(void**)&KW_GetWidgetAbsoluteGeometry, "KW_GetWidgetAbsoluteGeometry");
    lib.bindSymbol(cast(void**)&KW_GetWidgetComposedGeometry, "KW_GetWidgetComposedGeometry");
    lib.bindSymbol(cast(void**)&KW_PaintWidget, "KW_PaintWidget");
    lib.bindSymbol(cast(void**)&KW_BringToFront, "KW_BringToFront");
    lib.bindSymbol(cast(void**)&KW_SetFocusedWidget, "KW_SetFocusedWidget");
    lib.bindSymbol(cast(void**)&KW_HideWidget, "KW_HideWidget");
    lib.bindSymbol(cast(void**)&KW_ShowWidget, "KW_ShowWidget");
    lib.bindSymbol(cast(void**)&KW_IsWidgetHidden, "KW_IsWidgetHidden");
    lib.bindSymbol(cast(void**)&KW_EnableWidgetDebug, "KW_EnableWidgetDebug");
    lib.bindSymbol(cast(void**)&KW_DisableWidgetDebug, "KW_DisableWidgetDebug");
    lib.bindSymbol(cast(void**)&KW_IsDebugWidgetEnabled, "KW_IsDebugWidgetEnabled");
    lib.bindSymbol(cast(void**)&KW_BlockWidgetInputEvents, "KW_BlockWidgetInputEvents");
    lib.bindSymbol(cast(void**)&KW_UnblockWidgetInputEvents, "KW_UnblockWidgetInputEvents");
    lib.bindSymbol(cast(void**)&KW_IsWidgetInputEventsBlocked, "KW_IsWidgetInputEventsBlocked");
    lib.bindSymbol(cast(void**)&KW_EnableWidgetHint, "KW_EnableWidgetHint");
    lib.bindSymbol(cast(void**)&KW_DisableWidgetHint, "KW_DisableWidgetHint");
    lib.bindSymbol(cast(void**)&KW_QueryWidgetHint, "KW_QueryWidgetHint");
    lib.bindSymbol(cast(void**)&KW_AddWidgetMouseOverHandler, "KW_AddWidgetMouseOverHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetMouseOverHandler, "KW_RemoveWidgetMouseOverHandler");
    lib.bindSymbol(cast(void**)&KW_AddWidgetMouseLeaveHandler, "KW_AddWidgetMouseLeaveHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetMouseLeaveHandler, "KW_RemoveWidgetMouseLeaveHandler");
    lib.bindSymbol(cast(void**)&KW_AddWidgetMouseDownHandler, "KW_AddWidgetMouseDownHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetMouseDownHandler, "KW_RemoveWidgetMouseDownHandler");
    lib.bindSymbol(cast(void**)&KW_AddWidgetMouseUpHandler, "KW_AddWidgetMouseUpHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetMouseUpHandler, "KW_RemoveWidgetMouseUpHandler");
    lib.bindSymbol(cast(void**)&KW_AddWidgetFocusGainHandler, "KW_AddWidgetFocusGainHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetFocusGainHandler, "KW_RemoveWidgetFocusGainHandler");
    lib.bindSymbol(cast(void**)&KW_AddWidgetFocusLoseHandler, "KW_AddWidgetFocusLoseHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetFocusLoseHandler, "KW_RemoveWidgetFocusLoseHandler");
    lib.bindSymbol(cast(void**)&KW_AddWidgetTextInputHandler, "KW_AddWidgetTextInputHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetTextInputHandler, "KW_RemoveWidgetTextInputHandler");
    lib.bindSymbol(cast(void**)&KW_AddWidgetKeyDownHandler, "KW_AddWidgetKeyDownHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetKeyDownHandler, "KW_RemoveWidgetKeyDownHandler");
    lib.bindSymbol(cast(void**)&KW_AddWidgetKeyUpHandler, "KW_AddWidgetKeyUpHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetKeyUpHandler, "KW_RemoveWidgetKeyUpHandler");
    lib.bindSymbol(cast(void**)&KW_AddWidgetDragStartHandler, "KW_AddWidgetDragStartHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetDragStartHandler, "KW_RemoveWidgetDragStartHandler");
    lib.bindSymbol(cast(void**)&KW_AddWidgetDragStopHandler, "KW_AddWidgetDragStopHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetDragStopHandler, "KW_RemoveWidgetDragStopHandler");
    lib.bindSymbol(cast(void**)&KW_AddWidgetDragHandler, "KW_AddWidgetDragHandler");
    lib.bindSymbol(cast(void**)&KW_AddWidgetGeometryChangeHandler, "KW_AddWidgetGeometryChangeHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetGeometryChangeHandler, "KW_RemoveWidgetGeometryChangeHandler");
    lib.bindSymbol(cast(void**)&KW_AddWidgetChildrenChangeHandler, "KW_AddWidgetChildrenChangeHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetChildrenChangeHandler, "KW_RemoveWidgetChildrenChangeHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetDragHandler, "KW_RemoveWidgetDragHandler");
    lib.bindSymbol(cast(void**)&KW_AddWidgetTilesetChangeHandler, "KW_AddWidgetTilesetChangeHandler");
    lib.bindSymbol(cast(void**)&KW_RemoveWidgetTilesetChangeHandler, "KW_RemoveWidgetTilesetChangeHandler");
    lib.bindSymbol(cast(void**)&KW_SetWidgetTilesetSurface, "KW_SetWidgetTilesetSurface");
    lib.bindSymbol(cast(void**)&KW_GetWidgetTilesetTexture, "KW_GetWidgetTilesetTexture");
    lib.bindSymbol(cast(void**)&KW_GetWidgetTilesetSurface, "KW_GetWidgetTilesetSurface");
    lib.bindSymbol(cast(void**)&KW_IsCursorOverWidget, "KW_IsCursorOverWidget");
    lib.bindSymbol(cast(void**)&KW_IsCursorReleasedOnWidget, "KW_IsCursorReleasedOnWidget");
    
    if(errorCount() != errCount) loadedVersion = KiwiSupport.badLibrary;
    else loadedVersion = KiwiSupport.kiwi;

    return loadedVersion;
}
