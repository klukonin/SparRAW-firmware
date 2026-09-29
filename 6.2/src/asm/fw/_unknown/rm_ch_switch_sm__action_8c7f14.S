/* rm_ch_switch_sm__action_8c7f14 @ 0x8c7f14, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, rm_ch_switch_sm__check_turn_completed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_ch_switch_sm__action_8c7f14
rm_ch_switch_sm__action_8c7f14:
	.global L_8c7f14
L_8c7f14:
	push_s blink
L_8c7f16:
	push_s r13
L_8c7f18:
	mov_s r13,r0
L_8c7f1a:
	ld_s r0,[r0,0x10]
L_8c7f1c:
	bbit0 r0,0x1,L_8c7f32
	.global L_8c7f20
L_8c7f20:
	ld_s r0,[r13,0x14]
L_8c7f22:
	bset_s r0,r0,0x1
L_8c7f24:
	st_s r0,[r13,0x14]
L_8c7f26:
	mov_s r0,r13
L_8c7f28:
	bl.d L_8c6484
L_8c7f2c:
	mov_s r1,0x0
L_8c7f2e:
	b L_8c025c
	.global L_8c7f32
L_8c7f32:
	mov_s r0,blink
L_8c7f34:
	mov_s r1,0x116d
L_8c7f3a:
	bl L_8c9b28
L_8c7f3e:
	b_s L_8c7f20
