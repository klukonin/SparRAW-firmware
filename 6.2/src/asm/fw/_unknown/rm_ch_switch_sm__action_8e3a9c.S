/* rm_ch_switch_sm__action_8e3a9c @ 0x8e3a9c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, rm_ch_switch_sm__check_turn_completed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_ch_switch_sm__action_8e3a9c
rm_ch_switch_sm__action_8e3a9c:
	.global L_8e3a9c
L_8e3a9c:
	push_s blink
L_8e3a9e:
	push_s r13
L_8e3aa0:
	mov_s r13,r0
L_8e3aa2:
	ld_s r0,[r0,0x10]
L_8e3aa4:
	bbit0 r0,0x2,L_8e3aba
	.global L_8e3aa8
L_8e3aa8:
	ld_s r0,[r13,0x14]
L_8e3aaa:
	bset_s r0,r0,0x2
L_8e3aac:
	st_s r0,[r13,0x14]
L_8e3aae:
	mov_s r0,r13
L_8e3ab0:
	bl.d L_8c6484
L_8e3ab4:
	mov_s r1,0x0
L_8e3ab6:
	b L_8c025c
	.global L_8e3aba
L_8e3aba:
	mov_s r0,blink
L_8e3abc:
	mov_s r1,0x116e
L_8e3ac2:
	bl L_8c9b28
L_8e3ac6:
	b_s L_8e3aa8
