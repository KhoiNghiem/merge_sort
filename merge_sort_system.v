module merge_sort_system (
    input clk,
    input signed [7:0] In1, In2, In3, In4,
    input BlkIn,
    output reg [7:0] SortOut,
    output reg OutValid
);

    reg signed [7:0] group [0:7][0:3];
    reg signed [7:0] group_buffer [0:7][0:3];
    reg [3:0] group_idx = 0;

    reg [3:0] max_index_0 = 0, max_index_1 = 0, max_index_2 = 0, max_index_3 = 0;
    reg [3:0] max_index_4 = 0, max_index_5 = 0, max_index_6 = 0, max_index_7 = 0;
    wire signed [7:0] max, second_max, min, second_min;

    sort4 sort_inst (
        .x1(In1), .x2(In2), .x3(In3), .x4(In4),
        .max(max), .second_max(second_max), .min(min), .second_min(second_min)
    );

    reg [2:0] count = 0;
    reg count_enabled = 0;
    reg group_enabled = 0;

    always @(posedge clk) begin
        if (BlkIn) begin
            group_enabled <= 1;
        end

        if (group_enabled) begin
            if (group_idx < 8) begin
                group[group_idx][0] <= max;
                group[group_idx][1] <= second_max;
                group[group_idx][2] <= second_min;
                group[group_idx][3] <= min;
                group_idx <= group_idx + 1;
            end else begin
                // Lưu vào group_buffer từng phần tử
                group_buffer[0][0] <= group[0][0];
                group_buffer[0][1] <= group[0][1];
                group_buffer[0][2] <= group[0][2];
                group_buffer[0][3] <= group[0][3];

                group_buffer[1][0] <= group[1][0];
                group_buffer[1][1] <= group[1][1];
                group_buffer[1][2] <= group[1][2];
                group_buffer[1][3] <= group[1][3];

                group_buffer[2][0] <= group[2][0];
                group_buffer[2][1] <= group[2][1];
                group_buffer[2][2] <= group[2][2];
                group_buffer[2][3] <= group[2][3];

                group_buffer[3][0] <= group[3][0];
                group_buffer[3][1] <= group[3][1];
                group_buffer[3][2] <= group[3][2];
                group_buffer[3][3] <= group[3][3];

                group_buffer[4][0] <= group[4][0];
                group_buffer[4][1] <= group[4][1];
                group_buffer[4][2] <= group[4][2];
                group_buffer[4][3] <= group[4][3];

                group_buffer[5][0] <= group[5][0];
                group_buffer[5][1] <= group[5][1];
                group_buffer[5][2] <= group[5][2];
                group_buffer[5][3] <= group[5][3];

                group_buffer[6][0] <= group[6][0];
                group_buffer[6][1] <= group[6][1];
                group_buffer[6][2] <= group[6][2];
                group_buffer[6][3] <= group[6][3];

                group_buffer[7][0] <= group[7][0];
                group_buffer[7][1] <= group[7][1];
                group_buffer[7][2] <= group[7][2];
                group_buffer[7][3] <= group[7][3];

                count <= 0;
                group_idx <= 0;
                count_enabled <= 1;
                OutValid <= 1'b1;
            end
        end

        if (count_enabled) begin
            if (count < 7) begin
                // Tìm giá trị lớn nhất từ các phần tử
                if (group_buffer[0][max_index_0] >= group_buffer[1][max_index_1] && 
                    group_buffer[0][max_index_0] >= group_buffer[2][max_index_2] &&
                    group_buffer[0][max_index_0] >= group_buffer[3][max_index_3] &&
                    group_buffer[0][max_index_0] >= group_buffer[4][max_index_4] &&
                    group_buffer[0][max_index_0] >= group_buffer[5][max_index_5] &&
                    group_buffer[0][max_index_0] >= group_buffer[6][max_index_6] &&
                    group_buffer[0][max_index_0] >= group_buffer[7][max_index_7]) begin
                    SortOut <= group_buffer[0][max_index_0];
                    max_index_0 <= max_index_0 + 1;
                end else if (group_buffer[1][max_index_1] >= group_buffer[0][max_index_0] && 
                            group_buffer[1][max_index_1] >= group_buffer[2][max_index_2] &&
                            group_buffer[1][max_index_1] >= group_buffer[3][max_index_3] &&
                            group_buffer[1][max_index_1] >= group_buffer[4][max_index_4] &&
                            group_buffer[1][max_index_1] >= group_buffer[5][max_index_5] &&
                            group_buffer[1][max_index_1] >= group_buffer[6][max_index_6] &&
                            group_buffer[1][max_index_1] >= group_buffer[7][max_index_7]) begin
                    SortOut <= group_buffer[1][max_index_1];
                    max_index_1 <= max_index_1 + 1;
                end else if (group_buffer[2][max_index_2] >= group_buffer[0][max_index_0] && 
                            group_buffer[2][max_index_2] >= group_buffer[1][max_index_1] &&
                            group_buffer[2][max_index_2] >= group_buffer[3][max_index_3] &&
                            group_buffer[2][max_index_2] >= group_buffer[4][max_index_4] &&
                            group_buffer[2][max_index_2] >= group_buffer[5][max_index_5] &&
                            group_buffer[2][max_index_2] >= group_buffer[6][max_index_6] &&
                            group_buffer[2][max_index_2] >= group_buffer[7][max_index_7]) begin
                    SortOut <= group_buffer[2][max_index_2];
                    max_index_2 <= max_index_2 + 1;
                end else if (group_buffer[3][max_index_3] >= group_buffer[0][max_index_0] && 
                            group_buffer[3][max_index_3] >= group_buffer[1][max_index_1] &&
                            group_buffer[3][max_index_3] >= group_buffer[2][max_index_2] &&
                            group_buffer[3][max_index_3] >= group_buffer[4][max_index_4] &&
                            group_buffer[3][max_index_3] >= group_buffer[5][max_index_5] &&
                            group_buffer[3][max_index_3] >= group_buffer[6][max_index_6] &&
                            group_buffer[3][max_index_3] >= group_buffer[7][max_index_7]) begin
                    SortOut <= group_buffer[3][max_index_3];
                    max_index_3 <= max_index_3 + 1;
                end else if (group_buffer[4][max_index_4] >= group_buffer[0][max_index_0] && 
                            group_buffer[4][max_index_4] >= group_buffer[1][max_index_1] &&
                            group_buffer[4][max_index_4] >= group_buffer[2][max_index_2] &&
                            group_buffer[4][max_index_4] >= group_buffer[3][max_index_3] &&
                            group_buffer[4][max_index_4] >= group_buffer[5][max_index_5] &&
                            group_buffer[4][max_index_4] >= group_buffer[6][max_index_6] &&
                            group_buffer[4][max_index_4] >= group_buffer[7][max_index_7]) begin
                    SortOut <= group_buffer[4][max_index_4];
                    max_index_4 <= max_index_4 + 1;
                end else if (group_buffer[5][max_index_5] >= group_buffer[0][max_index_0] && 
                            group_buffer[5][max_index_5] >= group_buffer[1][max_index_1] &&
                            group_buffer[5][max_index_5] >= group_buffer[2][max_index_2] &&
                            group_buffer[5][max_index_5] >= group_buffer[3][max_index_3] &&
                            group_buffer[5][max_index_5] >= group_buffer[4][max_index_4] &&
                            group_buffer[5][max_index_5] >= group_buffer[6][max_index_6] &&
                            group_buffer[5][max_index_5] >= group_buffer[7][max_index_7]) begin
                    SortOut <= group_buffer[5][max_index_5];
                    max_index_5 <= max_index_5 + 1;
                end else if (group_buffer[6][max_index_6] >= group_buffer[0][max_index_0] && 
                            group_buffer[6][max_index_6] >= group_buffer[1][max_index_1] &&
                            group_buffer[6][max_index_6] >= group_buffer[2][max_index_2] &&
                            group_buffer[6][max_index_6] >= group_buffer[3][max_index_3] &&
                            group_buffer[6][max_index_6] >= group_buffer[4][max_index_4] &&
                            group_buffer[6][max_index_6] >= group_buffer[5][max_index_5] &&
                            group_buffer[6][max_index_6] >= group_buffer[7][max_index_7]) begin
                    SortOut <= group_buffer[6][max_index_6];
                    max_index_6 <= max_index_6 + 1;
                end else begin
                    SortOut <= group_buffer[7][max_index_7];
                    max_index_7 <= max_index_7 + 1;
                end

                count <= count + 1;
            end else if (count == 7) begin
                SortOut <= 0;
                count_enabled <= 0;
                OutValid <= 1'b0;
                max_index_0 <= 0;
                max_index_1 <= 0;
                max_index_2 <= 0;
                max_index_3 <= 0;
                max_index_4 <= 0;
                max_index_5 <= 0;
                max_index_6 <= 0;
                max_index_7 <= 0;
            end
        end
    end
endmodule
