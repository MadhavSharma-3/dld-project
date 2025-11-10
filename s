#! /c/Source/iverilog-install/bin/vvp
:ivl_version "12.0 (devel)" "(s20150603-1539-g2693dd32b)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision - 12;
:vpi_module "C:\iverilog\lib\ivl\system.vpi";
:vpi_module "C:\iverilog\lib\ivl\vhdl_sys.vpi";
:vpi_module "C:\iverilog\lib\ivl\vhdl_textio.vpi";
:vpi_module "C:\iverilog\lib\ivl\v2005_math.vpi";
:vpi_module "C:\iverilog\lib\ivl\va_math.vpi";
:vpi_module "C:\iverilog\lib\ivl\v2009.vpi";
S_000001f7d27541f0 .scope package, "$unit" "$unit" 2 1;
 .timescale 0 0;
S_000001f7d2749fb0 .scope module, "tb_traffic_light_controller" "tb_traffic_light_controller" 3 5;
 .timescale -9 -12;
P_000001f7d2751350 .param/l "CLK_PERIOD" 1 3 10, +C4<00111011100110101100101000000000>;
P_000001f7d2751388 .param/l "S_EW_GREEN" 1 3 49, C4<010>;
P_000001f7d27513c0 .param/l "S_EW_YELLOW" 1 3 50, C4<011>;
P_000001f7d27513f8 .param/l "S_NS_GREEN" 1 3 47, C4<000>;
P_000001f7d2751430 .param/l "S_NS_YELLOW" 1 3 48, C4<001>;
P_000001f7d2751468 .param/l "S_PED_GREEN" 1 3 51, C4<100>;
v000001f7d27a8780_0 .var "clk", 0 0;
v000001f7d27a8820_0 .net "current_state", 2 0, L_000001f7d2745a30;  1 drivers
v000001f7d27a8960_0 .var "current_state_string", 63 0;
v000001f7d27aace0_0 .net "ew_light", 2 0, v000001f7d27a7ba0_0;  1 drivers
v000001f7d27a97a0_0 .net "ns_light", 2 0, v000001f7d27a7060_0;  1 drivers
v000001f7d27a9de0_0 .net "ped_latch_status", 0 0, L_000001f7d2745db0;  1 drivers
v000001f7d27a9ac0_0 .net "ped_light", 1 0, v000001f7d27a80a0_0;  1 drivers
v000001f7d27a9660_0 .var "pedestrian_request", 0 0;
v000001f7d27aad80_0 .var "reset", 0 0;
v000001f7d27a9700_0 .net "was_in_ns_phase_status", 0 0, L_000001f7d27458e0;  1 drivers
E_000001f7d2750630 .event anyedge, v000001f7d27a6fc0_0;
S_000001f7d2757cf0 .scope module, "dut" "traffic_light_controller" 3 33, 4 3 0, S_000001f7d2749fb0;
 .timescale -9 -12;
    .port_info 0 /INPUT 1 "clk";
    .port_info 1 /INPUT 1 "reset";
    .port_info 2 /INPUT 1 "pedestrian_request";
    .port_info 3 /OUTPUT 3 "ns_light";
    .port_info 4 /OUTPUT 3 "ew_light";
    .port_info 5 /OUTPUT 2 "ped_light";
    .port_info 6 /OUTPUT 3 "current_state";
    .port_info 7 /OUTPUT 1 "ped_request_latched_out";
    .port_info 8 /OUTPUT 1 "was_in_ns_phase_out";
