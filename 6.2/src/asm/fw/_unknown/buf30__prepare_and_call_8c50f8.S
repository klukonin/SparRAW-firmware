/* buf30__prepare_and_call_8c50f8 @ 0x8dd8ec, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__prepare_buf30_by_id
 * Зовёт сам: macq_desc__read
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global buf30__prepare_and_call_8c50f8
buf30__prepare_and_call_8c50f8:
	.global L_8dd8ec
L_8dd8ec:
	push_s blink
L_8dd8ee:
	sub_s sp,sp,0x30
L_8dd8f0:
	mov_s r1,r0
L_8dd8f2:
	mov_s r0,sp
L_8dd8f4:
	mov_s r2,0x2
L_8dd8f6:
	mov_s r3,0x3
L_8dd8f8:
	bl.d L_8c50f8
L_8dd8fc:
	mov r4,0x1
L_8dd900:
	ld_s r0,[sp,0x4]
L_8dd902:
	bmsk_s r0,r0,0xb
L_8dd904:
	add_s sp,sp,0x30
L_8dd906:
	pop_s blink
L_8dd908:
	j_s [blink]
L_8dd90a:
	nop_s
