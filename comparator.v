module comparator (
    input signed [7:0] a, b,    // Hai giá trị cần so sánh
    output signed [7:0] max,    // Giá trị lớn nhất
    output signed [7:0] min     // Giá trị nhỏ nhất
);
    assign max = (a > b) ? a : b;
    assign min = (a < b) ? a : b;
endmodule