/* channel_est__clamp_64 @ 0x8f9070, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: channel_estimation_cmd_start, fw_sysapi_mgr__mac_ampdu_statistics_cmd_start, fw_sysapi_mgr__phy_rx_statistics_cmd_start, fw_sysapi_mgr__start_energy_statistics, fw_sysapi_mgr__start_plcp_header, get_rx_pkt_phy_data_cmd_start
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, u_schd__cancel, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channel_est__clamp_64
channel_est__clamp_64:
	.global L_8f9070
L_8f9070:
	push_s blink
L_8f9072:
	bl L_8c01e0
L_8f9076:
	mov_s r14,r0
L_8f9078:
	mov_s r0,0x64
L_8f907a:
	cmp_s r1,0x64
L_8f907c:
	mov.hi r0,r1
L_8f9080:
	st_s r0,[r14,0xc]
L_8f9082:
	ld_s r0,[r14,0x10]
L_8f9084:
	mov_s r15,r2
L_8f9086:
	mov_s r13,0x0
L_8f9088:
	breq_s r0,0,L_8f9090
L_8f908a:
	bl L_8c8de0
L_8f908e:
	st_s r13,[r14,0x10]
	.global L_8f9090
L_8f9090:
	ld r4,[r14, 0xc]
L_8f9094:
	mov_s r0,r15
L_8f9096:
	mov_s r1,r14
L_8f9098:
	mov_s r2,0x0
L_8f909a:
	mov_s r3,0x1
L_8f909c:
	mov_s r5,r2
L_8f909e:
	bl.d L_8e0c0c
L_8f90a2:
	mov_s r6,r2
L_8f90a4:
	b.d L_8c024c
L_8f90a8:
	st_s r0,[r14,0x10]
L_8f90aa:
	nop_s