P_000001f7d26f2ce0 .param/l "GREEN_DURATION" 0 4 28, +C4<00000000000000000000000000001010>;
P_000001f7d26f2d18 .param/l "PED_DURATION" 0 4 30, +C4<00000000000000000000000000000101>;
P_000001f7d26f2d50 .param/l "S_EW_GREEN" 0 4 20, C4<010>;
P_000001f7d26f2d88 .param/l "S_EW_YELLOW" 0 4 21, C4<011>;
P_000001f7d26f2dc0 .param/l "S_NS_GREEN" 0 4 18, C4<000>;
P_000001f7d26f2df8 .param/l "S_NS_YELLOW" 0 4 19, C4<001>;
P_000001f7d26f2e30 .param/l "S_PED_GREEN" 0 4 22, C4<100>;
P_000001f7d26f2e68 .param/l "YELLOW_DURATION" 0 4 29, +C4<00000000000000000000000000000011>;
L_000001f7d27453a0 .functor AND 1, L_000001f7d27a9200, L_000001f7d27a9f20, C4<1>, C4<1>;
L_000001f7d27454f0 .functor AND 1, L_000001f7d27aa7e0, L_000001f7d27aac40, C4<1>, C4<1>;
L_000001f7d2745d40 .functor OR 1, L_000001f7d27453a0, L_000001f7d27454f0, C4<0>, C4<0>;
L_000001f7d2745e20 .functor AND 1, L_000001f7d27a9e80, L_000001f7d27aa880, C4<1>, C4<1>;
L_000001f7d2745800 .functor OR 1, L_000001f7d2745d40, L_000001f7d2745e20, C4<0>, C4<0>;
L_000001f7d2745950 .functor AND 1, L_000001f7d27aa9c0, L_000001f7d27a9160, C4<1>, C4<1>;
L_000001f7d2745cd0 .functor OR 1, L_000001f7d2745800, L_000001f7d2745950, C4<0>, C4<0>;
L_000001f7d2745c60 .functor AND 1, L_000001f7d27a9840, L_000001f7d27a9340, C4<1>, C4<1>;
L_000001f7d2745870 .functor OR 1, L_000001f7d2745cd0, L_000001f7d2745c60, C4<0>, C4<0>;
L_000001f7d2745a30 .functor BUFZ 3, v000001f7d27a85a0_0, C4<000>, C4<000>, C4<000>;
L_000001f7d2745db0 .functor BUFZ 1, v000001f7d27a7920_0, C4<0>, C4<0>, C4<0>;
L_000001f7d27458e0 .functor BUFZ 1, v000001f7d27a7e20_0, C4<0>, C4<0>, C4<0>;
L_000001f7d2860088 .functor BUFT 1, C4<000>, C4<0>, C4<0>, C4<0>;
v000001f7d271e7b0_0 .net/2u *"_ivl_0", 2 0, L_000001f7d2860088;  1 drivers
v000001f7d271dbd0_0 .net *"_ivl_10", 0 0, L_000001f7d27a9f20;  1 drivers
v000001f7d271e8f0_0 .net *"_ivl_13", 0 0, L_000001f7d27453a0;  1 drivers
L_000001f7d2860160 .functor BUFT 1, C4<001>, C4<0>, C4<0>, C4<0>;
v000001f7d271e170_0 .net/2u *"_ivl_14", 2 0, L_000001f7d2860160;  1 drivers
v000001f7d271e990_0 .net *"_ivl_16", 0 0, L_000001f7d27aa7e0;  1 drivers
v000001f7d271ea30_0 .net *"_ivl_18", 31 0, L_000001f7d27aae20;  1 drivers
v000001f7d271e210_0 .net *"_ivl_2", 0 0, L_000001f7d27a9200;  1 drivers
L_000001f7d28601a8 .functor BUFT 1, C4<000000000000000000000000000>, C4<0>, C4<0>, C4<0>;
v000001f7d271e350_0 .net *"_ivl_21", 26 0, L_000001f7d28601a8;  1 drivers
L_000001f7d28601f0 .functor BUFT 1, C4<00000000000000000000000000000010>, C4<0>, C4<0>, C4<0>;
v000001f7d271e3f0_0 .net/2u *"_ivl_22", 31 0, L_000001f7d28601f0;  1 drivers
v000001f7d27a7380_0 .net *"_ivl_24", 0 0, L_000001f7d27aac40;  1 drivers
v000001f7d27a8b40_0 .net *"_ivl_27", 0 0, L_000001f7d27454f0;  1 drivers
v000001f7d27a7f60_0 .net *"_ivl_29", 0 0, L_000001f7d2745d40;  1 drivers
L_000001f7d2860238 .functor BUFT 1, C4<010>, C4<0>, C4<0>, C4<0>;
v000001f7d27a88c0_0 .net/2u *"_ivl_30", 2 0, L_000001f7d2860238;  1 drivers
v000001f7d27a7240_0 .net *"_ivl_32", 0 0, L_000001f7d27a9e80;  1 drivers
v000001f7d27a8320_0 .net *"_ivl_34", 31 0, L_000001f7d27aaec0;  1 drivers
L_000001f7d2860280 .functor BUFT 1, C4<000000000000000000000000000>, C4<0>, C4<0>, C4<0>;
v000001f7d27a7740_0 .net *"_ivl_37", 26 0, L_000001f7d2860280;  1 drivers
L_000001f7d28602c8 .functor BUFT 1, C4<00000000000000000000000000001001>, C4<0>, C4<0>, C4<0>;
v000001f7d27a8000_0 .net/2u *"_ivl_38", 31 0, L_000001f7d28602c8;  1 drivers
v000001f7d27a8c80_0 .net *"_ivl_4", 31 0, L_000001f7d27aaa60;  1 drivers
v000001f7d27a7c40_0 .net *"_ivl_40", 0 0, L_000001f7d27aa880;  1 drivers
v000001f7d27a8e60_0 .net *"_ivl_43", 0 0, L_000001f7d2745e20;  1 drivers
v000001f7d27a7560_0 .net *"_ivl_45", 0 0, L_000001f7d2745800;  1 drivers
L_000001f7d2860310 .functor BUFT 1, C4<011>, C4<0>, C4<0>, C4<0>;
v000001f7d27a8d20_0 .net/2u *"_ivl_46", 2 0, L_000001f7d2860310;  1 drivers
v000001f7d27a76a0_0 .net *"_ivl_48", 0 0, L_000001f7d27aa9c0;  1 drivers
v000001f7d27a7ce0_0 .net *"_ivl_50", 31 0, L_000001f7d27a92a0;  1 drivers
L_000001f7d2860358 .functor BUFT 1, C4<000000000000000000000000000>, C4<0>, C4<0>, C4<0>;
v000001f7d27a74c0_0 .net *"_ivl_53", 26 0, L_000001f7d2860358;  1 drivers
L_000001f7d28603a0 .functor BUFT 1, C4<00000000000000000000000000000010>, C4<0>, C4<0>, C4<0>;
v000001f7d27a7600_0 .net/2u *"_ivl_54", 31 0, L_000001f7d28603a0;  1 drivers
v000001f7d27a86e0_0 .net *"_ivl_56", 0 0, L_000001f7d27a9160;  1 drivers
v000001f7d27a7100_0 .net *"_ivl_59", 0 0, L_000001f7d2745950;  1 drivers
v000001f7d27a83c0_0 .net *"_ivl_61", 0 0, L_000001f7d2745cd0;  1 drivers
L_000001f7d28603e8 .functor BUFT 1, C4<100>, C4<0>, C4<0>, C4<0>;
v000001f7d27a8aa0_0 .net/2u *"_ivl_62", 2 0, L_000001f7d28603e8;  1 drivers
v000001f7d27a8a00_0 .net *"_ivl_64", 0 0, L_000001f7d27a9840;  1 drivers
v000001f7d27a8640_0 .net *"_ivl_66", 31 0, L_000001f7d27aa240;  1 drivers
L_000001f7d2860430 .functor BUFT 1, C4<000000000000000000000000000>, C4<0>, C4<0>, C4<0>;
v000001f7d27a7a60_0 .net *"_ivl_69", 26 0, L_000001f7d2860430;  1 drivers
L_000001f7d28600d0 .functor BUFT 1, C4<000000000000000000000000000>, C4<0>, C4<0>, C4<0>;
v000001f7d27a77e0_0 .net *"_ivl_7", 26 0, L_000001f7d28600d0;  1 drivers
L_000001f7d2860478 .functor BUFT 1, C4<00000000000000000000000000000100>, C4<0>, C4<0>, C4<0>;
v000001f7d27a71a0_0 .net/2u *"_ivl_70", 31 0, L_000001f7d2860478;  1 drivers
v000001f7d27a79c0_0 .net *"_ivl_72", 0 0, L_000001f7d27a9340;  1 drivers
v000001f7d27a7880_0 .net *"_ivl_75", 0 0, L_000001f7d2745c60;  1 drivers
L_000001f7d2860118 .functor BUFT 1, C4<00000000000000000000000000001001>, C4<0>, C4<0>, C4<0>;
v000001f7d27a72e0_0 .net/2u *"_ivl_8", 31 0, L_000001f7d2860118;  1 drivers
v000001f7d27a8be0_0 .net "clk", 0 0, v000001f7d27a8780_0;  1 drivers
v000001f7d27a6fc0_0 .net "current_state", 2 0, L_000001f7d2745a30;  alias, 1 drivers
v000001f7d27a7ba0_0 .var "ew_light", 2 0;
v000001f7d27a8dc0_0 .var "next_state", 2 0;
v000001f7d27a7060_0 .var "ns_light", 2 0;
v000001f7d27a80a0_0 .var "ped_light", 1 0;
v000001f7d27a7920_0 .var "ped_request_latched", 0 0;
v000001f7d27a8500_0 .net "ped_request_latched_out", 0 0, L_000001f7d2745db0;  alias, 1 drivers
v000001f7d27a7420_0 .net "pedestrian_request", 0 0, v000001f7d27a9660_0;  1 drivers
v000001f7d27a7b00_0 .net "reset", 0 0, v000001f7d27aad80_0;  1 drivers
v000001f7d27a85a0_0 .var "state_reg", 2 0;
v000001f7d27a8140_0 .var "timer_count", 4 0;
v000001f7d27a7d80_0 .net "timer_done", 0 0, L_000001f7d2745870;  1 drivers
v000001f7d27a7e20_0 .var "was_in_ns_phase", 0 0;
v000001f7d27a7ec0_0 .net "was_in_ns_phase_out", 0 0, L_000001f7d27458e0;  alias, 1 drivers
E_000001f7d2750470 .event anyedge, v000001f7d27a85a0_0;
E_000001f7d2750270 .event anyedge, v000001f7d27a85a0_0, v000001f7d27a7d80_0, v000001f7d27a7920_0, v000001f7d27a7e20_0;
E_000001f7d27508f0 .event posedge, v000001f7d27a7b00_0, v000001f7d27a8be0_0;
L_000001f7d27a9200 .cmp/eq 3, v000001f7d27a85a0_0, L_000001f7d2860088;
L_000001f7d27aaa60 .concat [ 5 27 0 0], v000001f7d27a8140_0, L_000001f7d28600d0;
L_000001f7d27a9f20 .cmp/eq 32, L_000001f7d27aaa60, L_000001f7d2860118;
L_000001f7d27aa7e0 .cmp/eq 3, v000001f7d27a85a0_0, L_000001f7d2860160;
L_000001f7d27aae20 .concat [ 5 27 0 0], v000001f7d27a8140_0, L_000001f7d28601a8;
L_000001f7d27aac40 .cmp/eq 32, L_000001f7d27aae20, L_000001f7d28601f0;
L_000001f7d27a9e80 .cmp/eq 3, v000001f7d27a85a0_0, L_000001f7d2860238;
L_000001f7d27aaec0 .concat [ 5 27 0 0], v000001f7d27a8140_0, L_000001f7d2860280;
L_000001f7d27aa880 .cmp/eq 32, L_000001f7d27aaec0, L_000001f7d28602c8;
L_000001f7d27aa9c0 .cmp/eq 3, v000001f7d27a85a0_0, L_000001f7d2860310;
L_000001f7d27a92a0 .concat [ 5 27 0 0], v000001f7d27a8140_0, L_000001f7d2860358;
L_000001f7d27a9160 .cmp/eq 32, L_000001f7d27a92a0, L_000001f7d28603a0;
L_000001f7d27a9840 .cmp/eq 3, v000001f7d27a85a0_0, L_000001f7d28603e8;
L_000001f7d27aa240 .concat [ 5 27 0 0], v000001f7d27a8140_0, L_000001f7d2860430;
L_000001f7d27a9340 .cmp/eq 32, L_000001f7d27aa240, L_000001f7d2860478;
S_000001f7d26f2eb0 .scope function.vec4.s64, "state_to_string" "state_to_string" 3 148, 3 148 0, S_000001f7d2749fb0;
 .timescale -9 -12;
