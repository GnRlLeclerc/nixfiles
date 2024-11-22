# Devshell for generic GPU programming
{ pkgs, ... }:
{
  wgpu = pkgs.mkShell rec {
    buildInputs = with pkgs; [
      wayland
      libxkbcommon

      glfw
      vulkan-headers
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
      vulkan-tools-lunarg

      shaderc # GLSL to SPIRV compiler - glslc
      renderdoc # Graphics debugger
      tracy # Graphics profiler
      vulkan-tools-lunarg # vkconfig
    ];

    LD_LIBRARY_PATH = builtins.toString (pkgs.lib.makeLibraryPath buildInputs);
    VULKAN_SDK = with pkgs; "${vulkan-headers}";
    VK_LAYER_PATH = with pkgs; "${vulkan-validation-layers}/share/vulkan/explicit_layer.d";
  };
}
