/* state_sm_803424__action_8f09f4 @ 0x8f09f4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, conn_mgr__by_cid, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_803424__action_8f09f4
state_sm_803424__action_8f09f4:
	.global L_8f09f4
L_8f09f4:
	push_s blink
L_8f09f6:
	push_s r13
L_8f09f8:
	mov_s r13,r0
L_8f09fa:
	bl.d L_8cbffc
L_8f09fe:
	mov_s r0,r3
L_8f0a00:
	ld_s r0,[r13,0xc]
L_8f0a02:
	breq_s r0,0,L_8f0a0c
L_8f0a04:
	bl L_8c8de0
L_8f0a08:
	mov_s r0,0x0
L_8f0a0a:
	st_s r0,[r13,0xc]
	.global L_8f0a0c
L_8f0a0c:
	b L_8c025c
