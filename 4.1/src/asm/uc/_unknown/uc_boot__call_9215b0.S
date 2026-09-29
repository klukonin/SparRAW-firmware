/* uc_boot__call_9215b0 @ 0x920100, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_boot__call_9215b0,"ax",@progbits
	.global uc_boot__call_9215b0
uc_boot__call_9215b0:
L_920100:
	st.a blink,[sp,-0x4]
L_920104:
	jl 0x15b0
L_92010c:
	ld.ab blink,[sp,0x4]
L_920110:
	j [blink]