v000001f7d27a81e0_0 .var "state", 2 0;
; Variable state_to_string is vec4 return value of scope S_000001f7d26f2eb0
TD_tb_traffic_light_controller.state_to_string ;
    %load/vec4 v000001f7d27a81e0_0;
    %dup/vec4;
    %pushi/vec4 0, 0, 3;
    %cmp/u;
    %jmp/1 T_0.0, 6;
    %dup/vec4;
    %pushi/vec4 1, 0, 3;
    %cmp/u;
    %jmp/1 T_0.1, 6;
    %dup/vec4;
    %pushi/vec4 2, 0, 3;
    %cmp/u;
    %jmp/1 T_0.2, 6;
    %dup/vec4;
    %pushi/vec4 3, 0, 3;
    %cmp/u;
    %jmp/1 T_0.3, 6;
    %dup/vec4;
    %pushi/vec4 4, 0, 3;
    %cmp/u;
    %jmp/1 T_0.4, 6;
    %pushi/vec4 22616, 0, 32; draw_string_vec4
    %pushi/vec4 1482184792, 0, 32; draw_string_vec4
    %concat/vec4; draw_string_vec4
    %ret/vec4 0, 0, 64;  Assign to state_to_string (store_vec4_to_lval)
    %jmp T_0.6;
