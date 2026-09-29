/* pcp_psc_sm__psc_start_flow @ 0x8e1c04, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__action
 * Зовёт сам: ps_connection__psc_rsp_rx_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_psc_sm__psc_start_flow
pcp_psc_sm__psc_start_flow:
	.global L_8e1c04
L_8e1c04:
	mul64 r0,0x88
L_8e1c08:
	add r0,mlo,0x803db0
L_8e1c10:
	b L_8e1be4
