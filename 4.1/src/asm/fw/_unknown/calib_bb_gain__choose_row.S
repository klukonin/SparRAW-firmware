/* calib_bb_gain__choose_row @ 0x8d1f48, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_bb_gain__pick_closest
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, is_one_of_3
 */
	.section .text.calib_bb_gain__choose_row,"ax",@progbits
	.global calib_bb_gain__choose_row
calib_bb_gain__choose_row:
	.global L_8d1f48
L_8d1f48:
	push_s blink
L_8d1f4a:
	bl L_8c02c4
L_8d1f4e:
	mov_s r14,r0
L_8d1f50:
	mov_s r13,r1
L_8d1f52:
	bl.d L_8d1f2c
L_8d1f56:
	mov_s r1,0x5
L_8d1f58:
	breq r0,0x1,L_8d1f68
L_8d1f5c:
	mov_s r0,r14
L_8d1f5e:
	bl.d L_8d1f2c
L_8d1f62:
	mov_s r1,0x0
L_8d1f64:
	brne r0,0x1,L_8d1f80
	.global L_8d1f68
L_8d1f68:
	mov_s r0,r13
L_8d1f6a:
	bl.d L_8d1f2c
L_8d1f6e:
	mov_s r1,0x5
L_8d1f70:
	brne_s r0,0,L_8d1f80
L_8d1f72:
	mov_s r0,r13
L_8d1f74:
	bl.d L_8d1f2c
L_8d1f78:
	mov_s r1,0x0
L_8d1f7a:
	cmp_s r0,0x0
L_8d1f7c:
	mov_s r0,0x2
L_8d1f7e:
	beq_s L_8d1fb2
	.global L_8d1f80
L_8d1f80:
	mov_s r0,r14
L_8d1f82:
	bl.d L_8d1f2c
L_8d1f86:
	mov_s r1,0x5
L_8d1f88:
	brne_s r0,0,L_8d1f94
L_8d1f8a:
	mov_s r0,r14
L_8d1f8c:
	bl.d L_8d1f2c
L_8d1f90:
	mov_s r1,0x0
L_8d1f92:
	breq_s r0,0,L_8d1f98
	.global L_8d1f94
L_8d1f94:
	mov_s r0,0x0
L_8d1f96:
	b_s L_8d1fb2
	.global L_8d1f98
L_8d1f98:
	mov_s r0,r13
L_8d1f9a:
	bl.d L_8d1f2c
L_8d1f9e:
	mov_s r1,0x5
L_8d1fa0:
	breq r0,0x1,L_8d1fb0
L_8d1fa4:
	mov_s r0,r13
L_8d1fa6:
	bl.d L_8d1f2c
L_8d1faa:
	mov_s r1,0x0
L_8d1fac:
	brne r0,0x1,L_8d1f94
	.global L_8d1fb0
L_8d1fb0:
	mov_s r0,0x1
	.global L_8d1fb2
L_8d1fb2:
	b L_8c0334
L_8d1fb6:
	nop_s