T_0.0 ;
    %pushi/vec4 20051, 0, 32; draw_string_vec4
    %pushi/vec4 1598509646, 0, 32; draw_string_vec4
    %concat/vec4; draw_string_vec4
    %ret/vec4 0, 0, 64;  Assign to state_to_string (store_vec4_to_lval)
    %jmp T_0.6;
T_0.1 ;
    %pushi/vec4 20051, 0, 32; draw_string_vec4
    %pushi/vec4 1599685964, 0, 32; draw_string_vec4
    %concat/vec4; draw_string_vec4
    %ret/vec4 0, 0, 64;  Assign to state_to_string (store_vec4_to_lval)
    %jmp T_0.6;
T_0.2 ;
    %pushi/vec4 17751, 0, 32; draw_string_vec4
    %pushi/vec4 1598509646, 0, 32; draw_string_vec4
    %concat/vec4; draw_string_vec4
    %ret/vec4 0, 0, 64;  Assign to state_to_string (store_vec4_to_lval)
    %jmp T_0.6;
T_0.3 ;
    %pushi/vec4 17751, 0, 32; draw_string_vec4
    %pushi/vec4 1599685964, 0, 32; draw_string_vec4
    %concat/vec4; draw_string_vec4
    %ret/vec4 0, 0, 64;  Assign to state_to_string (store_vec4_to_lval)
    %jmp T_0.6;
