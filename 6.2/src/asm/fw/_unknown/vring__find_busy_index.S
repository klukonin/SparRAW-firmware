/* vring__find_busy_index @ 0x8ccfe4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__cancel_timer, pring__find_by_id
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__find_busy_index
vring__find_busy_index:
	.global L_8ccfe4
L_8ccfe4:
	mov_s r3,0x0
L_8ccfe6:
	b_s L_8ccfec
	.global L_8ccfe8
L_8ccfe8:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8ccfea:
	extb_s r3,r3
	.global L_8ccfec
L_8ccfec:
	brhs r3,0x9,L_8cd006
L_8ccff0:
	asl_s r1,r3,0x3
L_8ccff2:
	add2_s r1,r1,r1
L_8ccff4:
	add_s r1,r1,0x804c40
L_8ccffa:
	ld_s r2,[r1,0x24]
L_8ccffc:
	breq_s r2,0,L_8ccfe8
L_8ccffe:
	ldb_s r2,[r1,0xa]
L_8cd000:
	brne r0,r2,L_8ccfe8
L_8cd004:
	b_s L_8cd008
	.global L_8cd006
L_8cd006:
	mov_s r1,0x0
	.global L_8cd008
L_8cd008:
	j_s.d [blink]
L_8cd00a:
	mov_s r0,r1
