/* conn_mgr__print_link_maintain_cfg @ 0x8dcea4, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::print_link_maintain_cfg(): | link_loss_enable_detectors_vec %x | bad_beacons_num_threshold %d | bad_beacons_snr_threshold_db %d
 *   [NNL] | check_link_loss_period_usec %d | tx_ageing_threshold_usec %d | keep_alive_period_usec_high_snr %d
 *   [NNL] | keep_alive_period_usec_low_snr %d | keep_alive_snr_threshold_low_db %d | keep_alive_snr_threshold_high_db %d
 * Зовут его: conn_mgr__set_link_maintain_cfg
 * Зовёт сам: __ld_r13_ret, fw_log__emit3
 */
	.section .text.conn_mgr__print_link_maintain_cfg,"ax",@progbits
	.global conn_mgr__print_link_maintain_cfg
conn_mgr__print_link_maintain_cfg:
	.global L_8dcea4
L_8dcea4:
	push_s blink
L_8dcea6:
	push_s r13
L_8dcea8:
	mov_s r13,r0
L_8dceaa:
	ld r4,[r0, 0x1c]
L_8dceae:
	mov_s r2,0x100ac1c
L_8dceb4:
	ld r5,[r0, 0x20]
L_8dceb8:
	mov_s r0,0xb
L_8dceba:
	mov_s r1,0x2
L_8dcebc:
	bl.d L_8ee034
L_8dcec0:
	ld_s r3,[r13]
L_8dcec2:
	mov_s r2,0x100aca8
L_8dcec8:
	ld r4,[r13, 0x8]
L_8dcecc:
	mov_s r0,0xb
L_8dcece:
	ld r5,[r13, 0xc]
L_8dced2:
	mov_s r1,0x2
L_8dced4:
	bl.d L_8ee034
L_8dced8:
	ld_s r3,[r13,0x4]
L_8dceda:
	mov_s r2,0x100ad14
L_8dcee0:
	ld r4,[r13, 0x14]
L_8dcee4:
	mov_s r0,0xb
L_8dcee6:
	ld r5,[r13, 0x18]
L_8dceea:
	mov_s r1,0x2
L_8dceec:
	bl.d L_8ee034
L_8dcef0:
	ld_s r3,[r13,0x10]
L_8dcef2:
	b L_8c033c
L_8dcef6:
	nop_s
