/* brp__sum_sector_counts @ 0x921bb0, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__flow_main
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc
 */
	.section .text.brp__sum_sector_counts,"ax",@progbits
	.global brp__sum_sector_counts
brp__sum_sector_counts:
	.global L_921bb0
L_921bb0:
	push_s blink
L_921bb2:
	bl.d L_920210
L_921bb6:
	mov_s r1,0x0
L_921bb8:
	mov_s r3,0x800a50
L_921bbe:
	add r13,r3,0xc
L_921bc2:
	stw_s r1,[r3,0x8]
L_921bc4:
	mov_s r14,r1
L_921bc6:
	b_s L_921bda
	.global L_921bc8
L_921bc8:
	mov_s r2,0x801050
L_921bce:
	add1_s r2,r2,r14
L_921bd0:
	ldb_s r2,[r2]
L_921bd2:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_921bd4:
	add_s r1,r1,r2
L_921bd6:
	extw_s r1,r1
L_921bd8:
	stw_s r1,[r3,0x8]
	.global L_921bda
L_921bda:
	mov_s r2,0x800734
L_921be0:
	ld_s r2,[r2]
L_921be2:
	lsr_s r2,r2,0xf
L_921be4:
	bmsk_s r2,r2,0x5
L_921be6:
	brlo r14,r2,L_921bc8
L_921bea:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_921bec:
	/* asr_s r1,r1,0x3 */
	.byte 0x43,0xb9
L_921bee:
	extb_s r1,r1
L_921bf0:
	min r1,r1,0x2f
L_921bf4:
	ldb_s r2,[r3,0x1]
L_921bf6:
	extb_s r1,r1
L_921bf8:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_921bfa:
	asr_s r2,r2
L_921bfc:
	min r2,r2,0x2f
L_921c00:
	mov_s r15,0x800a78
L_921c06:
	ldb_s r14,[r15,r1]
L_921c08:
	extb_s r2,r2
L_921c0a:
	ldb_s r1,[r15,r2]
L_921c0c:
	mov_s r2,0x8016b4
L_921c12:
	ldb_s r15,[r3]
L_921c14:
	ld_s r2,[r2]
L_921c16:
	add1_s r13,r13,r0
L_921c18:
	sub_s r15,r15,r2
L_921c1a:
	ldw_s.x r2,[r3,0xa]
L_921c1c:
	sub2 r2,r2,r15
L_921c20:
	sub_s r2,r2,r14
L_921c22:
	add_s r1,r1,r2
L_921c24:
	b.d L_92027c
L_921c28:
	stw_s r1,[r13]
L_921c2a:
	nop_s
