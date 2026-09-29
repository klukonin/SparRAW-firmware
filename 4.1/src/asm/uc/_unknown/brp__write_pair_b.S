/* brp__write_pair_b @ 0x930d2c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret_uc, brp__write_reg_pair
 * Глобалы (через gp): 0x800540
 */
	.section .text.brp__write_pair_b,"ax",@progbits
	.global brp__write_pair_b
brp__write_pair_b:
L_930d2c:
	push_s blink
L_930d2e:
	push_s r13
L_930d30:
	ld.as r1,[gp,0x6]
L_930d34:
	mov_s r13,0xf
L_930d36:
	lsr_s r1,r1,0x2
L_930d38:
	bmsk r2,r1,0x3
L_930d3c:
	mov_s r1,0x801660
L_930d42:
	ld_s r1,[r1,0x5c]
L_930d44:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_930d46:
	add_s r0,r0,r1
L_930d48:
	cmp_s r0,0x1
L_930d4a:
	mov.ls r0,0x1
L_930d4e:
	cmp_s r0,0xf
L_930d50:
	mov.cs r13,r0
L_930d54:
	extb_s r1,r13
L_930d56:
	mov r0,0x504
L_930d5a:
	bl.d L_92bcac
L_930d5e:
	or_s r1,r1,r2
L_930d60:
	mov_s r0,0x800988
L_930d66:
	b.d L_92028c
L_930d6a:
	stb_s r13,[r0,0x8]
