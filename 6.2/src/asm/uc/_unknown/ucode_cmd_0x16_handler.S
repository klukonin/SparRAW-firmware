/* ucode_cmd_0x16_handler @ 0x9357dc, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: memcpy_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x16_handler
ucode_cmd_0x16_handler:
	.global L_9357dc
L_9357dc:
	mov_s r1,r0
L_9357de:
	mov_s r0,gp
L_9357e0:
	/* add r0,r0,0x24 */
	.byte 0x80,0x20,0x00,0x09
L_9357e4:
	b.d L_920330
L_9357e8:
	mov_s r2,0x4
L_9357ea:
	nop_s