T_0.4 ;
    %pushi/vec4 5260612, 0, 32; draw_string_vec4
    %pushi/vec4 1598509646, 0, 32; draw_string_vec4
    %concat/vec4; draw_string_vec4
    %ret/vec4 0, 0, 64;  Assign to state_to_string (store_vec4_to_lval)
    %jmp T_0.6;
T_0.6 ;
    %pop/vec4 1;
    %end;
S_000001f7d27a8f80 .scope task, "wait_cycles" "wait_cycles" 3 67, 3 67 0, S_000001f7d2749fb0;
 .timescale -9 -12;
v000001f7d27a8460_0 .var/i "n", 31 0;
E_000001f7d2750e30 .event posedge, v000001f7d27a8be0_0;
TD_tb_traffic_light_controller.wait_cycles ;
    %load/vec4 v000001f7d27a8460_0;
T_1.7 %dup/vec4;
    %pushi/vec4 0, 0, 32;
    %cmp/s;
    %jmp/1xz T_1.8, 5;
    %jmp/1 T_1.8, 4;
    %pushi/vec4 1, 0, 32;
    %sub;
    %wait E_000001f7d2750e30;
    %jmp T_1.7;
T_1.8 ;
    %pop/vec4 1;
    %end;
    .scope S_000001f7d2757cf0;
T_2 ;
    %wait E_000001f7d27508f0;
    %load/vec4 v000001f7d27a7b00_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_2.0, 8;
    %pushi/vec4 0, 0, 3;
    %assign/vec4 v000001f7d27a85a0_0, 0;
    %pushi/vec4 0, 0, 5;
    %assign/vec4 v000001f7d27a8140_0, 0;
    %pushi/vec4 0, 0, 1;
    %assign/vec4 v000001f7d27a7e20_0, 0;
    %jmp T_2.1;
T_2.0 ;
    %load/vec4 v000001f7d27a8dc0_0;
    %load/vec4 v000001f7d27a85a0_0;
    %cmp/ne;
    %jmp/0xz  T_2.2, 4;
    %pushi/vec4 0, 0, 5;
    %assign/vec4 v000001f7d27a8140_0, 0;
    %jmp T_2.3;
T_2.2 ;
    %load/vec4 v000001f7d27a7d80_0;
    %nor/r;
    %flag_set/vec4 8;
    %jmp/0xz  T_2.4, 8;
    %load/vec4 v000001f7d27a8140_0;
    %addi 1, 0, 5;
    %assign/vec4 v000001f7d27a8140_0, 0;
T_2.4 ;
T_2.3 ;
    %load/vec4 v000001f7d27a8dc0_0;
    %assign/vec4 v000001f7d27a85a0_0, 0;
    %load/vec4 v000001f7d27a8dc0_0;
    %cmpi/e 4, 0, 3;
    %jmp/0xz  T_2.6, 4;
    %load/vec4 v000001f7d27a85a0_0;
    %cmpi/e 1, 0, 3;
    %jmp/0xz  T_2.8, 4;
    %pushi/vec4 1, 0, 1;
    %assign/vec4 v000001f7d27a7e20_0, 0;
    %jmp T_2.9;
T_2.8 ;
    %load/vec4 v000001f7d27a85a0_0;
    %cmpi/e 3, 0, 3;
    %jmp/0xz  T_2.10, 4;
    %pushi/vec4 0, 0, 1;
    %assign/vec4 v000001f7d27a7e20_0, 0;
T_2.10 ;
T_2.9 ;
T_2.6 ;
T_2.1 ;
    %jmp T_2;
    .thread T_2;
    .scope S_000001f7d2757cf0;
T_3 ;
    %wait E_000001f7d27508f0;
    %load/vec4 v000001f7d27a7b00_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_3.0, 8;
    %pushi/vec4 0, 0, 1;
    %assign/vec4 v000001f7d27a7920_0, 0;
    %jmp T_3.1;
T_3.0 ;
    %load/vec4 v000001f7d27a7420_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_3.2, 8;
    %pushi/vec4 1, 0, 1;
    %assign/vec4 v000001f7d27a7920_0, 0;
    %jmp T_3.3;
