
Q
Command: %s
53*	vivadotcl2 
route_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a35t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a35t2default:defaultZ17-349h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
42default:defaultZ23-27h px� 
�

�Clock Placer Checks: Poor placement for routing between an IO pin and BUFG. 
Resolution: Poor placement of an IO pin and a BUFG has resulted in the router using a non-dedicated path between the two.  There are several things that could trigger this DRC, each of which can cause unpredictable clock insertion delays that result in poor timing.  This DRC could be caused by any of the following: (a) a clock port was placed on a pin that is not a CCIO-pin (b)the BUFG has not been placed in the same half of the device or SLR as the CCIO-pin (c) a single ended clock has been placed on the N-Side of a differential pair CCIO-pin.
 This is normally an ERROR but the CLOCK_DEDICATED_ROUTE constraint is set to FALSE allowing your design to continue. The use of this override is highly discouraged as it may lead to very poor timing results. It is recommended that this error condition be corrected in the design.

	%s (IBUF.O) is locked to %s
	%s (BUFG.I) is provisionally placed by clockplacer on %s
%s*DRC2P
 ":
PHY_RXC_IBUF_inst	PHY_RXC_IBUF_inst2default:default2default:default2@
 "*
	IOB_X0Y33
	IOB_X0Y332default:default2default:default2Z
 "D
PHY_RXC_IBUF_BUFG_inst	PHY_RXC_IBUF_BUFG_inst2default:default2default:default2H
 "2
BUFGCTRL_X0Y2
BUFGCTRL_X0Y22default:default2default:default2;
 #DRC|Implementation|Placement|Clocks2default:default8ZPLCK-12h px� 
b
DRC finished with %s
79*	vivadotcl2(
0 Errors, 1 Warnings2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
V

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px� 
}
BMultithreading enabled for route_design using a maximum of %s CPUs17*	routeflow2
42default:defaultZ35-254h px� 
p

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px� 
C
.Phase 1 Build RT Design | Checksum: 11e892721
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:14 ; elapsed = 00:00:10 . Memory (MB): peak = 3134.953 ; gain = 0.000 ; free physical = 5180 ; free virtual = 119102default:defaulth px� 
v

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px� 
o

Phase %s%s
101*constraints2
2.1 2default:default2 
Create Timer2default:defaultZ18-101h px� 
B
-Phase 2.1 Create Timer | Checksum: 11e892721
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:15 ; elapsed = 00:00:10 . Memory (MB): peak = 3134.953 ; gain = 0.000 ; free physical = 5172 ; free virtual = 119022default:defaulth px� 
{

Phase %s%s
101*constraints2
2.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px� 
N
9Phase 2.2 Fix Topology Constraints | Checksum: 11e892721
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:15 ; elapsed = 00:00:11 . Memory (MB): peak = 3134.953 ; gain = 0.000 ; free physical = 5151 ; free virtual = 118812default:defaulth px� 
t

Phase %s%s
101*constraints2
2.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px� 
G
2Phase 2.3 Pre Route Cleanup | Checksum: 11e892721
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:15 ; elapsed = 00:00:11 . Memory (MB): peak = 3134.953 ; gain = 0.000 ; free physical = 5152 ; free virtual = 118822default:defaulth px� 
p

Phase %s%s
101*constraints2
2.4 2default:default2!
Update Timing2default:defaultZ18-101h px� 
B
-Phase 2.4 Update Timing | Checksum: c1275d91
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:24 ; elapsed = 00:00:16 . Memory (MB): peak = 3134.953 ; gain = 0.000 ; free physical = 5168 ; free virtual = 118992default:defaulth px� 
�
Intermediate Timing Summary %s164*route2N
:| WNS=-5.637 | TNS=-3117.407| WHS=-3.621 | THS=-1163.242|
2default:defaultZ35-416h px� 
}

