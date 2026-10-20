/* sniffer__init_pool @ 0x8d5a8c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sniffer_mode_step
 * Зовёт сам: mem_pool__init
 */
	.section .text.sniffer__init_pool,"ax",@progbits
	.global sniffer__init_pool
sniffer__init_pool:
	.global L_8d5a8c
L_8d5a8c:
	mov_s r1,0x0
L_8d5a8e:
	mov_s r0,0x804600
L_8d5a94:
	st_s r1,[r0,0x18]
L_8d5a96:
	mov_s r1,0x804404
L_8d5a9c:
	mov_s r0,0x80456c
L_8d5aa2:
	mov_s r2,0x28
L_8d5aa4:
	b.d L_8c6c70
L_8d5aa8:
	mov_s r3,0x9
L_8d5aaa:
	nop_s
