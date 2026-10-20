/* rfca__access_sector_other_rf @ 0x92e0a8, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_init__flow, brp_responder_flow_enter
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, rfca__get_rf_mask_uc, rfca__select_rf_uc, sector_mem__addr_of
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rfca__access_sector_other_rf
rfca__access_sector_other_rf:
	.global L_92e0a8
L_92e0a8:
	push_s blink
L_92e0aa:
	bl L_920230
L_92e0ae:
	mov_s r15,r0
L_92e0b0:
	mov_s r14,0x8006b4
L_92e0b6:
	ldw_s r0,[r14]
L_92e0b8:
	brlt r0,0x2,L_92e0e0
L_92e0bc:
	ldb_s r0,[r14,0x4]
L_92e0be:
	brne_s r0,0,L_92e0e0
L_92e0c0:
	bl L_928c68
L_92e0c4:
	ldb_s r1,[r14,0x3]
L_92e0c6:
	mov_s r13,r0
L_92e0c8:
	bic_s r0,r0,r1
L_92e0ca:
	extb_s r0,r0
L_92e0cc:
	bl.d L_928b8c
L_92e0d0:
	mov_s r1,0x0
L_92e0d2:
	bl.d L_922e14
L_92e0d6:
	mov_s r0,r15
L_92e0d8:
	mov_s r0,r13
L_92e0da:
	bl.d L_928b8c
L_92e0de:
	mov_s r1,0x0
	.global L_92e0e0
L_92e0e0:
	b L_92029c