Phase %s%s
101*constraints2
2.5 2default:default2.
Update Timing for Bus Skew2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
2.5.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
E
0Phase 2.5.1 Update Timing | Checksum: 11ebbee39
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:30 ; elapsed = 00:00:18 . Memory (MB): peak = 3134.953 ; gain = 0.000 ; free physical = 5175 ; free virtual = 118932default:defaulth px� 
�
Intermediate Timing Summary %s164*route2L
8| WNS=-5.637 | TNS=-3114.869| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
O
:Phase 2.5 Update Timing for Bus Skew | Checksum: c7174efa
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:30 ; elapsed = 00:00:18 . Memory (MB): peak = 3134.953 ; gain = 0.000 ; free physical = 5168 ; free virtual = 118872default:defaulth px� 
I
4Phase 2 Router Initialization | Checksum: 18b5f2adf
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:30 ; elapsed = 00:00:18 . Memory (MB): peak = 3134.953 ; gain = 0.000 ; free physical = 5168 ; free virtual = 118872default:defaulth px� 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px� 
q

Phase %s%s
101*constraints2
3.1 2default:default2"
Global Routing2default:defaultZ18-101h px� 
D
/Phase 3.1 Global Routing | Checksum: 18b5f2adf
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:31 ; elapsed = 00:00:18 . Memory (MB): peak = 3134.953 ; gain = 0.000 ; free physical = 5165 ; free virtual = 118852default:defaulth px� 
C
.Phase 3 Initial Routing | Checksum: 1e2275d00
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:59 ; elapsed = 00:00:26 . Memory (MB): peak = 3199.180 ; gain = 64.227 ; free physical = 5160 ; free virtual = 118712default:defaulth px� 
�
>Design has %s pins with tight setup and hold constraints.

%s
244*route2
892default:default2�
�The top 5 pins with tight setup and hold constraints:

+--------------------------+--------------------------+----------------------------------------------------------------------------------------------------------+
|       Launch Clock       |      Capture Clock       |                                                 Pin                                                      |
+--------------------------+--------------------------+----------------------------------------------------------------------------------------------------------+
|                  PHY_RXC |                  PHY_RXC |      iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_cap_ctrl/U_CDONE/I_YESLUT6.I_YES_OREG.O_reg_reg/D|
|                  PHY_RXC |                  PHY_RXC |        iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_cap_ctrl/U_NS0/I_YESLUT6.I_YES_OREG.O_reg_reg/D|
|                  PHY_RXC |                  PHY_RXC |        iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_cap_ctrl/U_NS1/I_YESLUT6.I_YES_OREG.O_reg_reg/D|
|                  PHY_RXC |                  PHY_RXC |iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_cap_ctrl/u_cap_addrgen/u_cap_window_counter/iwcnt_reg[5]/CE|
|                  PHY_RXC |                  PHY_RXC |iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_cap_ctrl/u_cap_addrgen/u_cap_window_counter/iwcnt_reg[2]/CE|
+--------------------------+--------------------------+----------------------------------------------------------------------------------------------------------+

File with complete list of pins: tight_setup_hold_pins.txt
2default:defaultZ35-580h px� 
s

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px� 
u

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px� 
�
Intermediate Timing Summary %s164*route2L
8| WNS=-5.751 | TNS=-3340.073| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
H
3Phase 4.1 Global Iteration 0 | Checksum: 20c79ab91
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:33 ; elapsed = 00:00:46 . Memory (MB): peak = 3199.180 ; gain = 64.227 ; free physical = 5163 ; free virtual = 118732default:defaulth px� 
u

