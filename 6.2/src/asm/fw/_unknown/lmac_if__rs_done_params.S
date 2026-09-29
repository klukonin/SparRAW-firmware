/* lmac_if__rs_done_params @ 0x8c2c5c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__rs_done_evt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event__r1_2_r3_0, hw__is_fpga_platform, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__rs_done_params
lmac_if__rs_done_params:
	.global L_8c2c5c
L_8c2c5c:
	push_s blink
L_8c2c5e:
	bl.d L_8c01e0
L_8c2c62:
	mov_s r2,0x10
L_8c2c64:
	sub_s sp,sp,0x30
L_8c2c66:
	mov_s r14,r0
L_8c2c68:
	mov_s r13,r1
L_8c2c6a:
	mov_s r15,sp
L_8c2c6c:
	mov_s r0,r15
L_8c2c6e:
	bl.d L_8c0380
L_8c2c72:
	add_s r1,r1,0x20
L_8c2c74:
	add_s r0,sp,0x10
L_8c2c76:
	mov_s r1,r13
L_8c2c78:
	bl.d L_8c0380
L_8c2c7c:
	mov_s r2,0x1f
L_8c2c7e:
	bl L_8da2c8
L_8c2c82:
	brne_s r0,0,L_8c2c9c
L_8c2c84:
	add3 r0,r14,0xa
L_8c2c88:
	add_s r1,sp,0x10
L_8c2c8a:
	bl.d L_8c0380
L_8c2c8e:
	mov_s r2,0x1f
L_8c2c90:
	ld_s r0,[r14]
L_8c2c92:
	cmp_s r0,0x0
L_8c2c94:
	bl.ne.d L_8dffe4
L_8c2c98:
	mov.ne r1,r15
	.global L_8c2c9c
L_8c2c9c:
	b.d L_8c024c
L_8c2ca0:
	add_s sp,sp,0x30
L_8c2ca2:
	nop_s
