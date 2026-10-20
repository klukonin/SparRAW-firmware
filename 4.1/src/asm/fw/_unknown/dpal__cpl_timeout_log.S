/* dpal__cpl_timeout_log @ 0x8c7f68, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DPAL CPL TO Event
 * Зовут его: isr_pcie_debug
 * Зовёт сам: fw_log__emit0, set_reg_88269c, u_schd__add
 */
	.section .text.dpal__cpl_timeout_log,"ax",@progbits
	.global dpal__cpl_timeout_log
dpal__cpl_timeout_log:
	.global L_8c7f68
L_8c7f68:
	push_s blink
L_8c7f6a:
	mov_s r2,0x1003a34
L_8c7f70:
	mov_s r0,0xf
L_8c7f72:
	bl.d L_8edfb0
L_8c7f76:
	mov_s r1,0x2
L_8c7f78:
	bl L_8ee768
L_8c7f7c:
	mov_s r0,0x7e98
L_8c7f82:
	mov_s r1,0x0
L_8c7f84:
	mov_s r2,r1
L_8c7f86:
	bl.d L_8c2ac8
L_8c7f8a:
	mov_s r3,0x2
L_8c7f8c:
	pop_s blink
L_8c7f8e:
	j_s [blink]