Phase %s%s
101*constraints2
4.2 2default:default2&
Global Iteration 12default:defaultZ18-101h px� 
�
Intermediate Timing Summary %s164*route2L
8| WNS=-6.091 | TNS=-3323.004| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
H
3Phase 4.2 Global Iteration 1 | Checksum: 17507303a
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:34 ; elapsed = 00:00:47 . Memory (MB): peak = 3199.180 ; gain = 64.227 ; free physical = 5163 ; free virtual = 118722default:defaulth px� 
F
1Phase 4 Rip-up And Reroute | Checksum: 17507303a
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:34 ; elapsed = 00:00:47 . Memory (MB): peak = 3199.180 ; gain = 64.227 ; free physical = 5163 ; free virtual = 118722default:defaulth px� 
|

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
5.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
5.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
E
0Phase 5.1.1 Update Timing | Checksum: 1417370d0
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:36 ; elapsed = 00:00:48 . Memory (MB): peak = 3199.180 ; gain = 64.227 ; free physical = 5164 ; free virtual = 118732default:defaulth px� 
�
Intermediate Timing Summary %s164*route2L
8| WNS=-5.751 | TNS=-3336.711| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
C
.Phase 5.1 Delay CleanUp | Checksum: 248848566
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:37 ; elapsed = 00:00:48 . Memory (MB): peak = 3199.180 ; gain = 64.227 ; free physical = 5158 ; free virtual = 118672default:defaulth px� 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px� 
M
8Phase 5.2 Clock Skew Optimization | Checksum: 248848566
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:37 ; elapsed = 00:00:49 . Memory (MB): peak = 3199.180 ; gain = 64.227 ; free physical = 5158 ; free virtual = 118672default:defaulth px� 
O
:Phase 5 Delay and Skew Optimization | Checksum: 248848566
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:37 ; elapsed = 00:00:49 . Memory (MB): peak = 3199.180 ; gain = 64.227 ; free physical = 5158 ; free virtual = 118672default:defaulth px� 
n

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
6.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
6.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
E
0Phase 6.1.1 Update Timing | Checksum: 162fbd3c6
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:39 ; elapsed = 00:00:50 . Memory (MB): peak = 3199.180 ; gain = 64.227 ; free physical = 5158 ; free virtual = 118682default:defaulth px� 
�
Intermediate Timing Summary %s164*route2L
8| WNS=-5.751 | TNS=-3309.466| WHS=-5.912 | THS=-33.360|
2default:defaultZ35-416h px� 
C
.Phase 6.1 Hold Fix Iter | Checksum: 159217e50
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:44 ; elapsed = 00:00:52 . Memory (MB): peak = 3265.180 ; gain = 130.227 ; free physical = 5137 ; free virtual = 118462default:defaulth px� 
�
�The router encountered %s pins that are both setup-critical and hold-critical and tried to fix hold violations at the expense of setup slack. Such pins are:
%s201*route2
652default:default2�
�	iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_cap_ctrl/u_cap_addrgen/u_cap_sample_counter/u_scnt_cmp/allx_typeA_match_detection.ltlib_v1_0_0_allx_typeA_inst/DUT/I_WHOLE_SLICE.G_SLICE_IDX[1].U_ALL_SRL_SLICE/u_carry4_inst/S[0]
	iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_cap_ctrl/u_cap_addrgen/u_cap_sample_counter/u_scnt_cmp/allx_typeA_match_detection.ltlib_v1_0_0_allx_typeA_inst/DUT/I_WHOLE_SLICE.G_SLICE_IDX[1].U_ALL_SRL_SLICE/u_carry4_inst/DI[0]
	iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_cap_ctrl/u_cap_addrgen/u_cap_sample_counter/u_scnt_cmp/allx_typeA_match_detection.ltlib_v1_0_0_allx_typeA_inst/DUT/I_WHOLE_SLICE.G_SLICE_IDX[1].U_ALL_SRL_SLICE/u_carry4_inst/S[1]
	iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_cap_ctrl/u_cap_addrgen/u_cap_sample_counter/u_scnt_cmp/allx_typeA_match_detection.ltlib_v1_0_0_allx_typeA_inst/DUT/I_WHOLE_SLICE.G_SLICE_IDX[1].U_ALL_SRL_SLICE/u_carry4_inst/DI[1]
	iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_cap_ctrl/u_cap_addrgen/u_cap_window_counter/iwcnt_reg[0]/CE
	iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_cap_ctrl/u_cap_addrgen/u_cap_window_counter/iwcnt_reg[10]/CE
	iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_cap_ctrl/u_cap_addrgen/u_cap_window_counter/u_wcnt_lcmp_q/CE
	iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_regs/reg_7/I_EN_CTL_EQ1.U_CTL/u_scnt_cmp_q_i_2/I1
	iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_cap_ctrl/u_cap_addrgen/u_cap_window_counter/u_wcnt_lcmp/allx_typeA_match_detection.ltlib_v1_0_0_allx_typeA_inst/DUT/I_WHOLE_SLICE.G_SLICE_IDX[1].U_ALL_SRL_SLICE/u_carry4_inst/S[0]
	iprecieve_inst/eth_rx_dbg/inst/ila_core_inst/u_ila_cap_ctrl/u_cap_addrgen/u_cap_window_counter/u_wcnt_lcmp/allx_typeA_match_detection.ltlib_v1_0_0_allx_typeA_inst/DUT/I_WHOLE_SLICE.G_SLICE_IDX[1].U_ALL_SRL_SLICE/u_carry4_inst/DI[0]
	.. and 55 more pins.
