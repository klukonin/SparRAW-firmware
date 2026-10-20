/* rm_ch_switch_sm__turn_step @ 0x8c6d30, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_ch_switch_sm.cpp
 * Зовут его: rm_ch_switch_sm__bump_turn
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, rm_ch_switch_sm__check_turn_completed
 */
	.section .text.rm_ch_switch_sm__turn_step,"ax",@progbits
	.global rm_ch_switch_sm__turn_step
rm_ch_switch_sm__turn_step:
	.global L_8c6d30
L_8c6d30:
	j_s [blink]
	.global sub_8c6d32
sub_8c6d32:
L_8c6d32:
	nop_s
L_8c6d34:
	push_s blink
L_8c6d36:
	push_s r13
L_8c6d38:
	mov_s r13,r0
L_8c6d3a:
	ld_s r0,[r0,0x34]
L_8c6d3c:
	bbit0 r0,0x1,L_8c6d52
	.global L_8c6d40
L_8c6d40:
	ld_s r0,[r13,0x38]
L_8c6d42:
	bset_s r0,r0,0x1
L_8c6d44:
	st_s r0,[r13,0x38]
L_8c6d46:
	mov_s r0,r13
L_8c6d48:
	bl.d L_8c57b0
L_8c6d4c:
	mov_s r1,0x0
L_8c6d4e:
	b L_8c033c
	.global L_8c6d52
L_8c6d52:
	mov_s r0,blink
L_8c6d54:
	mov_s r2,0x1016114
L_8c6d5a:
	mov_s r1,0x116d
L_8c6d60:
	bl.d L_8c82c0
L_8c6d64:
	mov_s r3,0xa7
L_8c6d66:
	b_s L_8c6d40
