/* rm_chan_sw_sm__on_ucode_rx_on_evt @ 0x8def0c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_ch_switch_sm.cpp
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, rm_ch_switch_sm__check_turn_completed
 */
	.section .text.rm_chan_sw_sm__on_ucode_rx_on_evt,"ax",@progbits
	.global rm_chan_sw_sm__on_ucode_rx_on_evt
rm_chan_sw_sm__on_ucode_rx_on_evt:
L_8def0c:
	push_s blink
L_8def0e:
	push_s r13
L_8def10:
	mov_s r13,r0
L_8def12:
	ld_s r0,[r0,0x34]
L_8def14:
	bbit0 r0,0x4,L_8def2a
	.global L_8def18
L_8def18:
	ld_s r0,[r13,0x38]
L_8def1a:
	bset_s r0,r0,0x4
L_8def1c:
	st_s r0,[r13,0x38]
L_8def1e:
	mov_s r0,r13
L_8def20:
	bl.d L_8c57b0
L_8def24:
	mov_s r1,0x1
L_8def26:
	b L_8c033c
	.global L_8def2a
L_8def2a:
	mov_s r0,blink
L_8def2c:
	mov_s r2,0x1016114
L_8def32:
	mov_s r1,0x116f
L_8def38:
	bl.d L_8c82c0
L_8def3c:
	mov r3,0x116
L_8def40:
	b_s L_8def18
L_8def42:
	nop_s
