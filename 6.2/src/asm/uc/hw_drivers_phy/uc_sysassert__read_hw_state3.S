/* uc_sysassert__read_hw_state3 @ 0x929ae4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_sysassert__idle_hist
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_sysassert__read_hw_state3
uc_sysassert__read_hw_state3:
	.global L_929ae4
L_929ae4:
	ld r0,[0x8896ac]
L_929aec:
	j.d [blink]
L_929af0:
	bmsk_s r0,r0,0x2
L_929af2:
	nop_s
