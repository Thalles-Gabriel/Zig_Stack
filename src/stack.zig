const std = @import("std");

pub fn Stack(T: type) type {
    return struct {
        const Node = struct { value: T, next: ?*Node = null };
        const Self = @This();

        allocator: std.mem.Allocator,
        head: ?*Node = null,
        length: usize = 0,

        pub fn push(self: *Self, value: T) !void {
            const node = try self.allocator.create(Node);
            node.value = value;

            if (self.head) |head| {
                node.next = head;
            }
            self.head = node;
            self.length += 1;
        }

        pub fn pop(self: *Self) ?T {
            if (self.head) |head| {
                defer self.allocator.destroy(head);
                self.head = head.next;
                self.length -= 1;

                return head.value;
            }
            return null;
        }
    };
}
