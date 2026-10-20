/* hwd_pcie__set_clk_gating @ 0x8d0e5c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm__apply_mode_flags
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__set_clk_gating
hwd_pcie__set_clk_gating:
	.global L_8d0e5c
L_8d0e5c:
	push_s blink
L_8d0e5e:
	bl.d L_8c01e0
L_8d0e62:
	mov_s r3,0x1d
L_8d0e64:
	mov_s r15,0x3ff7ff
L_8d0e6a:
	mov_s r13,0x880c00
L_8d0e70:
	mov_s r14,0xffc00800
L_8d0e76:
	mov_s r1,0x880a80
L_8d0e7c:
	mov_s r2,0xfffc5fff
L_8d0e82:
	cmp_s r0,0x0
L_8d0e84:
	ld_s r0,[r13,0x14]
L_8d0e86:
	asl_s r3,r3,0xd
L_8d0e88:
	beq_s L_8d0e98
L_8d0e8a:
	and_s r14,r14,r0
L_8d0e8c:
	or_s r15,r15,r14
L_8d0e8e:
	st_s r15,[r13,0x14]
L_8d0e90:
	ld_s r0,[r1,0x74]
L_8d0e92:
	and_s r0,r0,r2
L_8d0e94:
	or_s r0,r0,r3
L_8d0e96:
	b_s L_8d0ea0
	.global L_8d0e98
L_8d0e98:
	and_s r0,r0,r14
L_8d0e9a:
	st_s r0,[r13,0x14]
L_8d0e9c:
	ld_s r0,[r1,0x74]
L_8d0e9e:
	and_s r0,r0,r2
	.global L_8d0ea0
L_8d0ea0:
	st_s r0,[r1,0x74]
L_8d0ea2:
	b L_8c024c
L_8d0ea6:
	nop_s
