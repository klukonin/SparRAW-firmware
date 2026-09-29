/* field_set_0x1c__8d9c3c @ 0x8d9c3c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: maintain_sm__action_8f2f0c
 * Зовёт сам: basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_set_0x1c__8d9c3c
field_set_0x1c__8d9c3c:
	.global L_8d9c3c
L_8d9c3c:
	mov_s r2,0x0
L_8d9c3e:
	st_s r2,[r0,0x1c]
L_8d9c40:
	mov_s r1,0x4
L_8d9c42:
	mov_s r3,r2
L_8d9c44:
	b.d L_8d9b6c
L_8d9c48:
	mov_s r4,r2
L_8d9c4a:
	nop_s
