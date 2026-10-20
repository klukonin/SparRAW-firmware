/* mac__program_qset_slots @ 0x92b110, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rs_start
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__program_qset_slots
mac__program_qset_slots:
	.global L_92b110
L_92b110:
	push_s blink
L_92b112:
	push_s r13
L_92b114:
	mov_s r0,0x8015a4
L_92b11a:
	ld_s r0,[r0,0x10]
L_92b11c:
	breq_s r0,0,L_92b16e
L_92b11e:
	mov lp_count,0x4
L_92b122:
	mov_s r13,0x0
L_92b124:
	lp L_92b150
L_92b128:
	add r1,r13,0x9
L_92b12c:
	asl_s r1,r1,0x18
L_92b12e:
	mov_s r0,0x8015a4
L_92b134:
	add2_s r0,r0,r13
L_92b136:
	ldb_s r2,[r0]
L_92b138:
	mov_s r0,0x0
L_92b13a:
	bset r0,r0,r2
L_92b13e:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_92b140:
	or_s r0,r0,r1
L_92b142:
	mov_s r32,r0
L_92b144:
	st.ab r0,[r25,0x4]
L_92b148:
	bclr r25,r25,0xa
L_92b14c:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92b14e:
	extb_s r13,r13
	.global L_92b150
L_92b150:
	ld_s r0,[gp,-0xd4]
L_92b152:
	mov_s r1,0x80146c
L_92b158:
	ld_s r1,[r1,0x8]
L_92b15a:
	and_s r0,r0,r1
L_92b15c:
	or r0,r0,0x80000aa
L_92b164:
	mov_s r32,r0
L_92b166:
	st.ab r0,[r25,0x4]
L_92b16a:
	bclr r25,r25,0xa
	.global L_92b16e
L_92b16e:
	b L_9202ac
L_92b172:
	nop_s
