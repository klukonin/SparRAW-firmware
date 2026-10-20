/* rm_ch_switch_sm__action_8e3ac8 @ 0x8e3ac8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, rm_ch_switch_sm__check_turn_completed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_ch_switch_sm__action_8e3ac8
rm_ch_switch_sm__action_8e3ac8:
	.global L_8e3ac8
L_8e3ac8:
	push_s blink
L_8e3aca:
	push_s r13
L_8e3acc:
	mov_s r13,r0
L_8e3ace:
	ld_s r0,[r0,0x10]
L_8e3ad0:
	bbit0 r0,0x4,L_8e3ae6
	.global L_8e3ad4
L_8e3ad4:
	ld_s r0,[r13,0x14]
L_8e3ad6:
	bset_s r0,r0,0x4
L_8e3ad8:
	st_s r0,[r13,0x14]
L_8e3ada:
	mov_s r0,r13
L_8e3adc:
	bl.d L_8c6484
L_8e3ae0:
	mov_s r1,0x1
L_8e3ae2:
	b L_8c025c
	.global L_8e3ae6
L_8e3ae6:
	mov_s r0,blink
L_8e3ae8:
	mov_s r1,0x116f
L_8e3aee:
	bl L_8c9b28
L_8e3af2:
	b_s L_8e3ad4
