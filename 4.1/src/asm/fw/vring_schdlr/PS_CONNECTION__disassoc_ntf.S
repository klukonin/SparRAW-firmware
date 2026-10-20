/* PS_CONNECTION__disassoc_ntf @ 0x8c7990, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_CONNECTION::disassoc_ntf (m_conn_p=0x%x)
 * Зовут его: ps_conn_mgr__on_disassoc
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_log__emit1, psc__inject_disassoc_evt
 */
	.section .text.PS_CONNECTION__disassoc_ntf,"ax",@progbits
	.global PS_CONNECTION__disassoc_ntf
PS_CONNECTION__disassoc_ntf:
	.global L_8c7990
L_8c7990:
	push_s blink
L_8c7992:
	bl.d L_8c02c4
L_8c7996:
	mov_s r1,0x2
L_8c7998:
	mov_s r13,r0
L_8c799a:
	mov_s r2,0x1002904
L_8c79a0:
	mov_s r0,0xe
L_8c79a2:
	bl.d L_8edfcc
L_8c79a6:
	ld_s r3,[r13,0x58]
L_8c79a8:
	add_s r0,r13,0x4
L_8c79aa:
	mov_s r1,0x4
L_8c79ac:
	mov_s r14,0x0
L_8c79ae:
	mov_s r2,r14
L_8c79b0:
	mov_s r3,r14
L_8c79b2:
	bl.d L_8d6a1c
L_8c79b6:
	mov_s r4,r14
L_8c79b8:
	bl.d L_8c5bf0
L_8c79bc:
	add2 r0,r13,0x17
L_8c79c0:
	b.d L_8c0334
