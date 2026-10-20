/* conn_mgr__print_link_maintain_cfg @ 0x8e105c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::print_link_maintain_cfg(): | link_loss_enable_detectors_vec %x | bad_beacons_num_threshold %d | bad_beacons_snr_threshold_db %d
 *   [NNL] | check_link_loss_period_usec %d | tx_ageing_threshold_usec %d | keep_alive_period_usec_high_snr %d
 *   [NNL] | keep_alive_period_usec_low_snr %d | keep_alive_snr_threshold_low_db %d | keep_alive_snr_threshold_high_db %d
 * Зовут его: conn_mgr__set_link_maintain_cfg
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__print_link_maintain_cfg
conn_mgr__print_link_maintain_cfg:
	.global L_8e105c
L_8e105c:
	push_s blink
L_8e105e:
	push_s r13
L_8e1060:
	mov_s r13,r0
L_8e1062:
	ld r4,[r0, 0x20]
L_8e1066:
	mov_s r1,0x100c07c
L_8e106c:
	ld_s r2,[r13]
L_8e106e:
	mov_s r0,0x2b
L_8e1070:
	bl.d L_8dcd00
L_8e1074:
	ld_s r3,[r13,0x1c]
L_8e1076:
	mov_s r1,0x100c108
L_8e107c:
	ld r4,[r13, 0xc]
L_8e1080:
	mov_s r0,0x2b
L_8e1082:
	ld_s r2,[r13,0x4]
L_8e1084:
	bl.d L_8dcd00
L_8e1088:
	ld_s r3,[r13,0x8]
L_8e108a:
	mov_s r1,0x100c174
L_8e1090:
	ld r4,[r13, 0x18]
L_8e1094:
	mov_s r0,0x2b
L_8e1096:
	ld_s r2,[r13,0x10]
L_8e1098:
	bl.d L_8dcd00
L_8e109c:
	ld_s r3,[r13,0x14]
L_8e109e:
	b L_8c025c
L_8e10a2:
	nop_s
