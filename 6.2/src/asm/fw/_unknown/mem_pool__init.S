/* mem_pool__init @ 0x8c7cf8, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: add_bcon, add_discovery_bcon, l2mgr__init_frame_pool, link_loss_detectors__init, lmac_if__build_cmd_rings, mbox__init_descriptor, mid__init_scan_and_pools, mid_ctx__init_pools, mid_ctx_pool__init, pring__init_pool
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, mem_pool__link_free_list
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mem_pool__init
mem_pool__init:
	.global L_8c7cf8
L_8c7cf8:
	push_s blink
L_8c7cfa:
	bl L_8c01dc
L_8c7cfe:
	mov_s r13,r0
L_8c7d00:
	mov.f r14,r1
L_8c7d04:
	mov_s r16,r2
L_8c7d06:
	mov_s r15,r3
L_8c7d08:
	beq_s L_8c7d2c
	.global L_8c7d0a
L_8c7d0a:
	breq r16,0x0,L_8c7d36
	.global L_8c7d0e
L_8c7d0e:
	breq_s r15,0,L_8c7d40
	.global L_8c7d10
L_8c7d10:
	st_s r14,[r13,0x4]
L_8c7d12:
	st r16,[r13, 0x8]
L_8c7d16:
	st_s r15,[r13,0x10]
L_8c7d18:
	mov_s r0,0x0
L_8c7d1a:
	st_s r0,[r13,0xc]
L_8c7d1c:
	st_s r0,[r13]
L_8c7d1e:
	mov_s r0,r13
L_8c7d20:
	mov_s r1,r14
L_8c7d22:
	bl.d L_8c53f8
L_8c7d26:
	mov_s r2,r15
L_8c7d28:
	b L_8c0244
	.global L_8c7d2c
L_8c7d2c:
	mov_s r0,blink
L_8c7d2e:
	bl.d L_8c9b28
L_8c7d32:
	mov_s r1,0xdf
L_8c7d34:
	b_s L_8c7d0a
	.global L_8c7d36
L_8c7d36:
	mov_s r0,blink
L_8c7d38:
	bl.d L_8c9b28
L_8c7d3c:
	mov_s r1,0xe0
L_8c7d3e:
	b_s L_8c7d0e
	.global L_8c7d40
L_8c7d40:
	mov_s r0,blink
L_8c7d42:
	bl.d L_8c9b28
L_8c7d46:
	mov_s r1,0xe1
L_8c7d48:
	b_s L_8c7d10
L_8c7d4a:
	nop_s
