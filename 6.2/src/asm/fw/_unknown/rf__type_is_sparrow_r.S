/* rf__type_is_sparrow_r @ 0x8da584, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: check_rf_boardfile, link_lost_diag__dump_rf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__type_is_sparrow_r
rf__type_is_sparrow_r:
	.global L_8da584
L_8da584:
	mov_s r0,0x880a7c
L_8da58a:
	ldw_s r0,[r0,0x12]
L_8da58c:
	cmp_s r0,0x2
L_8da58e:
	mov_s r0,0x1
L_8da590:
	j_s.d [blink]
L_8da592:
	sub_s.ne r0,r0,r0
