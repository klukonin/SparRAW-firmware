/* vring_tbl__ptr_by_index @ 0x8cce84, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba__schedule_timeout_update
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_tbl__ptr_by_index
vring_tbl__ptr_by_index:
	.global L_8cce84
L_8cce84:
	mov_s r1,0x847f34
L_8cce8a:
	sub r1,r1,0x400
L_8cce8e:
	add2_s r1,r1,r0
L_8cce90:
	ld r0,[r1,0x44c]
L_8cce98:
	j_s [blink]
L_8cce9a:
	nop_s
