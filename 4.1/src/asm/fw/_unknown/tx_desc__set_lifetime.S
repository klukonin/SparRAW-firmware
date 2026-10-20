/* tx_desc__set_lifetime @ 0x8ca264, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Lifetime: MTRL count %x ->%x, set to %x
 * Зовут его: tx_desc__build
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit3
 */
	.section .text.tx_desc__set_lifetime,"ax",@progbits
	.global tx_desc__set_lifetime
tx_desc__set_lifetime:
	.global L_8ca264
L_8ca264:
	push_s blink
L_8ca266:
	bl L_8c02c0
L_8ca26a:
	cmp_s r1,0x2
L_8ca26c:
	mov_s r13,0x2
L_8ca26e:
	mov.hi r13,r1
L_8ca272:
	mov_s r1,0x886a80
L_8ca278:
	ld_s r3,[r1,0x28]
L_8ca27a:
	asl_s r13,r13,r0
L_8ca27c:
	add_s r13,r13,r3
L_8ca27e:
	lsr r14,r13,r0
L_8ca282:
	bmsk r15,r14,0x9
L_8ca286:
	mov_s r2,0x1015aac
L_8ca28c:
	mov_s r0,0x7
L_8ca28e:
	mov_s r1,0x2
L_8ca290:
	mov_s r4,r13
L_8ca292:
	bl.d L_8ee034
L_8ca296:
	mov_s r5,r15
L_8ca298:
	b.d L_8c032c
L_8ca29c:
	mov_s r0,r15
L_8ca29e:
	nop_s
