/* pring__set_done_handler @ 0x8e7334, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pring__init_pool, wmi_enable_fixed_scheduling
 * Глобалы (через gp): 0x800188, 0x80018c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pring__set_done_handler
pring__set_done_handler:
	.global L_8e7334
L_8e7334:
	st.as r0,[gp,0x1]
L_8e7338:
	j_s.d [blink]
L_8e733a:
	st.as r1,[gp,0x2]
L_8e733e:
	nop_s
