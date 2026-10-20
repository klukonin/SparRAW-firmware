/* stream_mgr__alloc_pring @ 0x8c2d04, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stream_mgr.cpp
 * Зовут его: encap_trans_type, wmi_handler_bcast_vring_cfg
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, mem_pool__allocate
 */
	.section .text.stream_mgr__alloc_pring,"ax",@progbits
	.global stream_mgr__alloc_pring
stream_mgr__alloc_pring:
	.global L_8c2d04
L_8c2d04:
	push_s blink
L_8c2d06:
	mov_s r0,0x847ddc
L_8c2d0c:
	bl.d L_8c2dc8
L_8c2d10:
	push_s r13
L_8c2d12:
	mov.f r13,r0
L_8c2d16:
	beq_s L_8c2d1e
	.global L_8c2d18
L_8c2d18:
	b.d L_8c033c
L_8c2d1c:
	mov_s r0,r13
	.global L_8c2d1e
L_8c2d1e:
	mov_s r0,blink
L_8c2d20:
	mov_s r2,0x100e398
L_8c2d26:
	mov_s r1,0x85
L_8c2d28:
	bset_s r1,r1,0xc
L_8c2d2a:
	bl.d L_8c82c0
L_8c2d2e:
	mov_s r3,0x36
L_8c2d30:
	b_s L_8c2d18
L_8c2d32:
	nop_s
