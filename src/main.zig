const std = @import("std");
const jni = @cImport({
    @cInclude("This.h");
});

pub export fn Java_This_hello(_: ?*jni.JNIEnv, _: jni.jobject) callconv(.C) void {
    std.io.getStdOut().writer().print("Hello from: {s}\n", .{"Zig!"}) catch unreachable;
}
