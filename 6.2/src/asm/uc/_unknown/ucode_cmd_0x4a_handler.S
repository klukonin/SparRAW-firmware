/* ucode_cmd_0x4a_handler @ 0x934ba4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Глобалы (через gp): 0x800644
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x4a_handler
ucode_cmd_0x4a_handler:
	.global L_934ba4
L_934ba4:
	ld_s r0,[r0]
L_934ba6:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_934ba8:
	j_s.d [blink]
L_934baa:
	st.as r0,[gp,0x47]
L_934bae:
	nop_s