2default:defaultZ35-468h px� 
A
,Phase 6 Post Hold Fix | Checksum: 133d5f346
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:44 ; elapsed = 00:00:52 . Memory (MB): peak = 3265.180 ; gain = 130.227 ; free physical = 5141 ; free virtual = 118502default:defaulth px� 
o

Phase %s%s
101*constraints2
7 2default:default2"
Route finalize2default:defaultZ18-101h px� 
A
,Phase 7 Route finalize | Checksum: c455ce8e
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:44 ; elapsed = 00:00:52 . Memory (MB): peak = 3265.180 ; gain = 130.227 ; free physical = 5141 ; free virtual = 118502default:defaulth px� 
v

Phase %s%s
101*constraints2
8 2default:default2)
Verifying routed nets2default:defaultZ18-101h px� 
H
3Phase 8 Verifying routed nets | Checksum: c455ce8e
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:44 ; elapsed = 00:00:52 . Memory (MB): peak = 3265.180 ; gain = 130.227 ; free physical = 5140 ; free virtual = 118492default:defaulth px� 
r

Phase %s%s
101*constraints2
9 2default:default2%
Depositing Routes2default:defaultZ18-101h px� 
E
0Phase 9 Depositing Routes | Checksum: 14f99f4e7
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:46 ; elapsed = 00:00:54 . Memory (MB): peak = 3265.180 ; gain = 130.227 ; free physical = 5143 ; free virtual = 118522default:defaulth px� 
t

Phase %s%s
101*constraints2
10 2default:default2&
Post Router Timing2default:defaultZ18-101h px� 
q

