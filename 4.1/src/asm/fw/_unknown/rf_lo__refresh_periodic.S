/* rf_lo__refresh_periodic @ 0x8ddd7c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: timer_exp_handler
 * Зовёт сам: hwf__rf_lo_setup
 */
	.section .text.rf_lo__refresh_periodic,"ax",@progbits
	.global rf_lo__refresh_periodic
rf_lo__refresh_periodic:
	.global L_8ddd7c
L_8ddd7c:
	push_s blink
L_8ddd7e:
	bl L_8d190c
L_8ddd82:
	mov r2,0x3e8
L_8ddd86:
	asr r1,r0,0x8
L_8ddd8a:
	mul64_s r1,r2
L_8ddd8c:
	extb_s r0,r0
L_8ddd8e:
	mov_s r1,mlo
L_8ddd90:
	mul64_s r0,r2
L_8ddd92:
	asr r0,mlo,0x8
L_8ddd96:
	add_s r0,r0,r1
L_8ddd98:
	mov_s r1,0x854800
L_8ddd9e:
	st.as r0,[gp,-0x34]
L_8ddda2:
	st_s r0,[r1,0x8]
L_8ddda4:
	pop_s blink
L_8ddda6:
	j_s [blink]
