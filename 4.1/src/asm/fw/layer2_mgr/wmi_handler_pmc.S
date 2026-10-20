/* wmi_handler_pmc @ 0x8f2e08, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Illegal pmc op: 0x%08X
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r13_ret, dma_mgr__configure_ring, dma_mgr__reset_queue, fw_log__emit1
 */
	.section .text.wmi_handler_pmc,"ax",@progbits
	.global wmi_handler_pmc
wmi_handler_pmc:
	.global L_8f2e08
L_8f2e08:
	push_s blink
L_8f2e0a:
	push_s r13
L_8f2e0c:
	ldb_s r3,[r0]
L_8f2e0e:
	mov_s r13,r0
L_8f2e10:
	breq_s r3,0,L_8f2e26
L_8f2e12:
	breq r3,0x1,L_8f2e44
L_8f2e16:
	mov_s r2,0x100d1a0
L_8f2e1c:
	mov_s r0,0xb
L_8f2e1e:
	bl.d L_8edfcc
L_8f2e22:
	mov_s r1,0x0
L_8f2e24:
	b_s L_8f2e4a
	.global L_8f2e26
L_8f2e26:
	mov r4,0x0
L_8f2e2a:
	ld_s r1,[r13,0x4]
L_8f2e2c:
	mov_s r0,0x7
L_8f2e2e:
	ld_s r2,[r13,0x8]
L_8f2e30:
	mov r5,r4
L_8f2e34:
	ldw_s r3,[r13,0x2]
L_8f2e36:
	mov r6,r4
L_8f2e3a:
	bl.d L_8c611c
L_8f2e3e:
	mov r7,r4
L_8f2e42:
	b_s L_8f2e4a
	.global L_8f2e44
L_8f2e44:
	bl.d L_8e2e78
L_8f2e48:
	mov_s r0,0x7
	.global L_8f2e4a
L_8f2e4a:
	b L_8c033c
L_8f2e4e:
	nop_s
