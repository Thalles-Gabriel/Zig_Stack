const std = @import("std");
const Stack = @import("stack.zig").Stack;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    const alloc = arena.allocator();
    defer _ = arena.deinit();
    var stack = Stack(u16){ .allocator = alloc };
    try stack.push(64);
    try stack.push(32);
    _ = stack.pop();
    std.debug.print("Result should be 64\nResult is {d}\n", .{stack.head.?.value});
}

test "TestingLeaks" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    const alloc = arena.allocator();
    defer _ = arena.deinit();
    var stack = Stack(u16){ .allocator = alloc };
    try stack.push(64);
    try stack.push(32);
    _ = stack.pop();
    std.debug.print("Result should be 64\nResult is {d}\n", .{stack.head.?.value});
}
