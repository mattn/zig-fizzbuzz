const std = @import("std");

fn fizzbuzz(writer: anytype, i: u32) !void {
    if (i % 15 == 0) {
        try writer.print("{s}\n", .{"FizzBuzz"});
    } else if (i % 3 == 0) {
        try writer.print("{s}\n", .{"Fizz"});
    } else if (i % 5 == 0) {
        try writer.print("{s}\n", .{"Buzz"});
    } else {
        try writer.print("{}\n", .{i});
    }
}

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();
    var i: u32 = 1;
    while (i <= 100) : (i += 1) {
        try fizzbuzz(stdout, i);
    }
}

test "basic test" {
    var bytes = std.ArrayList(u8).init(std.testing.allocator);
    defer bytes.deinit();

    const T = struct { input: u8, want: []const u8 };
    var tests = [_]T{
        .{ .input = 1, .want = "1\n" },
        .{ .input = 2, .want = "2\n" },
        .{ .input = 3, .want = "Fizz\n" },
        .{ .input = 4, .want = "4\n" },
        .{ .input = 5, .want = "Buzz\n" },
        .{ .input = 6, .want = "Fizz\n" },
        .{ .input = 7, .want = "7\n" },
        .{ .input = 8, .want = "8\n" },
        .{ .input = 9, .want = "Fizz\n" },
        .{ .input = 10, .want = "Buzz\n" },
        .{ .input = 11, .want = "11\n" },
        .{ .input = 12, .want = "Fizz\n" },
        .{ .input = 13, .want = "13\n" },
        .{ .input = 14, .want = "14\n" },
        .{ .input = 15, .want = "FizzBuzz\n" },
    };
    for (tests) |t| {
        bytes.clearAndFree();
        std.log.info("{}", .{t.input});
        try fizzbuzz(bytes.writer(), t.input);
        try std.testing.expect(std.mem.eql(u8, bytes.items, t.want));
    }
}
