//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <file_selector_windows/file_selector_windows.h>
#include <resizable_draggable_widget/resize_drag_widget_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FileSelectorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSelectorWindows"));
  ResizeDragWidgetPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ResizeDragWidgetPluginCApi"));
}
