# Permanent python overrides
final: prev: {
  packageOverrides = finalPy: prevPy: {
    # Replace main torch packages with their bin versions for CUDA support + caching
    torch = finalPy.torch-bin;
    torchvision = finalPy.torchvision-bin;
    torchaudio = finalPy.torchaudio-bin;
  };
}
