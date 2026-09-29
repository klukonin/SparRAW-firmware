/* addba_rsp_handler @ 0x8c2984, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   addba_rsp_handler.
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.addba_rsp_handler,"ax",@progbits
	.global addba_rsp_handler
addba_rsp_handler:
L_8c2984:
	/* b_s 0x008c295c */
	.byte 0xec,0xf1
	.global fwlog_addba_rsp_handler
fwlog_addba_rsp_handler:
L_8c2986:
	nop_s
L_8c2988:
	push_s blink
L_8c298a:
	bl L_8c02c4
L_8c298e:
	mov_s r13,r0
L_8c2990:
	mov_s r14,r1
L_8c2992:
	mov_s r2,0x101019c
L_8c2998:
	mov_s r0,0xb
L_8c299a:
	bl.d L_8edfb0
L_8c299e:
	mov_s r1,0x2
L_8c29a0:
	add r0,r13,0x2c
L_8c29a4:
	mov_s r1,0x6
L_8c29a6:
	mov_s r2,r14
L_8c29a8:
	mov_s r3,0x0
L_8c29aa:
	bl.d L_8d6a1c
L_8c29ae:
	mov_s r4,r3
L_8c29b0:
	b L_8c0334
