/* conn__threshold_to_offset @ 0x8c7528, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__update_bf_id_on_rs_done, connection__on_bf_result
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__threshold_to_offset
conn__threshold_to_offset:
	.global L_8c7528
L_8c7528:
	mov_s r0,0x0
L_8c752a:
	b_s L_8c7530
	.global L_8c752c
L_8c752c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c752e:
	extb_s r0,r0
	.global L_8c7530
L_8c7530:
	brhs r0,0x4,L_8c753c
L_8c7534:
	ld.as r3,[r1,r0]
L_8c7538:
	brge r2,r3,L_8c752c
	.global L_8c753c
L_8c753c:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8c753e:
	add2_s r0,r0,r0
L_8c7540:
	add_s r0,r0,0x14
L_8c7542:
	j_s.d [blink]
L_8c7544:
	extb_s r0,r0
L_8c7546:
	nop_s
