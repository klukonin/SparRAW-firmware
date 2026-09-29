/* get_connection_by_addr @ 0x8cb560, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   get_connection_by_addr() returned NULL
 * Зовут его: state_sm_8034c0__action_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, conn_mgr__find_by_mac, ftm__set_shared_active_flag, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global get_connection_by_addr
get_connection_by_addr:
	.global L_8cb560
L_8cb560:
	push_s blink
L_8cb562:
	bl L_8c01e4
L_8cb566:
	mov_s r14,r1
L_8cb568:
	mov_s r13,0x0
L_8cb56a:
	bl.d L_8cb544
L_8cb56e:
	mov_s r0,r13
L_8cb570:
	bl.d L_8cbf2c
L_8cb574:
	add r0,r14,0x10
L_8cb578:
	breq_s r0,0,L_8cb590
L_8cb57a:
	add r0,r0,0x164
L_8cb57e:
	st_s r14,[r0,0x1c]
L_8cb580:
	mov_s r1,r13
L_8cb582:
	mov_s r2,r13
L_8cb584:
	mov_s r3,r13
L_8cb586:
	bl.d L_8d9b6c
L_8cb58a:
	mov_s r4,r13
L_8cb58c:
	mov_s r0,0x1
L_8cb58e:
	b_s L_8cb59e
	.global L_8cb590
L_8cb590:
	mov_s r1,0x101a074
L_8cb596:
	bl.d L_8dcba8
L_8cb59a:
	mov_s r0,0xb
L_8cb59c:
	mov_s r0,r13
	.global L_8cb59e
L_8cb59e:
	b L_8c0254
L_8cb5a2:
	nop_s
