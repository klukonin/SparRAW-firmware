/* find_sm__start_listen @ 0x8f138c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND_SM:: Start listen
 * Зовёт сам: __ld_r13_ret, find_sm__report_listen_started, fw_log__emit0
 */
	.section .text.find_sm__start_listen,"ax",@progbits
	.global find_sm__start_listen
find_sm__start_listen:
	.byte 0x4f
	.byte 0xe7
	.global fwlog_FIND_SM_Start_listen
fwlog_FIND_SM_Start_listen:
L_8f138e:
	nop_s
L_8f1390:
	push_s blink
L_8f1392:
	push_s r13
L_8f1394:
	mov_s r13,r0
L_8f1396:
	mov_s r2,0x10146c0
L_8f139c:
	mov_s r0,0xc
L_8f139e:
	bl.d L_8edfb0
L_8f13a2:
	mov_s r1,0x2
L_8f13a4:
	bl.d L_8d7e98
L_8f13a8:
	ld_s r0,[r13,0x34]
L_8f13aa:
	.byte 0x95,0x07
