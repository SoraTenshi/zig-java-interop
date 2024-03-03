public class This {
  static {
    System.loadLibrary("zig-java-interop");
  }

  private native void hello();

  public static void main(String[] arg) {
    new This().hello();
  }
}
