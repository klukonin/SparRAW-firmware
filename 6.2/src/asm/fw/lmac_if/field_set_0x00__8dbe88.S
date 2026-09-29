/* field_set_0x00__8dbe88 @ 0x8dbe88, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: channel_estimation_cmd_start, fw_sysapi_mgr__phy_rx_statistics_cmd_start, fw_sysapi_mgr__start_energy_statistics, fw_sysapi_mgr__start_plcp_header, get_rx_pkt_phy_data_cmd_start
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_set_0x00__8dbe88
field_set_0x00__8dbe88:
	.global L_8dbe88
L_8dbe88:
	push_s blink
L_8dbe8a:
	bl L_8c01e4
L_8dbe8e:
	mov_s r13,r0
L_8dbe90:
	bl.d L_8c3284
L_8dbe94:
	mov_s r14,r1
L_8dbe96:
	st_s r14,[r0]
L_8dbe98:
	extw_s r1,r13
L_8dbe9a:
	mov_s r2,0x4
L_8dbe9c:
	bl.d L_8e5204
L_8dbea0:
	mov_s r3,0x0
L_8dbea2:
	b L_8c0254
L_8dbea6:
	nop_s
