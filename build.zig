const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addSharedLibrary(.{
        .name = "zig-java-interop",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    lib.linkLibC();

    const java_home = try std.process.getEnvVarOwned(std.heap.page_allocator, "JAVA_HOME");
    defer std.heap.page_allocator.free(java_home);

    const include_path = try std.heap.page_allocator.alloc(u8, java_home.len + "/include".len);
    defer std.heap.page_allocator.free(include_path);

    for (java_home, 0..) |c, i| {
        include_path[i] = c;
    }

    for ("/include", java_home.len..) |c, i| {
        include_path[i] = c;
    }

    lib.addIncludePath(.{ .path = include_path });
    lib.addIncludePath(.{ .path = "src/" });
    b.installArtifact(lib);
}
