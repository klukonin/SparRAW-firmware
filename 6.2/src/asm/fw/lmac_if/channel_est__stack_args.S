/* channel_est__stack_args @ 0x8dbe54, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: channel_estimation_cmd_start, fw_sysapi_mgr__phy_rx_statistics_cmd_start, fw_sysapi_mgr__start_energy_statistics, fw_sysapi_mgr__start_plcp_header, get_rx_pkt_phy_data_cmd_start
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channel_est__stack_args
channel_est__stack_args:
	.global L_8dbe54
L_8dbe54:
	sub_s sp,sp,0x8
L_8dbe56:
	push_s blink
L_8dbe58:
	bl L_8c01e0
L_8dbe5c:
	st_s r1,[sp,0x10]
L_8dbe5e:
	st_s r2,[sp,0x14]
L_8dbe60:
	mov_s r15,r0
L_8dbe62:
	bl.d L_8c3284
L_8dbe66:
	mov_s r14,r3
L_8dbe68:
	mov_s r13,r0
L_8dbe6a:
	add_s r1,sp,0x10
L_8dbe6c:
	bl.d L_8c0380
L_8dbe70:
	mov_s r2,0x5
L_8dbe72:
	st_s r14,[r13,0x8]
L_8dbe74:
	extw_s r1,r15
L_8dbe76:
	mov_s r0,r13
L_8dbe78:
	mov_s r2,0xc
L_8dbe7a:
	bl.d L_8e5204
L_8dbe7e:
	mov_s r3,0x0
L_8dbe80:
	mov_s r12,0xc
L_8dbe82:
	b L_8c024e
L_8dbe86:
	nop_s
