/* switch_2_secondary @ 0x8e83d4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_sm__action_8e9ac0, rm_sm__action_8e9ad4
 * Зовёт сам: __ld_r13_to_r13_ret, memcpy_fw, rm_main_sm__kick_channel_switch_sm
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global switch_2_secondary
switch_2_secondary:
	.global L_8e83d4
L_8e83d4:
	push_s blink
L_8e83d6:
	push_s r13
L_8e83d8:
	mov_s r13,r0
L_8e83da:
	add_s r0,r0,0x54
L_8e83dc:
	add r1,r13,0x2c
L_8e83e0:
	bl.d L_8c0380
L_8e83e4:
	mov_s r2,0x28
L_8e83e6:
	bl.d L_8da6e4
L_8e83ea:
	mov_s r0,r13
L_8e83ec:
	mov_s r0,0x0
L_8e83ee:
	b.d L_8c025c
L_8e83f2:
	st_s r0,[r13,0x40]
