/* bf_req__is_claimable @ 0x8f5cac, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysapi_mgr__start_sysapi_cmd, fw_sysapi_mgr__stop_sysapi_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bf_req__is_claimable
bf_req__is_claimable:
	.global L_8f5cac
L_8f5cac:
	ld_s r2,[r0,0x18]
L_8f5cae:
	mov_s r3,0x0
L_8f5cb0:
	breq_s r2,0,L_8f5cba
L_8f5cb2:
	ld_s r2,[r0,0x1c]
L_8f5cb4:
	cmp_s r2,0x0
L_8f5cb6:
	mov.eq r3,0x1
	.global L_8f5cba
L_8f5cba:
	extb_s r3,r3
L_8f5cbc:
	breq_s r1,0,L_8f5ccc
L_8f5cbe:
	mov_s r2,0x0
L_8f5cc0:
	breq_s r3,0,L_8f5cca
L_8f5cc2:
	ld_s r0,[r0]
L_8f5cc4:
	cmp_s r1,r0
L_8f5cc6:
	mov.eq r2,0x1
	.global L_8f5cca
L_8f5cca:
	extb_s r3,r2
	.global L_8f5ccc
L_8f5ccc:
	j_s.d [blink]
L_8f5cce:
	mov_s r0,r3
