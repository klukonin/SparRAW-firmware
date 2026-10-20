/* TX_API__call_mem_pool_alloc_err_cb @ 0x8c4c40, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::call_mem_pool_alloc_err_cb. Calling CB 0x%x for packet with status FWQ_TX_MEM_POOL_ALLOC_ERR
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/tx_api.h
 *   TX_API::call_mem_pool_alloc_err_cb. Called with NULL CB func
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit0, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.TX_API__call_mem_pool_alloc_err_cb,"ax",@progbits
	.global TX_API__call_mem_pool_alloc_err_cb
TX_API__call_mem_pool_alloc_err_cb:
	.byte 0x8f
	.byte 0xfd
	.global fwlog_TX_API_call_mem_pool_alloc_err_cb_Callin
fwlog_TX_API_call_mem_pool_alloc_err_cb_Callin:
L_8c4c42:
	nop_s
L_8c4c44:
	push_s blink
L_8c4c46:
	bl L_8c02bc
L_8c4c4a:
	sub_s sp,sp,0x8
L_8c4c4c:
	mov_s r14,r0
L_8c4c4e:
	mov_s r13,0x805da8
L_8c4c54:
	mov_s r16,r1
L_8c4c56:
	mov_s r15,sp
L_8c4c58:
	breq_s r13,0,L_8c4c7c
	.global L_8c4c5a
L_8c4c5a:
	st_s r13,[r15]
L_8c4c5c:
	add_s r13,r13,0x1c
L_8c4c5e:
	st_s r13,[r15,0x4]
L_8c4c60:
	breq_s r14,0,L_8c4c92
L_8c4c62:
	mov_s r2,0x1015228
L_8c4c68:
	mov_s r0,0x7
L_8c4c6a:
	mov_s r1,0x2
L_8c4c6c:
	bl.d L_8edfcc
L_8c4c70:
	mov_s r3,r14
L_8c4c72:
	ld_s r0,[sp,0x4]
L_8c4c74:
	mov_s r1,0xfd
L_8c4c76:
	jl_s.d [r14]
L_8c4c78:
	mov_s r2,r16
L_8c4c7a:
	b_s L_8c4ca0
	.global L_8c4c7c
L_8c4c7c:
	mov_s r0,blink
L_8c4c7e:
	mov_s r2,0x1014d54
L_8c4c84:
	mov_s r1,0x11d6
L_8c4c8a:
	bl.d L_8c82c0
L_8c4c8e:
	mov_s r3,0xaa
L_8c4c90:
	b_s L_8c4c5a
	.global L_8c4c92
L_8c4c92:
	mov_s r2,0x1015290
L_8c4c98:
	mov_s r0,0x7
L_8c4c9a:
	bl.d L_8edfb0
L_8c4c9e:
	mov_s r1,0x1
	.global L_8c4ca0
L_8c4ca0:
	b.d L_8c0324
