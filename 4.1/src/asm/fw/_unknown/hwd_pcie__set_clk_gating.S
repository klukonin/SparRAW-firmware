/* hwd_pcie__set_clk_gating @ 0x8ce110, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm__apply_mode_flags
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.hwd_pcie__set_clk_gating,"ax",@progbits
	.global hwd_pcie__set_clk_gating
hwd_pcie__set_clk_gating:
	.global L_8ce110
L_8ce110:
	push_s blink
L_8ce112:
	bl.d L_8c02c0
L_8ce116:
	mov_s r3,0x1d
L_8ce118:
	mov_s r15,0x3ff7ff
L_8ce11e:
	mov_s r13,0x880c00
L_8ce124:
	mov_s r14,0xffc00800
L_8ce12a:
	mov_s r1,0x880a80
L_8ce130:
	mov_s r2,0xfffc5fff
L_8ce136:
	cmp_s r0,0x0
L_8ce138:
	ld_s r0,[r13,0x14]
L_8ce13a:
	asl_s r3,r3,0xd
L_8ce13c:
	beq_s L_8ce14c
L_8ce13e:
	and_s r14,r14,r0
L_8ce140:
	or_s r15,r15,r14
L_8ce142:
	st_s r15,[r13,0x14]
L_8ce144:
	ld_s r0,[r1,0x74]
L_8ce146:
	and_s r0,r0,r2
L_8ce148:
	or_s r0,r0,r3
L_8ce14a:
	b_s L_8ce154
	.global L_8ce14c
L_8ce14c:
	and_s r0,r0,r14
L_8ce14e:
	st_s r0,[r13,0x14]
L_8ce150:
	ld_s r0,[r1,0x74]
L_8ce152:
	and_s r0,r0,r2
	.global L_8ce154
L_8ce154:
	st_s r0,[r1,0x74]
L_8ce156:
	b L_8c032c
L_8ce15a:
	nop_s
