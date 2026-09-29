/* mid__open @ 0x8c2d4c, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Reject MID opening - ID %d is already exist.
 *   Cannot open additional MID - no resources.
 * Зовут его: l2mgr__mac_started_log
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit1, mem_pool__allocate, mid__init, mid__open_reset_state, mid__program_mac_addr, mid__set_default_counters, mid_list__by_mid
 */
	.section .text.mid__open,"ax",@progbits
	.global mid__open
mid__open:
	.global L_8c2d4c
L_8c2d4c:
	push_s blink
L_8c2d4e:
	bl L_8c02c4
L_8c2d52:
	bl.d L_8ca1b0
L_8c2d56:
	mov_s r13,r0
L_8c2d58:
	breq_s r0,0,L_8c2d6c
L_8c2d5a:
	mov_s r2,0x100b410
L_8c2d60:
	mov_s r0,0xb
L_8c2d62:
	mov_s r1,0x1
L_8c2d64:
	bl.d L_8edfcc
L_8c2d68:
	mov_s r3,r13
L_8c2d6a:
	b_s L_8c2dc0
	.global L_8c2d6c
L_8c2d6c:
	mov_s r0,0x8058dc
L_8c2d72:
	bl L_8c2dc8
L_8c2d76:
	mov.f r14,r0
L_8c2d7a:
	beq_s L_8c2db2
L_8c2d7c:
	stb_s r13,[r14,0x10]
L_8c2d7e:
	mov_s r0,0x0
L_8c2d80:
	stb r0,[r14, 0x24]
L_8c2d84:
	mov_s r0,r14
L_8c2d86:
	add r0,r0,0x234
L_8c2d8a:
	bl.d L_8ed4b8
L_8c2d8e:
	mov_s r1,r14
L_8c2d90:
	add3 r0,r14,0x9
L_8c2d94:
	bl.d L_8d6568
L_8c2d98:
	mov_s r1,r14
L_8c2d9a:
	add r0,r14,0x28
L_8c2d9e:
	bl.d L_8ed200
L_8c2da2:
	mov_s r1,r14
L_8c2da4:
	mov_s r0,r14
L_8c2da6:
	add r0,r0,0x2b4
L_8c2daa:
	bl.d L_8d5e64
L_8c2dae:
	mov_s r1,r14
L_8c2db0:
	b_s L_8c2dc2
	.global L_8c2db2
L_8c2db2:
	mov_s r2,0x100b440
L_8c2db8:
	mov_s r0,0xb
L_8c2dba:
	bl.d L_8edfb0
L_8c2dbe:
	mov_s r1,0x1
	.global L_8c2dc0
L_8c2dc0:
	mov_s r14,0x0
	.global L_8c2dc2
L_8c2dc2:
	b.d L_8c0334
L_8c2dc6:
	mov_s r0,r14
