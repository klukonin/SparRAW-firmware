/* mem_pool__init @ 0x8c6c70, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mem_pool.cpp
 * Зовут его: detectors_init_sweep, l2mgr__init_frame_pool, l2mgr__init_oob_pool, lmac_if__build_cmd_rings, mbox__build_rings_and_pool, mid__open_reset_state, mid_ctx_pool__init, mid_pool__init, radio_mgr__init_pool_and_sm, rx_pool__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, mem_pool__link_free_list
 */
	.section .text.mem_pool__init,"ax",@progbits
	.global mem_pool__init
mem_pool__init:
	.global L_8c6c70
L_8c6c70:
	push_s blink
L_8c6c72:
	bl L_8c02bc
L_8c6c76:
	mov_s r13,r0
L_8c6c78:
	mov.f r14,r1
L_8c6c7c:
	mov_s r16,r2
L_8c6c7e:
	mov_s r15,r3
L_8c6c80:
	beq_s L_8c6ca4
	.global L_8c6c82
L_8c6c82:
	breq r16,0x0,L_8c6cb6
	.global L_8c6c86
L_8c6c86:
	breq_s r15,0,L_8c6cc8
	.global L_8c6c88
L_8c6c88:
	st_s r14,[r13,0x4]
L_8c6c8a:
	st r16,[r13, 0x8]
L_8c6c8e:
	st_s r15,[r13,0x10]
L_8c6c90:
	mov_s r0,0x0
L_8c6c92:
	st_s r0,[r13,0xc]
L_8c6c94:
	st_s r0,[r13]
L_8c6c96:
	mov_s r0,r13
L_8c6c98:
	mov_s r1,r14
L_8c6c9a:
	bl.d L_8c487c
L_8c6c9e:
	mov_s r2,r15
L_8c6ca0:
	b L_8c0324
	.global L_8c6ca4
L_8c6ca4:
	mov_s r0,blink
L_8c6ca6:
	mov_s r2,0x1001b84
L_8c6cac:
	mov_s r1,0xdf
L_8c6cae:
	bl.d L_8c82c0
L_8c6cb2:
	mov_s r3,0x10
L_8c6cb4:
	b_s L_8c6c82
	.global L_8c6cb6
L_8c6cb6:
	mov_s r0,blink
L_8c6cb8:
	mov_s r2,0x1001b84
L_8c6cbe:
	mov_s r1,0xe0
L_8c6cc0:
	bl.d L_8c82c0
L_8c6cc4:
	mov_s r3,0x11
L_8c6cc6:
	b_s L_8c6c86
	.global L_8c6cc8
L_8c6cc8:
	mov_s r0,blink
L_8c6cca:
	mov_s r2,0x1001b84
L_8c6cd0:
	mov_s r1,0xe1
L_8c6cd2:
	bl.d L_8c82c0
L_8c6cd6:
	mov_s r3,0x12
L_8c6cd8:
	b_s L_8c6c88
L_8c6cda:
	nop_s
