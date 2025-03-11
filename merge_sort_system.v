///////////////////////////////////////////////////////////////////////////////////////
module merge_sort_system (
input                        clk,
input                        rst,

input      signed [7:0]      In1, In2, In3, In4,
output reg signed [7:0]      SortOut,
output reg                   OutValid
);
wire                   BlkIn;
wire                   group_done_tmp;
wire signed [7:0]      max, second_max, min, second_min;

reg [3:0] max_index_0, max_index_1, max_index_2, max_index_3;
reg [3:0] max_index_4, max_index_5, max_index_6, max_index_7;

reg  signed [7:0] block [0:7][0:3]; // Nơi lưu input data
reg signed [7:0] block_buffer [0:7][0:3];

reg         [2:0]      count; // Số không dấu để đếm từ 0 đến 7

reg  group_done;

sort4 sort_inst (
.x1(In1), .x2(In2), .x3(In3), .x4(In4),
.max(max), .second_max(second_max), .min(min), .second_min(second_min)
);


always @(negedge clk or negedge rst) begin

    if(~rst) begin
        count <= 3'b000;
    end
    else begin 
        count <= count + 1;
    end
end

always @(posedge clk or negedge rst) begin
    if(~rst) begin
        group_done <= 0;
    end
    else begin 
        if (count + 1 >= 8) begin
            group_done <= 1;
        end else begin
            
        end
    end
end

assign BlkIn = (!count); 

always @(posedge clk or negedge rst) begin
// Cập nhật block ở mỗi sườn âm clk vì In1-In4 cũng vậy
    if(~rst) begin
        block[0][0] <= 0; block[0][1] <= 0; block[0][2] <= 0; block[0][3] <= 0;
        block[1][0] <= 0; block[1][1] <= 0; block[1][2] <= 0; block[1][3] <= 0;
        block[2][0] <= 0; block[2][1] <= 0; block[2][2] <= 0; block[2][3] <= 0;
        block[3][0] <= 0; block[3][1] <= 0; block[3][2] <= 0; block[3][3] <= 0;
        block[4][0] <= 0; block[4][1] <= 0; block[4][2] <= 0; block[4][3] <= 0;
        block[5][0] <= 0; block[5][1] <= 0; block[5][2] <= 0; block[5][3] <= 0;
        block[6][0] <= 0; block[6][1] <= 0; block[6][2] <= 0; block[6][3] <= 0;
        block[7][0] <= 0; block[7][1] <= 0; block[7][2] <= 0; block[7][3] <= 0;
    end

    else begin
        block[count][0] <= max;
        block[count][1] <= second_max;
        block[count][2] <= second_min;
        block[count][3] <= min;
    end
    end

assign group_done_tmp = (count == 7);

always @(negedge clk or negedge rst) begin
    if (~rst) begin
        
    end
    else if (group_done_tmp) begin
        // Lưu vào block_buffer từng phần tử
        block_buffer[0][0] <= block[0][0];
        block_buffer[0][1] <= block[0][1];
        block_buffer[0][2] <= block[0][2];
        block_buffer[0][3] <= block[0][3];

        block_buffer[1][0] <= block[1][0];
        block_buffer[1][1] <= block[1][1];
        block_buffer[1][2] <= block[1][2];
        block_buffer[1][3] <= block[1][3];

        block_buffer[2][0] <= block[2][0];
        block_buffer[2][1] <= block[2][1];
        block_buffer[2][2] <= block[2][2];
        block_buffer[2][3] <= block[2][3];

        block_buffer[3][0] <= block[3][0];
        block_buffer[3][1] <= block[3][1];
        block_buffer[3][2] <= block[3][2];
        block_buffer[3][3] <= block[3][3];

        block_buffer[4][0] <= block[4][0];
        block_buffer[4][1] <= block[4][1];
        block_buffer[4][2] <= block[4][2];
        block_buffer[4][3] <= block[4][3];

        block_buffer[5][0] <= block[5][0];
        block_buffer[5][1] <= block[5][1];
        block_buffer[5][2] <= block[5][2];
        block_buffer[5][3] <= block[5][3];

        block_buffer[6][0] <= block[6][0];
        block_buffer[6][1] <= block[6][1];
        block_buffer[6][2] <= block[6][2];
        block_buffer[6][3] <= block[6][3];

        block_buffer[7][0] <= block[7][0];
        block_buffer[7][1] <= block[7][1];
        block_buffer[7][2] <= block[7][2];
        block_buffer[7][3] <= block[7][3];
    end
    else begin
        
    end
end

always @(posedge clk or negedge rst) begin
// Cập nhật OutValid ở mỗi sườn dương clk.
if(~rst) begin 
    max_index_0 <= 0;
    max_index_1 <= 0;
    max_index_2 <= 0;
    max_index_3 <= 0;
    max_index_4 <= 0;
    max_index_5 <= 0;
    max_index_6 <= 0;
    max_index_7 <= 0;
    SortOut <= 0;
    OutValid <= 0;
