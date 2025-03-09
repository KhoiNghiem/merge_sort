module sort4 (
    input signed [7:0] x1, x2, x3, x4, // Các phần tử đầu vào 8 bit
    output wire signed [7:0] max,            // Giá trị lớn nhất
    output wire signed [7:0] second_max,     // Giá trị lớn thứ 2
    output wire signed [7:0] min,            // Giá trị nhỏ nhất
    output wire signed [7:0] second_min      // Giá trị nhỏ thứ 2
);

    wire signed [7:0] max1, min1, max2, min2, max_tmp, min_tmp;

    // So sánh x1 với x2
    comparator max_min_1 (
        .a(x1), .b(x2), .max(max1), .min(min1)
    );

    // So sánh x3 với x4
    comparator max_min_2 (
        .a(x3), .b(x4), .max(max2), .min(min2)
    );

    // So sánh max1 với max2 (Tìm giá trị max)
    comparator max_min_3 (
        .a(max1), .b(max2), .max(max), .min(min_tmp)
    );

    // So sánh min1 với min2 (Tìm giá trị min)
    comparator max_min_4 (
        .a(min1), .b(min2), .max(max_tmp), .min(min)
    );

    comparator max_min_5 (
        .a(min_tmp), .b(max_tmp), .max(second_max), .min(second_min)
    );

endmodule
