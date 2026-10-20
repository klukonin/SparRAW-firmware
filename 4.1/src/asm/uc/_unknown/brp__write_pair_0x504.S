/* brp__write_pair_0x504 @ 0x930d6c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bf_w_s2_w4_uc, brp__write_reg_pair
 */
	.section .text.brp__write_pair_0x504,"ax",@progbits
	.global brp__write_pair_0x504
brp__write_pair_0x504:
L_930d6c:
	push_s blink
L_930d6e:
	bl L_920214
L_930d72:
	mov_s r3,0x801660
L_930d78:
	ld_s r2,[r3,0x60]
L_930d7a:
	mov_s r13,0xf
L_930d7c:
	add_s r0,r0,r2
L_930d7e:
	cmp_s r0,0x1
L_930d80:
	mov.ls r0,0x1
L_930d84:
	cmp_s r0,0xf
L_930d86:
	mov.cs r13,r0
L_930d8a:
	ld_s r0,[r3,0x5c]
L_930d8c:
	extb_s r2,r13
L_930d8e:
	add_s r1,r1,r0
L_930d90:
	cmp_s r1,0x1
L_930d92:
	mov_s r0,0x1
L_930d94:
	mov.hi r0,r1
L_930d98:
	cmp_s r0,0xf
L_930d9a:
	mov_s r14,0xf
L_930d9c:
	mov.cs r14,r0
L_930da0:
	extb_s r1,r14
L_930da2:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_930da4:
	mov r0,0x504
L_930da8:
	bl.d L_92bcac
L_930dac:
	or_s r1,r1,r2
L_930dae:
	bmsk r1,r13,0x3
L_930db2:
	add_s r0,gp,0x18
L_930db4:
	bl L_9379b8
L_930db8:
	mov_s r0,0x800988
L_930dbe:
	b.d L_920284
L_930dc2:
	stb_s r14,[r0,0x8]
