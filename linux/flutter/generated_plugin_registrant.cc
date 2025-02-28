//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <audioplayers_linux/audioplayers_linux_plugin.h>
#include <file_selector_linux/file_selector_plugin.h>
#include <gtk/gtk_plugin.h>
#include <my_device_info/my_device_info_plugin.h>
#include <my_gallery/my_gallery_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) audioplayers_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "AudioplayersLinuxPlugin");
  audioplayers_linux_plugin_register_with_registrar(audioplayers_linux_registrar);
  g_autoptr(FlPluginRegistrar) file_selector_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FileSelectorPlugin");
  file_selector_plugin_register_with_registrar(file_selector_linux_registrar);
  g_autoptr(FlPluginRegistrar) gtk_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "GtkPlugin");
  gtk_plugin_register_with_registrar(gtk_registrar);
  g_autoptr(FlPluginRegistrar) my_device_info_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MyDeviceInfoPlugin");
  my_device_info_plugin_register_with_registrar(my_device_info_registrar);
  g_autoptr(FlPluginRegistrar) my_gallery_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MyGalleryPlugin");
  my_gallery_plugin_register_with_registrar(my_gallery_registrar);
}