T_3.2 ;
    %load/vec4 v000001f7d27a85a0_0;
    %cmpi/e 1, 0, 3;
    %flag_get/vec4 4;
    %jmp/0 T_3.8, 4;
    %load/vec4 v000001f7d27a7d80_0;
    %and;
T_3.8;
    %flag_set/vec4 9;
    %flag_get/vec4 9;
    %jmp/0 T_3.7, 9;
    %load/vec4 v000001f7d27a7920_0;
    %and;
T_3.7;
    %flag_set/vec4 8;
    %jmp/1 T_3.6, 8;
    %load/vec4 v000001f7d27a85a0_0;
    %cmpi/e 3, 0, 3;
    %flag_get/vec4 4;
    %jmp/0 T_3.10, 4;
    %load/vec4 v000001f7d27a7d80_0;
    %and;
T_3.10;
    %flag_set/vec4 10;
    %flag_get/vec4 10;
    %jmp/0 T_3.9, 10;
    %load/vec4 v000001f7d27a7920_0;
    %and;
T_3.9;
    %flag_set/vec4 9;
    %flag_or 8, 9;
T_3.6;
    %jmp/0xz  T_3.4, 8;
    %pushi/vec4 0, 0, 1;
    %assign/vec4 v000001f7d27a7920_0, 0;
T_3.4 ;
T_3.3 ;
T_3.1 ;
    %jmp T_3;
    .thread T_3;
    .scope S_000001f7d2757cf0;
T_4 ;
    %wait E_000001f7d2750270;
    %load/vec4 v000001f7d27a85a0_0;
    %store/vec4 v000001f7d27a8dc0_0, 0, 3;
    %load/vec4 v000001f7d27a85a0_0;
    %dup/vec4;
    %pushi/vec4 0, 0, 3;
    %cmp/u;
    %jmp/1 T_4.0, 6;
    %dup/vec4;
    %pushi/vec4 1, 0, 3;
    %cmp/u;
    %jmp/1 T_4.1, 6;
    %dup/vec4;
    %pushi/vec4 2, 0, 3;
    %cmp/u;
    %jmp/1 T_4.2, 6;
    %dup/vec4;
    %pushi/vec4 3, 0, 3;
    %cmp/u;
    %jmp/1 T_4.3, 6;
    %dup/vec4;
    %pushi/vec4 4, 0, 3;
    %cmp/u;
    %jmp/1 T_4.4, 6;
    %pushi/vec4 0, 0, 3;
    %store/vec4 v000001f7d27a8dc0_0, 0, 3;
    %jmp T_4.6;
T_4.0 ;
    %load/vec4 v000001f7d27a7d80_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_4.7, 8;
    %pushi/vec4 1, 0, 3;
    %store/vec4 v000001f7d27a8dc0_0, 0, 3;
T_4.7 ;
    %jmp T_4.6;
T_4.1 ;
    %load/vec4 v000001f7d27a7d80_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_4.9, 8;
    %load/vec4 v000001f7d27a7920_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_4.11, 8;
    %pushi/vec4 4, 0, 3;
    %store/vec4 v000001f7d27a8dc0_0, 0, 3;
    %jmp T_4.12;
T_4.11 ;
    %pushi/vec4 2, 0, 3;
    %store/vec4 v000001f7d27a8dc0_0, 0, 3;
T_4.12 ;
T_4.9 ;
    %jmp T_4.6;
T_4.2 ;
    %load/vec4 v000001f7d27a7d80_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_4.13, 8;
    %pushi/vec4 3, 0, 3;
    %store/vec4 v000001f7d27a8dc0_0, 0, 3;
T_4.13 ;
    %jmp T_4.6;
T_4.3 ;
    %load/vec4 v000001f7d27a7d80_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_4.15, 8;
    %load/vec4 v000001f7d27a7920_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_4.17, 8;
    %pushi/vec4 4, 0, 3;
    %store/vec4 v000001f7d27a8dc0_0, 0, 3;
    %jmp T_4.18;
T_4.17 ;
    %pushi/vec4 0, 0, 3;
    %store/vec4 v000001f7d27a8dc0_0, 0, 3;
T_4.18 ;
T_4.15 ;
    %jmp T_4.6;
T_4.4 ;
    %load/vec4 v000001f7d27a7d80_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_4.19, 8;
    %load/vec4 v000001f7d27a7e20_0;
    %flag_set/vec4 8;
    %jmp/0xz  T_4.21, 8;
    %pushi/vec4 2, 0, 3;
    %store/vec4 v000001f7d27a8dc0_0, 0, 3;
    %jmp T_4.22;
