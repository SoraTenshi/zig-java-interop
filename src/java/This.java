public class This {
  static {
    System.loadLibrary("zig-java-interop");
  }

  private native void hello();
  private native int add(final int lhs, final int rhs);
  private native void print(final String target);

  public static void main(String[] arg) {
    final var t = new This();
    System.out.println("\n------------------- START -------------------");
    t.hello();

    System.out.format("Java says: calling t.add(13, 37) -> %d\n", t.add(13, 37));

    t.print("Hello Ziggy (from your \"beloved\" friend Java) :)");

    System.out.println("-------------------- END --------------------\n");
  }
}
