/* rf_kill__set_flag @ 0x8f2948, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_kill_sm__on_w_disable__disabled, rf_kill_sm__on_w_disable__enabled, rf_kill_sm__on_w_disable__pending_disabled, rf_kill_sm__on_w_enable__disabled, rf_kill_sm__on_w_enable__enabled
 * Глобалы (через gp): 0x800180, 0x800184
 */
	.section .text.rf_kill__set_flag,"ax",@progbits
	.global rf_kill__set_flag
rf_kill__set_flag:
	.global L_8f2948
L_8f2948:
	cmp_s r0,0x1
L_8f294a:
	mov_s r0,0x1
L_8f294c:
	sub_s.ne r0,r0,r0
L_8f294e:
	brne_s r1,0,L_8f2956
L_8f2950:
	st.as r0,[gp,0x4]
L_8f2954:
	b_s L_8f295a
	.global L_8f2956
L_8f2956:
	st.as r0,[gp,0x5]
	.global L_8f295a
L_8f295a:
	j_s [blink]
