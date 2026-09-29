/* vring__program_macq_and_ba @ 0x8e5620, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac_indirect__write_entry, vring__write_macq_desc
 */
	.section .text.vring__program_macq_and_ba,"ax",@progbits
	.global vring__program_macq_and_ba
vring__program_macq_and_ba:
	.global L_8e5620
L_8e5620:
	push_s blink
L_8e5622:
	bl.d L_8c02bc
L_8e5626:
	mov_s r3,0x0
L_8e5628:
	sub_s sp,sp,0x10
L_8e562a:
	mov_s r14,r0
L_8e562c:
	mov_s r13,r1
L_8e562e:
	mov_s r16,r2
L_8e5630:
	mov_s r15,sp
L_8e5632:
	mov_s r0,r15
L_8e5634:
	ldb_s r1,[r14]
L_8e5636:
	mov_s r2,0x2
L_8e5638:
	bl.d L_8c4768
L_8e563c:
	mov r4,0x1
L_8e5640:
	stw r13,[sp]
L_8e5644:
	stw r13,[sp, 0x2]
L_8e5648:
	stw r13,[sp, 0x6]
L_8e564c:
	stw r16,[sp, 0x4]
L_8e5650:
	mov_s r0,r15
L_8e5652:
	ldb_s r1,[r14]
L_8e5654:
	mov_s r2,0x2
L_8e5656:
	mov_s r3,0x0
L_8e5658:
	mov_s r4,r3
L_8e565a:
	mov_s r5,r3
L_8e565c:
	mov_s r6,r3
L_8e565e:
	bl.d L_8c46a4
L_8e5662:
	mov r7,0x1
L_8e5666:
	b.d L_8c0324
L_8e566a:
	add_s sp,sp,0x10