T_4.21 ;
    %pushi/vec4 0, 0, 3;
    %store/vec4 v000001f7d27a8dc0_0, 0, 3;
T_4.22 ;
T_4.19 ;
    %jmp T_4.6;
T_4.6 ;
    %pop/vec4 1;
    %jmp T_4;
    .thread T_4, $push;
    .scope S_000001f7d2757cf0;
T_5 ;
    %wait E_000001f7d2750470;
    %pushi/vec4 1, 0, 3;
    %store/vec4 v000001f7d27a7060_0, 0, 3;
    %pushi/vec4 1, 0, 3;
    %store/vec4 v000001f7d27a7ba0_0, 0, 3;
    %pushi/vec4 1, 0, 2;
    %store/vec4 v000001f7d27a80a0_0, 0, 2;
    %load/vec4 v000001f7d27a85a0_0;
    %dup/vec4;
    %pushi/vec4 0, 0, 3;
    %cmp/u;
    %jmp/1 T_5.0, 6;
    %dup/vec4;
    %pushi/vec4 1, 0, 3;
    %cmp/u;
    %jmp/1 T_5.1, 6;
    %dup/vec4;
    %pushi/vec4 2, 0, 3;
    %cmp/u;
    %jmp/1 T_5.2, 6;
    %dup/vec4;
    %pushi/vec4 3, 0, 3;
    %cmp/u;
    %jmp/1 T_5.3, 6;
    %dup/vec4;
    %pushi/vec4 4, 0, 3;
    %cmp/u;
    %jmp/1 T_5.4, 6;
    %jmp T_5.6;
T_5.0 ;
    %pushi/vec4 4, 0, 3;
    %store/vec4 v000001f7d27a7060_0, 0, 3;
    %jmp T_5.6;
T_5.1 ;
    %pushi/vec4 2, 0, 3;
    %store/vec4 v000001f7d27a7060_0, 0, 3;
    %jmp T_5.6;
T_5.2 ;
    %pushi/vec4 4, 0, 3;
    %store/vec4 v000001f7d27a7ba0_0, 0, 3;
    %jmp T_5.6;
T_5.3 ;
    %pushi/vec4 2, 0, 3;
    %store/vec4 v000001f7d27a7ba0_0, 0, 3;
    %jmp T_5.6;
T_5.4 ;
    %pushi/vec4 2, 0, 2;
    %store/vec4 v000001f7d27a80a0_0, 0, 2;
    %jmp T_5.6;
T_5.6 ;
    %pop/vec4 1;
    %jmp T_5;
    .thread T_5, $push;
    .scope S_000001f7d2749fb0;
T_6 ;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v000001f7d27a8780_0, 0, 1;
T_6.0 ;
    %delay 1783793664, 116;
    %load/vec4 v000001f7d27a8780_0;
    %inv;
    %store/vec4 v000001f7d27a8780_0, 0, 1;
    %jmp T_6.0;
    %end;
    .thread T_6;
    .scope S_000001f7d2749fb0;
T_7 ;
    %wait E_000001f7d2750630;
    %load/vec4 v000001f7d27a8820_0;
    %store/vec4 v000001f7d27a81e0_0, 0, 3;
    %callf/vec4 TD_tb_traffic_light_controller.state_to_string, S_000001f7d26f2eb0;
    %store/vec4 v000001f7d27a8960_0, 0, 64;
    %jmp T_7;
    .thread T_7, $push;
    .scope S_000001f7d2749fb0;
T_8 ;
    %vpi_call/w 3 78 "$dumpfile", "simulation_waves.vcd" {0 0 0};
    %vpi_call/w 3 79 "$dumpvars", 32'sb00000000000000000000000000000000, S_000001f7d2749fb0 {0 0 0};
    %vpi_call/w 3 81 "$display", "-------------------------------------------------" {0 0 0};
    %vpi_call/w 3 82 "$display", "Starting Testbench for Traffic Light Controller" {0 0 0};
    %vpi_call/w 3 83 "$display", "-------------------------------------------------" {0 0 0};
    %vpi_call/w 3 84 "$monitor", "Time: %0t | State: %s | NS: %b | EW: %b | PED: %b | PedReq: %b | LATCH: %b | PHASE: %b", $time, v000001f7d27a8960_0, v000001f7d27a97a0_0, v000001f7d27aace0_0, v000001f7d27a9ac0_0, v000001f7d27a9660_0, v000001f7d27a9de0_0, v000001f7d27a9700_0 {0 0 0};
    %vpi_call/w 3 88 "$display", "\012[Scenario 1] Reset and Normal Cycle (No Ped Request)" {0 0 0};
    %pushi/vec4 1, 0, 1;
    %store/vec4 v000001f7d27aad80_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v000001f7d27a9660_0, 0, 1;
    %pushi/vec4 2, 0, 32;
    %store/vec4 v000001f7d27a8460_0, 0, 32;
    %fork TD_tb_traffic_light_controller.wait_cycles, S_000001f7d27a8f80;
    %join;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v000001f7d27aad80_0, 0, 1;
    %vpi_call/w 3 94 "$display", "Reset released. Running for 2 full cycles..." {0 0 0};
    %pushi/vec4 52, 0, 32;
    %store/vec4 v000001f7d27a8460_0, 0, 32;
    %fork TD_tb_traffic_light_controller.wait_cycles, S_000001f7d27a8f80;
    %join;
    %vpi_call/w 3 98 "$display", "\012[Scenario 2] Ped Request during NS_GREEN (Tests starvation fix)" {0 0 0};
    %wait E_000001f7d2750e30;
