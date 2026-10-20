/* temp_sense__get_cached @ 0x8dddc0, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Temp sense is currently active - using old values
 * Зовут его: hwf_calib_all, lmac_if__lmac_ready_evt, wmi__cmd_arg_check
 * Зовёт сам: TEMPERATURE_SERVICE__timer_exp_handler, fw_log_emit0, temp__get_active_rf, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global temp_sense__get_cached
temp_sense__get_cached:
	.global L_8dddc0
L_8dddc0:
	push_s blink
L_8dddc2:
	ld.as r2,[gp,-0x37]
L_8dddc6:
	breq_s r2,0,L_8dddea
L_8dddc8:
	mov_s r1,0x1011e94
L_8dddce:
	bl.d L_8dcba8
L_8dddd2:
	mov_s r0,0x10
L_8dddd4:
	bl.d L_8ccbf4
L_8dddd8:
	mov_s r0,0x0
L_8dddda:
	mov_s r1,r0
L_8ddddc:
	ld.as r3,[gp,-0x37]
L_8ddde0:
	ld_s r0,[gp,-0xe0]
L_8ddde2:
	jl_s.d [r3]
L_8ddde4:
	ld.as r2,[gp,-0x36]
L_8ddde8:
	b_s L_8dde06
	.global L_8dddea
L_8dddea:
	st.as r0,[gp,-0x37]
L_8dddee:
	ld_s r0,[gp,-0x8]
L_8dddf0:
	st.as r1,[gp,-0x36]
L_8dddf4:
	breq_s r0,0,L_8dde00
L_8dddf6:
	bl L_8c8de0
L_8dddfa:
	mov_s r0,0x0
L_8dddfc:
	st.as r0,[gp,-0x2]
	.global L_8dde00
L_8dde00:
	bl.d L_8e9438
L_8dde04:
	mov_s r0,0x1
	.global L_8dde06
L_8dde06:
	pop_s blink
L_8dde08:
	j_s [blink]
L_8dde0a:
	nop_s
