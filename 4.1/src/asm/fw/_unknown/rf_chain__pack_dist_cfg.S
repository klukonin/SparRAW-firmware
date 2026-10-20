/* rf_chain__pack_dist_cfg @ 0x8c4818, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_chain__zero_and_program
 * Зовёт сам: __ld_r13_ret, bf_w_s0_w2, bf_w_s4_w3
 */
	.section .text.rf_chain__pack_dist_cfg,"ax",@progbits
	.global rf_chain__pack_dist_cfg
rf_chain__pack_dist_cfg:
	.global L_8c4818
L_8c4818:
	push_s blink
L_8c481a:
	push_s r13
L_8c481c:
	sub_s sp,sp,0x8
L_8c481e:
	mov_s r3,r0
L_8c4820:
	mov_s r13,r1
L_8c4822:
	mov_s r2,0x0
L_8c4824:
	add_s r0,sp,0x4
L_8c4826:
	mov_s r1,r2
L_8c4828:
	bl.d L_8e8330
L_8c482c:
	mov lp_count,0x4
L_8c4830:
	mov_s r1,0x6
L_8c4832:
	bl L_8e84ec
L_8c4836:
	ldw r0,[sp, 0x4]
L_8c483a:
	mov_s r1,0x886600
L_8c4840:
	asl_s r0,r0,0x10
L_8c4842:
	bset_s r0,r0,0x1f
L_8c4844:
	st_s r0,[r1,0xc]
L_8c4846:
	st_s r13,[r1,0x10]
L_8c4848:
	lp L_8c485c
L_8c484c:
	mov_s r13,0x886614
L_8c4852:
	ld.ab r0,[r3,0x4]
L_8c4856:
	add2_s r13,r13,r2
L_8c4858:
	st_s r0,[r13]
L_8c485a:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_8c485c
L_8c485c:
	st 0x40000000,[r1, 0x8]
L_8c4864:
	sync
	.global L_8c4868
L_8c4868:
	mov_s r0,0x886600
L_8c486e:
	ld_s r0,[r0,0x8]
L_8c4870:
	bbit1 r0,0x1d,L_8c4868
L_8c4874:
	b.d L_8c033c
L_8c4878:
	add_s sp,sp,0x8
L_8c487a:
	nop_s
