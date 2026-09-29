/* tx_api__call_mem_pool_alloc_err_cb @ 0x8c5a34, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::call_mem_pool_alloc_err_cb. Calling CB 0x%x for packet with status FWQ_TX_MEM_POOL_ALLOC_ERR
 *   TX_API::call_mem_pool_alloc_err_cb. Called with NULL CB func
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__call_mem_pool_alloc_err_cb
tx_api__call_mem_pool_alloc_err_cb:
	.global L_8c5a34
L_8c5a34:
	push_s blink
L_8c5a36:
	bl L_8c01dc
L_8c5a3a:
	sub_s sp,sp,0x8
L_8c5a3c:
	mov_s r14,r0
L_8c5a3e:
	mov_s r13,0x805ac0
L_8c5a44:
	mov_s r16,r1
L_8c5a46:
	mov_s r15,sp
L_8c5a48:
	breq_s r13,0,L_8c5a6a
	.global L_8c5a4a
L_8c5a4a:
	st_s r13,[r15]
L_8c5a4c:
	add_s r13,r13,0x24
L_8c5a4e:
	st_s r13,[r15,0x4]
L_8c5a50:
	breq_s r14,0,L_8c5a78
L_8c5a52:
	mov_s r1,0x101863c
L_8c5a58:
	mov_s r0,0x27
L_8c5a5a:
	bl.d L_8dcc10
L_8c5a5e:
	mov_s r2,r14
L_8c5a60:
	ld_s r0,[sp,0x4]
L_8c5a62:
	mov_s r1,0xfd
L_8c5a64:
	jl_s.d [r14]
L_8c5a66:
	mov_s r2,r16
L_8c5a68:
	b_s L_8c5a84
	.global L_8c5a6a
L_8c5a6a:
	mov_s r0,blink
L_8c5a6c:
	mov_s r1,0x11d6
L_8c5a72:
	bl L_8c9b28
L_8c5a76:
	b_s L_8c5a4a
	.global L_8c5a78
L_8c5a78:
	mov_s r1,0x10186a4
L_8c5a7e:
	bl.d L_8dcba8
L_8c5a82:
	mov_s r0,0x17
	.global L_8c5a84
L_8c5a84:
	b.d L_8c0244
L_8c5a88:
	add_s sp,sp,0x8
L_8c5a8a:
	nop_s
