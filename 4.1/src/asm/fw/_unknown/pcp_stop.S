/* pcp_stop @ 0x8ef014, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_stop()
 * Зовут его: pcp_stop__flow
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, tx_bcon__del_bcon
 */
	.section .text.pcp_stop,"ax",@progbits
	.global pcp_stop
pcp_stop:
	.global L_8ef014
L_8ef014:
	push_s blink
L_8ef016:
	push_s r13
L_8ef018:
	mov_s r13,r0
L_8ef01a:
	mov_s r2,0x10125f0
L_8ef020:
	mov_s r0,0xc
L_8ef022:
	bl.d L_8edfb0
L_8ef026:
	mov_s r1,0x2
L_8ef028:
	bl.d L_8c7578
L_8ef02c:
	ld_s r0,[r13,0x4]
L_8ef02e:
	b L_8c033c
L_8ef032:
	nop_s
