module tb_merge_sort_system;

    // Định nghĩa tín hiệu
    reg clk;
    reg BlkIn = 0;
    reg signed [7:0] In1, In2, In3, In4;
    wire signed [7:0] SortOut;
    wire OutValid;

    // Các tín hiệu từ sort4 để theo dõi
    wire signed [7:0] max, second_max, min, second_min;

    // Khởi tạo module merge_sort_system
    merge_sort_system uut (
        .clk(clk),
        .BlkIn(BlkIn),         // Kết nối tín hiệu BlkIn vào module merge_sort_system
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
    reg signed [7:0] random_sequence [0:31]; // Mảng để lưu trữ 32 phần tử ngẫu nhiên

    always @(negedge clk)  begin
        #10
        // Inital signal states
        In1 = 0;
        In2 = 0;
        In3 = 0;
        In4 = 0;

        // Tạo 32 phần tử ngẫu nhiên từ -128 đến 127
        for (i = 0; i < 32; i = i + 1) begin
            random_sequence[i] = $signed($random) % 256 - 128; // Tạo giá trị ngẫu nhiên trong khoảng [-128, 127]
        end

        // Quá trình truyền vào dữ liệu cho 32 phần tử, mỗi chu kỳ 1 giá trị mới
        for (i = 0; i < 32; i = i + 1) begin
            // Chuyển giá trị mới vào mỗi chu kỳ
            In1 = random_sequence[i];
            In2 = random_sequence[i+1]; // Lưu các giá trị này vào để test
            In3 = random_sequence[i+2]; // Tương tự
            In4 = random_sequence[i+3]; // Tương tự

            // Bật BlkIn sau mỗi 8 chu kỳ
            if (i % 8 == 0) begin
                BlkIn = 1;
            end else begin
                BlkIn = 0;
            end

            // Chờ 1 chu kỳ đồng hồ (tương ứng với 1 dữ liệu vào mỗi chu kỳ)
            #10; // 1 chu kỳ x 10 ns (10ns là thời gian mỗi chu kỳ đồng hồ)
        end

        // Chờ đủ thời gian để quá trình merge hoàn thành
        #200;
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
