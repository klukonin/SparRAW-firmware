/* chan_sw__set_active_channel @ 0x8e639c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__init_all, channels_switch_sm__switch_to_channel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global chan_sw__set_active_channel
chan_sw__set_active_channel:
	.global L_8e639c
L_8e639c:
	j_s.d [blink]
L_8e639e:
	st.as r0,[gp,-0x31]
L_8e63a2:
	nop_s
