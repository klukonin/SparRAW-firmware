/* itx__set_result_code @ 0x927e54, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm4
 * Зовёт сам: __ld_r13_to_r13_ret, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global itx__set_result_code
itx__set_result_code:
	.global L_927e54
L_927e54:
	push_s blink
L_927e56:
	push_s r13
L_927e58:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_927e5a:
	add2_s r0,r0,r0
L_927e5c:
	add_s r0,r0,0x802354
L_927e62:
	tst_s r3,r1
L_927e64:
	ldb_s r13,[r0,0x13]
L_927e66:
	mov.ne r1,0xd
L_927e6a:
	bne_s L_927eb8
L_927e6c:
	breq r13,0x1,L_927e84
L_927e70:
	breq r13,0x4,L_927e96
L_927e74:
	breq r13,0x7,L_927ea8
L_927e78:
	mov_s r0,blink
L_927e7a:
	mov_s r1,0xa3
L_927e7c:
	/* bl.d 0x00926618 */
	.byte 0x9e,0x0f,0x2f,0xff
L_927e80:
	/* _asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_927e82:
	b_s L_927eba
	.global L_927e84
L_927e84:
	cmp_s r1,0x0
L_927e86:
	mov.ne r1,0x2
L_927e8a:
	bne_s L_927eb8
L_927e8c:
	cmp_s r2,0x0
L_927e8e:
	mov_s r1,0x3
L_927e90:
	mov.eq r1,0xa
L_927e94:
	b_s L_927eb8
	.global L_927e96
L_927e96:
	cmp_s r1,0x0
L_927e98:
	mov.ne r1,0x5
L_927e9c:
	bne_s L_927eb8
L_927e9e:
	cmp_s r2,0x0
L_927ea0:
	mov_s r1,0x6
L_927ea2:
	mov.eq r1,0xb
L_927ea6:
	b_s L_927eb8
	.global L_927ea8
L_927ea8:
	cmp_s r1,0x0
L_927eaa:
	mov.ne r1,0x8
L_927eae:
	bne_s L_927eb8
L_927eb0:
	cmp_s r2,0x0
L_927eb2:
	mov_s r1,0x9
L_927eb4:
	mov.eq r1,0xc
	.global L_927eb8
L_927eb8:
	stb_s r1,[r0,0x13]
	.global L_927eba
L_927eba:
	b L_9202ac
L_927ebe:
	nop_s
