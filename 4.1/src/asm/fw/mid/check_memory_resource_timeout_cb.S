/* check_memory_resource_timeout_cb @ 0x8c5554, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   check_memory_resource_timeout_cb
 *   mid.cpp
 * Зовёт сам: __ld_r13_ret, assoc_ready_check_trig, fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.check_memory_resource_timeout_cb,"ax",@progbits
	.global check_memory_resource_timeout_cb
check_memory_resource_timeout_cb:
L_8c5554:
	push_s blink
L_8c5556:
	push_s r13
L_8c5558:
	mov_s r13,r0
L_8c555a:
	mov_s r2,0x100b518
L_8c5560:
	mov_s r0,0xb
L_8c5562:
	bl.d L_8edfb0
L_8c5566:
	mov_s r1,0x2
L_8c5568:
	breq_s r13,0,L_8c557a
	.global L_8c556a
L_8c556a:
	mov_s r0,0x0
L_8c556c:
	st.as r0,[r13,0xb8]
L_8c5570:
	bl.d L_8c33f4
L_8c5574:
	mov_s r0,r13
L_8c5576:
	b L_8c033c
	.global L_8c557a
L_8c557a:
	mov_s r0,blink
L_8c557c:
	mov_s r2,0x100aedc
L_8c5582:
	mov_s r1,0x1457
L_8c5588:
	bl.d L_8c82c0
L_8c558c:
	mov r3,0x4d3
