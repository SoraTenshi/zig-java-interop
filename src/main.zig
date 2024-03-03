const std = @import("std");
const jni = @cImport({
    @cInclude("This.h");
});

pub export fn Java_This_hello(_: ?*jni.JNIEnv, _: jni.jobject) callconv(.C) void {
    std.io.getStdOut().writer().print("Hello from: {s}\n", .{"Zig!"}) catch unreachable;
}

pub export fn Java_This_add(_: ?*jni.JNIEnv, _: jni.jobject, lhs: jni.jint, rhs: jni.jint) callconv(.C) jni.jint {
    return lhs + rhs;
}

pub export fn Java_This_print(this: *jni.JNIEnv, _: jni.jobject, target: jni.jstring) callconv(.C) void {
    // Bruh is this ugly, but compatibility says no
    const target_str = (this.*.*.GetStringUTFChars orelse return)(this, target, null);

    std.io.getStdOut().writer().print("Zig says: {s}\n", .{target_str}) catch unreachable;
}
