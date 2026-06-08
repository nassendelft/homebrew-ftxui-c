class FtxuiC < Formula
  desc "C bindings for the FTXUI terminal UI library"
  homepage "https://github.com/nassendelft/ftxui-c"
  url "https://github.com/nassendelft/ftxui-c/releases/download/v1.0.1/ftxui-c-v1.0.1-src.tar.gz"
  sha256 "f138fa10476f3f59d02ae40f659dca4f862972c647a8b400f62ef87deaffd49e"
  license "GPL-3.0-only"

  depends_on "cmake" => :build

  def install
    system "cmake", "-B", "build", "-DCMAKE_BUILD_TYPE=Release"
    system "cmake", "--build", "build"
    lib.install OS.mac? ? "build/libftxui_c_binding.dylib" : "build/libftxui_c_binding.so"
    include.install "ftxui_c_api.h"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "ftxui_c_api.h"
      int main(void) { return 0; }
    C
    system ENV.cc, "test.c", "-I#{include}", "-o", "/dev/null"
  end
end
