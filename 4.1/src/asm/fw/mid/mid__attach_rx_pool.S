/* mid__attach_rx_pool @ 0x8e1400, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_pool__configure_ring
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mid__refill_rx_buffers, rx_pool__set_fields
 */
	.section .text.mid__attach_rx_pool,"ax",@progbits
	.global mid__attach_rx_pool
mid__attach_rx_pool:
	.global L_8e1400
L_8e1400:
	push_s blink
L_8e1402:
	bl L_8c02c4
L_8e1406:
	mov_s r13,r0
L_8e1408:
	bl.d L_8d6384
L_8e140c:
	mov_s r14,r3
L_8e140e:
	bl.d L_8e1e4c
L_8e1412:
	mov_s r0,r13
L_8e1414:
	st_s r14,[r13,0x10]
L_8e1416:
	mov_s r0,0x0
L_8e1418:
	b.d L_8c0334
