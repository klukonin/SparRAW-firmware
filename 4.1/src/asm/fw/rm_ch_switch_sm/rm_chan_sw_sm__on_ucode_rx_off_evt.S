/* rm_chan_sw_sm__on_ucode_rx_off_evt @ 0x8deed8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_ch_switch_sm.cpp
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, rm_ch_switch_sm__check_turn_completed
 */
	.section .text.rm_chan_sw_sm__on_ucode_rx_off_evt,"ax",@progbits
	.global rm_chan_sw_sm__on_ucode_rx_off_evt
rm_chan_sw_sm__on_ucode_rx_off_evt:
L_8deed8:
	push_s blink
L_8deeda:
	push_s r13
L_8deedc:
	mov_s r13,r0
L_8deede:
	ld_s r0,[r0,0x34]
L_8deee0:
	bbit0 r0,0x2,L_8deef6
	.global L_8deee4
L_8deee4:
	ld_s r0,[r13,0x38]
L_8deee6:
	bset_s r0,r0,0x2
L_8deee8:
	st_s r0,[r13,0x38]
L_8deeea:
	mov_s r0,r13
L_8deeec:
	bl.d L_8c57b0
L_8deef0:
	mov_s r1,0x0
L_8deef2:
	b L_8c033c
	.global L_8deef6
L_8deef6:
	mov_s r0,blink
L_8deef8:
	mov_s r2,0x1016114
L_8deefe:
	mov_s r1,0x116e
L_8def04:
	bl.d L_8c82c0
L_8def08:
	mov_s r3,0xb0
L_8def0a:
	b_s L_8deee4
