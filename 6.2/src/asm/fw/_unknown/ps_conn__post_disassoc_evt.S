/* ps_conn__post_disassoc_evt @ 0x8c6994, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CONNECTION__disassoc_ntf
 * Зовёт сам: basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_conn__post_disassoc_evt
ps_conn__post_disassoc_evt:
	.global L_8c6994
L_8c6994:
	ld_s r1,[r0,0x4c]
L_8c6996:
	cmp_s r1,0x0
L_8c6998:
	mov_s r1,0x5
L_8c699a:
	add.eq r0,r0,0x20
L_8c699e:
	mov.eq r1,0x6
L_8c69a2:
	mov_s r2,0x0
L_8c69a4:
	mov_s r3,r2
L_8c69a6:
	b.d L_8d9b6c
L_8c69aa:
	mov_s r4,r2