end
else if (group_done) begin
    OutValid <= 1'b1;
    if (count - 1 <= 7) begin
    // Tìm giá trị lớn nhất từ các phần tử
    if (block_buffer[0][max_index_0] >= block_buffer[1][max_index_1] && 
        block_buffer[0][max_index_0] >= block_buffer[2][max_index_2] &&
        block_buffer[0][max_index_0] >= block_buffer[3][max_index_3] &&
        block_buffer[0][max_index_0] >= block_buffer[4][max_index_4] &&
        block_buffer[0][max_index_0] >= block_buffer[5][max_index_5] &&
        block_buffer[0][max_index_0] >= block_buffer[6][max_index_6] &&
        block_buffer[0][max_index_0] >= block_buffer[7][max_index_7]) begin
        SortOut <= block_buffer[0][max_index_0];
        max_index_0 <= max_index_0 + 1;
    end else if (block_buffer[1][max_index_1] >= block_buffer[0][max_index_0] && 
                block_buffer[1][max_index_1] >= block_buffer[2][max_index_2] &&
                block_buffer[1][max_index_1] >= block_buffer[3][max_index_3] &&
                block_buffer[1][max_index_1] >= block_buffer[4][max_index_4] &&
                block_buffer[1][max_index_1] >= block_buffer[5][max_index_5] &&
                block_buffer[1][max_index_1] >= block_buffer[6][max_index_6] &&
                block_buffer[1][max_index_1] >= block_buffer[7][max_index_7]) begin
        SortOut <= block_buffer[1][max_index_1];
        max_index_1 <= max_index_1 + 1;
    end else if (block_buffer[2][max_index_2] >= block_buffer[0][max_index_0] && 
                block_buffer[2][max_index_2] >= block_buffer[1][max_index_1] &&
                block_buffer[2][max_index_2] >= block_buffer[3][max_index_3] &&
                block_buffer[2][max_index_2] >= block_buffer[4][max_index_4] &&
                block_buffer[2][max_index_2] >= block_buffer[5][max_index_5] &&
                block_buffer[2][max_index_2] >= block_buffer[6][max_index_6] &&
                block_buffer[2][max_index_2] >= block_buffer[7][max_index_7]) begin
        SortOut <= block_buffer[2][max_index_2];
        max_index_2 <= max_index_2 + 1;
    end else if (block_buffer[3][max_index_3] >= block_buffer[0][max_index_0] && 
                block_buffer[3][max_index_3] >= block_buffer[1][max_index_1] &&
                block_buffer[3][max_index_3] >= block_buffer[2][max_index_2] &&
                block_buffer[3][max_index_3] >= block_buffer[4][max_index_4] &&
                block_buffer[3][max_index_3] >= block_buffer[5][max_index_5] &&
                block_buffer[3][max_index_3] >= block_buffer[6][max_index_6] &&
                block_buffer[3][max_index_3] >= block_buffer[7][max_index_7]) begin
        SortOut <= block_buffer[3][max_index_3];
        max_index_3 <= max_index_3 + 1;
    end else if (block_buffer[4][max_index_4] >= block_buffer[0][max_index_0] && 
                block_buffer[4][max_index_4] >= block_buffer[1][max_index_1] &&
                block_buffer[4][max_index_4] >= block_buffer[2][max_index_2] &&
                block_buffer[4][max_index_4] >= block_buffer[3][max_index_3] &&
                block_buffer[4][max_index_4] >= block_buffer[5][max_index_5] &&
                block_buffer[4][max_index_4] >= block_buffer[6][max_index_6] &&
                block_buffer[4][max_index_4] >= block_buffer[7][max_index_7]) begin
        SortOut <= block_buffer[4][max_index_4];
        max_index_4 <= max_index_4 + 1;
    end else if (block_buffer[5][max_index_5] >= block_buffer[0][max_index_0] && 
                block_buffer[5][max_index_5] >= block_buffer[1][max_index_1] &&
                block_buffer[5][max_index_5] >= block_buffer[2][max_index_2] &&
                block_buffer[5][max_index_5] >= block_buffer[3][max_index_3] &&
                block_buffer[5][max_index_5] >= block_buffer[4][max_index_4] &&
                block_buffer[5][max_index_5] >= block_buffer[6][max_index_6] &&
                block_buffer[5][max_index_5] >= block_buffer[7][max_index_7]) begin
        SortOut <= block_buffer[5][max_index_5];
        max_index_5 <= max_index_5 + 1;
    end else if (block_buffer[6][max_index_6] >= block_buffer[0][max_index_0] && 
                block_buffer[6][max_index_6] >= block_buffer[1][max_index_1] &&
                block_buffer[6][max_index_6] >= block_buffer[2][max_index_2] &&
                block_buffer[6][max_index_6] >= block_buffer[3][max_index_3] &&
                block_buffer[6][max_index_6] >= block_buffer[4][max_index_4] &&
                block_buffer[6][max_index_6] >= block_buffer[5][max_index_5] &&
                block_buffer[6][max_index_6] >= block_buffer[7][max_index_7]) begin
        SortOut <= block_buffer[6][max_index_6];
        max_index_6 <= max_index_6 + 1;
    end else begin
        SortOut <= block_buffer[7][max_index_7];
        max_index_7 <= max_index_7 + 1;
    end
    end else if (count - 1 > 7) begin
                SortOut <= 0;
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