Phase %s%s
101*constraints2
10.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
D
/Phase 10.1 Update Timing | Checksum: 1148fff73
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:48 ; elapsed = 00:00:55 . Memory (MB): peak = 3265.180 ; gain = 130.227 ; free physical = 5143 ; free virtual = 118522default:defaulth px� 
�
Estimated Timing Summary %s
57*route2L
8| WNS=-5.751 | TNS=-3341.281| WHS=-5.912 | THS=-27.437|
2default:defaultZ35-57h px� 
B
!Router estimated timing not met.
128*routeZ35-328h px� 
G
2Phase 10 Post Router Timing | Checksum: 1148fff73
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:48 ; elapsed = 00:00:55 . Memory (MB): peak = 3265.180 ; gain = 130.227 ; free physical = 5143 ; free virtual = 118522default:defaulth px� 
@
Router Completed Successfully
2*	routeflowZ35-16h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:48 ; elapsed = 00:00:55 . Memory (MB): peak = 3265.180 ; gain = 130.227 ; free physical = 5191 ; free virtual = 119002default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1112default:default2
122default:default2
292default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2"
route_design: 2default:default2
00:01:562default:default2
00:00:582default:default2
3265.1802default:default2
130.2272default:default2
51912default:default2
119002default:defaultZ17-722h px� 
~
4The following parameters have non-default value.
%s
395*common2&
general.maxThreads2default:defaultZ17-600h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2)
Write XDEF Complete: 2default:default2
00:00:032default:default2
00:00:012default:default2
3273.1842default:default2
0.0002default:default2
51352default:default2
118822default:defaultZ17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2x
d/home/master/Work/test_ethernet_ddr3_fifo/project_led.runs/impl_1/test_ethernet_ddr3_fido_routed.dcp2default:defaultZ17-1381h px� 
�
%s4*runtcl2�
�Executing : report_drc -file test_ethernet_ddr3_fido_drc_routed.rpt -pb test_ethernet_ddr3_fido_drc_routed.pb -rpx test_ethernet_ddr3_fido_drc_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
�report_drc -file test_ethernet_ddr3_fido_drc_routed.rpt -pb test_ethernet_ddr3_fido_drc_routed.pb -rpx test_ethernet_ddr3_fido_drc_routed.rpx2default:defaultZ4-113h px� 
>
IP Catalog is up to date.1232*coregenZ19-1839h px� 
P
Running DRC with %s threads
24*drc2
42default:defaultZ23-27h px� 
�
#The results of DRC are in file %s.
168*coretcl2�
h/home/master/Work/test_ethernet_ddr3_fifo/project_led.runs/impl_1/test_ethernet_ddr3_fido_drc_routed.rpth/home/master/Work/test_ethernet_ddr3_fifo/project_led.runs/impl_1/test_ethernet_ddr3_fido_drc_routed.rpt2default:default8Z2-168h px� 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px� 
�
%s4*runtcl2�
�Executing : report_methodology -file test_ethernet_ddr3_fido_methodology_drc_routed.rpt -pb test_ethernet_ddr3_fido_methodology_drc_routed.pb -rpx test_ethernet_ddr3_fido_methodology_drc_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
�report_methodology -file test_ethernet_ddr3_fido_methodology_drc_routed.rpt -pb test_ethernet_ddr3_fido_methodology_drc_routed.pb -rpx test_ethernet_ddr3_fido_methodology_drc_routed.rpx2default:defaultZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
Y
$Running Methodology with %s threads
74*drc2
42default:defaultZ23-133h px� 
�
2The results of Report Methodology are in file %s.
450*coretcl2�
t/home/master/Work/test_ethernet_ddr3_fifo/project_led.runs/impl_1/test_ethernet_ddr3_fido_methodology_drc_routed.rptt/home/master/Work/test_ethernet_ddr3_fifo/project_led.runs/impl_1/test_ethernet_ddr3_fido_methodology_drc_routed.rpt2default:default8Z2-1520h px� 
d
%s completed successfully
29*	vivadotcl2&
report_methodology2default:defaultZ4-42h px� 
�
%s4*runtcl2�
�Executing : report_power -file test_ethernet_ddr3_fido_power_routed.rpt -pb test_ethernet_ddr3_fido_power_summary_routed.pb -rpx test_ethernet_ddr3_fido_power_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
�report_power -file test_ethernet_ddr3_fido_power_routed.rpt -pb test_ethernet_ddr3_fido_power_summary_routed.pb -rpx test_ethernet_ddr3_fido_power_routed.rpx2default:defaultZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px� 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1242default:default2
122default:default2
292default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
report_power2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2"
report_power: 2default:default2
00:00:102default:default2
00:00:052default:default2
3289.1912default:default2
0.0002default:default2
51122default:default2
118502default:defaultZ17-722h px� 
�
%s4*runtcl2�
{Executing : report_route_status -file test_ethernet_ddr3_fido_route_status.rpt -pb test_ethernet_ddr3_fido_route_status.pb
2default:defaulth px� 
�
%s4*runtcl2�
�Executing : report_timing_summary -max_paths 10 -file test_ethernet_ddr3_fido_timing_summary_routed.rpt -pb test_ethernet_ddr3_fido_timing_summary_routed.pb -rpx test_ethernet_ddr3_fido_timing_summary_routed.rpx -warn_on_violation 
2default:defaulth px� 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
42default:defaultZ38-191h px� 
�
rThe design failed to meet the timing requirements. Please see the %s report for details on the timing violations.
188*timing2"
timing summary2default:defaultZ38-282h px� 
�
}There are set_bus_skew constraint(s) in this design. Please run report_bus_skew to ensure that bus skew requirements are met.223*timingZ38-436h px� 
�
%s4*runtcl2t
`Executing : report_incremental_reuse -file test_ethernet_ddr3_fido_incremental_reuse_routed.rpt
2default:defaulth px� 
g
BIncremental flow is disabled. No incremental reuse Info to report.423*	vivadotclZ4-1062h px� 
�
%s4*runtcl2t
`Executing : report_clock_utilization -file test_ethernet_ddr3_fido_clock_utilization_routed.rpt
2default:defaulth px� 
�
%s4*runtcl2�
�Executing : report_bus_skew -warn_on_violation -file test_ethernet_ddr3_fido_bus_skew_routed.rpt -pb test_ethernet_ddr3_fido_bus_skew_routed.pb -rpx test_ethernet_ddr3_fido_bus_skew_routed.rpx
2default:defaulth px� 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
42default:defaultZ38-191h px� 


End Record