/* tx_desc__set_lifetime @ 0x8cc490, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Lifetime: MTRL count %x ->%x, set to %x
 * Зовут его: tx_desc__build
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_desc__set_lifetime
tx_desc__set_lifetime:
	.global L_8cc490
L_8cc490:
	push_s blink
L_8cc492:
	bl.d L_8c01e4
L_8cc496:
	mov_s r3,0x2
L_8cc498:
	cmp_s r1,0x2
L_8cc49a:
	mov.hi r3,r1
L_8cc49e:
	mov_s r1,0x886a80
L_8cc4a4:
	ld_s r2,[r1,0x28]
L_8cc4a6:
	asl_s r3,r3,r0
L_8cc4a8:
	add_s r3,r3,r2
L_8cc4aa:
	lsr r13,r3,r0
L_8cc4ae:
	bmsk r14,r13,0x9
L_8cc4b2:
	mov_s r1,0x1018d64
L_8cc4b8:
	mov_s r0,0x27
L_8cc4ba:
	bl.d L_8dcd00
L_8cc4be:
	mov_s r4,r14
L_8cc4c0:
	b.d L_8c0254
L_8cc4c4:
	mov_s r0,r14
L_8cc4c6:
	nop_s
