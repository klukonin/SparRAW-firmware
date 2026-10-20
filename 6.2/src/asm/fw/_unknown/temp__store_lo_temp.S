/* temp__store_lo_temp @ 0x8e21f0, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TEMPERATURE_SERVICE__timer_exp_handler
 * Зовёт сам: hwf__rf_lo_setup
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global temp__store_lo_temp
temp__store_lo_temp:
	.global L_8e21f0
L_8e21f0:
	push_s blink
L_8e21f2:
	bl L_8d4978
L_8e21f6:
	mov r2,0x3e8
L_8e21fa:
	asr r1,r0,0x8
L_8e21fe:
	mul64_s r1,r2
L_8e2200:
	extb_s r0,r0
L_8e2202:
	mov_s r1,mlo
L_8e2204:
	mul64_s r0,r2
L_8e2206:
	asr r0,mlo,0x8
L_8e220a:
	add_s r0,r0,r1
L_8e220c:
	mov_s r1,0x853800
L_8e2212:
	st.as r0,[gp,-0x38]
L_8e2216:
	st_s r0,[r1,0x8]
L_8e2218:
	pop_s blink
L_8e221a:
	j_s [blink]
