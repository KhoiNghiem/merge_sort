module tb_merge_sort_system;

    // Định nghĩa tín hiệu
    reg clk;
    reg rst;
    reg signed [7:0] In1, In2, In3, In4;
    wire signed [7:0] SortOut;
    wire OutValid;

    // Các tín hiệu từ sort4 để theo dõi
    wire signed [7:0] max, second_max, min, second_min;

    // Khởi tạo module merge_sort_system
    merge_sort_system uut (
        .clk(clk),
        .rst(rst),         // Kết nối tín hiệu BlkIn vào module merge_sort_system
        .In1(In1),
        .In2(In2),
        .In3(In3),
        .In4(In4),
        .SortOut(SortOut),
        .OutValid(OutValid)
    );

    // Khởi tạo module sort4 để theo dõi giá trị đầu ra
    sort4 sort_inst (
        .x1(In1), .x2(In2), .x3(In3), .x4(In4),
        .max(max), .second_max(second_max), .min(min), .second_min(second_min)
    );

    // Tạo tín hiệu đồng hồ (clock)
    always begin
        clk = 0;
        #5 clk = 1;
        #5 clk = 0;
    end

    // Khởi tạo test
    integer i;
    
    initial begin
        rst = 0;  // Bật reset
        #20 rst = 1;  // Tắt reset sau một chu kỳ đồng hồ
    end

    always @(negedge clk) begin
        // Tạo các giá trị ngẫu nhiên mới mỗi chu kỳ
        In1 = $signed($random) % 256 - 128; // Tạo giá trị ngẫu nhiên trong khoảng [-128, 127]
        In2 = $signed($random) % 256 - 128;
        In3 = $signed($random) % 256 - 128;
        In4 = $signed($random) % 256 - 128;

        // Quá trình truyền vào dữ liệu cho mỗi chu kỳ
        #10; // 1 chu kỳ x 10 ns (10ns là thời gian mỗi chu kỳ đồng hồ)
    end

    // Chờ đủ thời gian để quá trình merge hoàn thành
    initial begin
        #200;  // Chờ 200ns (hoặc thời gian cần thiết để sắp xếp hoàn tất)
        $finish; // Kết thúc mô phỏng
    end

    // In các kết quả khi OutValid bật lên
    always @(posedge clk) begin
        if (OutValid) begin
            $display("Output: %d", SortOut); // In giá trị sắp xếp ra ngoài khi OutValid được bật
        end
    end

    // In giá trị của sort4 mỗi chu kỳ
    always @(posedge clk) begin
        $display("max = %d, second_max = %d, second_min = %d, min = %d", max, second_max, second_min, min);
    end

endmodule