T_8.0 ;
    %load/vec4 v000001f7d27a8820_0;
    %cmpi/ne 0, 0, 3;
    %jmp/0xz T_8.1, 4;
    %wait E_000001f7d2750e30;
    %jmp T_8.0;
T_8.1 ;
    %pushi/vec4 2, 0, 32;
    %store/vec4 v000001f7d27a8460_0, 0, 32;
    %fork TD_tb_traffic_light_controller.wait_cycles, S_000001f7d27a8f80;
    %join;
    %vpi_call/w 3 103 "$display", "--> Issuing pedestrian request at time %0t", $time {0 0 0};
    %pushi/vec4 1, 0, 1;
    %store/vec4 v000001f7d27a9660_0, 0, 1;
    %wait E_000001f7d2750e30;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v000001f7d27a9660_0, 0, 1;
    %vpi_call/w 3 110 "$display", "...Verifying FSM goes to EW_GREEN after PED_GREEN..." {0 0 0};
    %pushi/vec4 28, 0, 32;
    %store/vec4 v000001f7d27a8460_0, 0, 32;
    %fork TD_tb_traffic_light_controller.wait_cycles, S_000001f7d27a8f80;
    %join;
    %vpi_call/w 3 114 "$display", "\012[Scenario 3] Back-to-Back Ped Request (during PED_GREEN)" {0 0 0};
    %wait E_000001f7d2750e30;
T_8.2 ;
    %load/vec4 v000001f7d27a8820_0;
    %cmpi/ne 0, 0, 3;
    %jmp/0xz T_8.3, 4;
    %wait E_000001f7d2750e30;
    %jmp T_8.2;
T_8.3 ;
    %pushi/vec4 2, 0, 32;
    %store/vec4 v000001f7d27a8460_0, 0, 32;
    %fork TD_tb_traffic_light_controller.wait_cycles, S_000001f7d27a8f80;
    %join;
    %vpi_call/w 3 119 "$display", "--> Issuing 1st request at time %0t", $time {0 0 0};
    %pushi/vec4 1, 0, 1;
    %store/vec4 v000001f7d27a9660_0, 0, 1;
    %wait E_000001f7d2750e30;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v000001f7d27a9660_0, 0, 1;
    %wait E_000001f7d2750e30;
T_8.4 ;
    %load/vec4 v000001f7d27a8820_0;
    %cmpi/ne 4, 0, 3;
    %jmp/0xz T_8.5, 4;
    %wait E_000001f7d2750e30;
    %jmp T_8.4;
T_8.5 ;
    %pushi/vec4 1, 0, 32;
    %store/vec4 v000001f7d27a8460_0, 0, 32;
    %fork TD_tb_traffic_light_controller.wait_cycles, S_000001f7d27a8f80;
    %join;
    %vpi_call/w 3 129 "$display", "--> FSM is in PED_GREEN. Issuing 2nd request at time %0t", $time {0 0 0};
    %pushi/vec4 1, 0, 1;
    %store/vec4 v000001f7d27a9660_0, 0, 1;
    %wait E_000001f7d2750e30;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v000001f7d27a9660_0, 0, 1;
    %vpi_call/w 3 140 "$display", "...Verifying FSM completes full cycle before servicing 2nd request..." {0 0 0};
    %pushi/vec4 27, 0, 32;
    %store/vec4 v000001f7d27a8460_0, 0, 32;
    %fork TD_tb_traffic_light_controller.wait_cycles, S_000001f7d27a8f80;
    %join;
    %vpi_call/w 3 143 "$display", "\012[Testbench] All scenarios complete." {0 0 0};
    %vpi_call/w 3 144 "$finish" {0 0 0};
    %end;
    .thread T_8;
# The file index is used to find the file name in the following table.
:file_names 5;
    "N/A";
    "<interactive>";
    "-";
    "tb_project.v";
    "project.v";
