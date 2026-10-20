/* pcp_stop @ 0x8f720c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_stop()
 * Зовут его: pcp_stop__flow
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, tx_bcon__del_bcon
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_stop
pcp_stop:
	.global L_8f720c
L_8f720c:
	push_s blink
L_8f720e:
	push_s r13
L_8f7210:
	mov_s r13,r0
L_8f7212:
	mov_s r1,0x1016dcc
L_8f7218:
	bl.d L_8dcba8
L_8f721c:
	mov_s r0,0x2c
L_8f721e:
	bl.d L_8c8be8
L_8f7222:
	ld_s r0,[r13,0x4]
L_8f7224:
	b L_8c025c
