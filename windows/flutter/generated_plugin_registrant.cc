//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <app_links/app_links_plugin_c_api.h>
#include <audioplayers_windows/audioplayers_windows_plugin.h>
#include <file_selector_windows/file_selector_windows.h>
#include <my_device_info/my_device_info_plugin_c_api.h>
#include <my_gallery/my_gallery_plugin_c_api.h>
#include <permission_handler_windows/permission_handler_windows_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  AppLinksPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AppLinksPluginCApi"));
  AudioplayersWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AudioplayersWindowsPlugin"));
  FileSelectorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSelectorWindows"));
  MyDeviceInfoPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("MyDeviceInfoPluginCApi"));
  MyGalleryPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("MyGalleryPluginCApi"));
  PermissionHandlerWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PermissionHandlerWindowsPlugin"));
}
