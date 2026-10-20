/* mlme_sm__check_assoc_capacity @ 0x8c44ec, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm__assoc_req_handle
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bss_join_verify, mid_list__count_free
 */
	.section .text.mlme_sm__check_assoc_capacity,"ax",@progbits
	.global mlme_sm__check_assoc_capacity
mlme_sm__check_assoc_capacity:
	.global L_8c44ec
L_8c44ec:
	push_s blink
L_8c44ee:
	bl L_8c02bc
L_8c44f2:
	mov_s r13,r0
L_8c44f4:
	mov_s r16,r1
L_8c44f6:
	mov_s r15,r2
L_8c44f8:
	bl.d L_8ca464
L_8c44fc:
	mov_s r14,r3
L_8c44fe:
	ldb_s r1,[r13,0x11]
L_8c4500:
	brlo r0,r1,L_8c450c
L_8c4504:
	mov_s r0,0x5
L_8c4506:
	st_s r0,[r14]
L_8c4508:
	mov_s r0,0x0
L_8c450a:
	b_s L_8c451c
	.global L_8c450c
L_8c450c:
	add3 r0,r13,0x9
L_8c4510:
	mov_s r1,r16
L_8c4512:
	mov_s r2,r15
L_8c4514:
	mov_s r3,r13
L_8c4516:
	bl.d L_8c4520
L_8c451a:
	mov_s r4,r14
	.global L_8c451c
L_8c451c:
	b L_8c0324
