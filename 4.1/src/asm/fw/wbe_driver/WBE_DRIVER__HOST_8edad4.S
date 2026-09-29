/* WBE_DRIVER__HOST_8edad4 @ 0x8edad4, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WBE_DRIVER::HOST:: DRIVER is UP - ENUMRATION STARTING!!!
 * Зовёт сам: fw_log__emit0, pcie__set_event_bit, set_reg_882670_882684, set_reg_882680_8ee788, u_schd__cancel
 */
	.section .text.WBE_DRIVER__HOST_8edad4,"ax",@progbits
	.global WBE_DRIVER__HOST_8edad4
WBE_DRIVER__HOST_8edad4:
L_8edad4:
	push_s blink
L_8edad6:
	ld_s r0,[gp,-0x78]
L_8edad8:
	breq_s r0,0,L_8edae4
L_8edada:
	bl L_8c7794
L_8edade:
	mov_s r0,0x0
L_8edae0:
	st.as r0,[gp,-0x1e]
	.global L_8edae4
L_8edae4:
	bl L_8f28f8
L_8edae8:
	bl L_8ee788
L_8edaec:
	mov_s r2,0x1003b90
L_8edaf2:
	mov_s r0,0xf
L_8edaf4:
	bl.d L_8edfb0
L_8edaf8:
	mov_s r1,0x2
L_8edafa:
	bl.d L_8cedf0
L_8edafe:
	mov_s r0,0x2
L_8edb00:
	ld.as r3,[gp,-0x22]
L_8edb04:
	ld_s r0,[gp,-0x90]
L_8edb06:
	ld.as r1,[gp,-0x23]
L_8edb0a:
	jl_s.d [r3]
L_8edb0c:
	mov_s r2,0x1
L_8edb0e:
	pop_s blink
