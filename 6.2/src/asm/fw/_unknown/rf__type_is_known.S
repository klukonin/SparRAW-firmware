/* rf__type_is_known @ 0x8da5c4, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__identify_type, rf__is_present
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__type_is_known
rf__type_is_known:
	.global L_8da5c4
L_8da5c4:
	mov_s r0,0x880a7c
L_8da5ca:
	ldw_s r0,[r0,0x12]
L_8da5cc:
	sub.f r0,r0,0x0
L_8da5d0:
	j_s.d [blink]
L_8da5d2:
	mov.ne r0,0x1
L_8da5d6:
	nop_s
