/* sm_pring__by_index @ 0x8cca20, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__pcp_stop, sm_pring__connectivity_update, sm_pring__notify_vring_state
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_pring__by_index
sm_pring__by_index:
	.global L_8cca20
L_8cca20:
	mul64 r0,0x3c
L_8cca24:
	add r0,mlo,0x804de4
L_8cca2c:
	j_s [blink]
L_8cca2e:
	nop_s
