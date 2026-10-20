/* conn__threshold_to_offset @ 0x8c653c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: connection__on_bf_result, connection__update_rs_metric
 */
	.section .text.conn__threshold_to_offset,"ax",@progbits
	.global conn__threshold_to_offset
conn__threshold_to_offset:
	.global L_8c653c
L_8c653c:
	mov_s r0,0x0
L_8c653e:
	b_s L_8c6544
	.global L_8c6540
L_8c6540:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c6542:
	extb_s r0,r0
	.global L_8c6544
L_8c6544:
	brhs r0,0x4,L_8c6550
L_8c6548:
	ld.as r3,[r1,r0]
L_8c654c:
	brge r2,r3,L_8c6540
	.global L_8c6550
L_8c6550:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8c6552:
	add2_s r0,r0,r0
L_8c6554:
	add_s r0,r0,0x14
L_8c6556:
	j_s.d [blink]
L_8c6558:
	extb_s r0,r0
L_8c655a:
	nop_s
