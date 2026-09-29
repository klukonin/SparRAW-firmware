/* find_sm__stop_discovery @ 0x8e2fc4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_main_sm__stop
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, discovery__rx_stop, l2mgr__send_discovery_stopped, u_schd__cancel
 */
	.section .text.find_sm__stop_discovery,"ax",@progbits
	.global find_sm__stop_discovery
find_sm__stop_discovery:
	.global L_8e2fc4
L_8e2fc4:
	push_s blink
L_8e2fc6:
	bl L_8c02c4
L_8e2fca:
	mov_s r13,r0
L_8e2fcc:
	ld_s r0,[r0,0x18]
L_8e2fce:
	mov_s r14,0x0
L_8e2fd0:
	breq_s r0,0,L_8e2fd8
L_8e2fd2:
	bl L_8c7794
L_8e2fd6:
	st_s r14,[r13,0x18]
	.global L_8e2fd8
L_8e2fd8:
	bl L_8efdac
L_8e2fdc:
	st_s r14,[r13,0x64]
L_8e2fde:
	ld_s r0,[r13,0x6c]
L_8e2fe0:
	bl.d L_8f05d0
L_8e2fe4:
	ldb_s r0,[r0,0x10]
L_8e2fe6:
	b L_8c0334
L_8e2fea:
	nop_s
