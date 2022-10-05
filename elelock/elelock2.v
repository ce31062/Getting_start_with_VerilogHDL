/* Electronic Lock */
module elelock (ck, resetn, tenkey, close, lock, LED, LED1, LED2, LED3, LED4);
    input           resetn, close;
    input   [9:0]   tenkey;
    output          lock;
    output	[7:0]	LED1;
    output	[7:0]	LED2;
    output	[7:0]	LED3;
    output	[7:0]	LED4;
    output  [8:1]   LED;
    output          ck;

    reg             lock, ke1, ke2;
    reg     [3:0]   key [0:3];
 
	wire            match, key_enbl;
    wire	[7:0]	LED1;
    wire	[7:0]	LED2;
    wire	[7:0]	LED3;
    wire	[7:0]	LED4;

    assign  reset = ~resetn;
	
    assign	LED1 = 8'b0000_0000;
    assign	LED2 = 8'b0000_0000;
    assign	LED3 = 8'b0000_0000;
    assign	LED4 = 8'b0000_0000;
    assign  LED = 7'b1111_111; // Turn-off for LEDs


    clock_50hz clock_50hz_inst(reset, ck);

    //PIN setting
    parameter SECRET_3 = 4'h5,
              SECRET_2 = 4'h9,
              SECRET_1 = 4'h6,
              SECRET_0 = 4'h3;
    // PIN entry register
    always @(posedge ck or posedge reset) begin
        if (reset==1'b1) begin
            key[3] <= 4'b1111;
            key[2] <= 4'b1111;
            key[1] <= 4'b1111;
            key[0] <= 4'b1111;
        end
        else if (close==1'b1) begin
            key[3] <= 4'b1111;
            key[2] <= 4'b1111;
            key[1] <= 4'b1111;
            key[0] <= 4'b1111;
        end
        else if (key_enbl==1'b1) begin
            key[3] <= key[2];
            key[2] <= key[1];
            key[1] <= key[0];
            key[0] <= keyenc(tenkey);
        end
    end

    // Ten-key input for chatter removal
    always @(posedge ck or posedge reset) begin
        if (reset==1'b1) begin
            ke2 <= 1'b0;
            ke1 <= 1'b0;
        end
        else begin
            ke2 <= ke1;
            ke1 <= | tenkey;
        end
    end

    // Erectronic lock Output
    always @(posedge ck or posedge reset) begin
        if (reset==1'b1)
            lock <= 1'b0;
        else if (close==1'b1)
            lock <= 1'b1;
        else if (match==1'b1)
            lock <= 1'b0;
    end

    // Tenkey input encoder
    function    [3:0]   keyenc;
    input       [9:0]   sw;
        case (sw)
            10'b00000_00001: keyenc = 4'h0;
            10'b00000_00010: keyenc = 4'h1;
            10'b00000_00100: keyenc = 4'h2;
            10'b00000_01000: keyenc = 4'h3;
            10'b00000_10000: keyenc = 4'h4;
            10'b00001_00000: keyenc = 4'h5;
            10'b00010_00000: keyenc = 4'h6;
            10'b00100_00000: keyenc = 4'h7;
            10'b01000_00000: keyenc = 4'h8;
            10'b10000_00000: keyenc = 4'h9;
        endcase
    endfunction

    // PIN match signal
    assign match = (key[0]==SECRET_0) && (key[1]==SECRET_1)
                && (key[2]==SECRET_2) && (key[3]==SECRET_3);
    assign key_enbl = ~ke2 & ke1;

    

endmodule
module clock_50hz(reset, ck_50hz);
    input reset;
    output ck_50hz;

    reg [19:0] count;  
    wire osc_clk;       // Internal OSCILLATOR clock

    /* --- OSCJ (Oscillator for MachXO3D) --- */
    defparam OSCJ_inst.NOM_FREQ = "53.2";  
    OSCJ OSCJ_inst( 
        .STDBY(1'b0), // 0=Enabled, 1=Disabled
        .OSC(osc_clk),
        .SEDSTDBY()
    );

    /* --- 20bit counter --- */
    always @(posedge osc_clk or posedge reset) begin
        if (reset==1'b1)
            count <= 20'b0;
        else
            count <= count + 20'b1;
    end

    assign ck_50hz = count[19];
endmodule
