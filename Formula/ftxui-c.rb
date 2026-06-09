class FtxuiC < Formula
  desc "C bindings for the FTXUI terminal UI library"
  homepage "https://github.com/nassendelft/ftxui-c"
  url "https://github.com/nassendelft/ftxui-c/releases/download/v1.0.3/ftxui-c-v1.0.3-src.tar.gz"
  sha256 "50e101e82bd3d545c11867373c142973aaee640cf0178b8e9bee4bcab56f6e0c"
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
