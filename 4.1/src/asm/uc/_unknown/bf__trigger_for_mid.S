/* bf__trigger_for_mid @ 0x92b63c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__trigger_if_pending
 * Зовёт сам: __ld_r13_ret_uc, bf_sm__trigger, mid_vring_mask_update
 * Глобалы (через gp): 0x8005ec
 */
	.section .text.bf__trigger_for_mid,"ax",@progbits
	.global bf__trigger_for_mid
bf__trigger_for_mid:
	.global L_92b63c
L_92b63c:
	push_s blink
L_92b63e:
	push_s r13
L_92b640:
	sub_s sp,sp,0xc
L_92b642:
	mov_s r13,r0
L_92b644:
	mov_s r0,0x3
L_92b646:
	bl.d L_928cb4
L_92b64a:
	mov_s r1,r13
L_92b64c:
	ld_s r0,[gp,0xc4]
L_92b64e:
	breq r0,0x1,L_92b662
L_92b652:
	mov_s r0,0x1
L_92b654:
	st_s r0,[sp,0x0]
L_92b656:
	mov_s r1,0x0
L_92b658:
	st_s r1,[sp,0x4]
L_92b65a:
	st_s r13,[sp,0x8]
L_92b65c:
	bl.d L_9222cc
L_92b660:
	mov_s r0,sp
	.global L_92b662
L_92b662:
	b.d L_92028c
L_92b666:
	add_s sp,sp,0xc
