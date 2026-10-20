/* temp_service__sample_without_rf @ 0x8ddfa4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TEMPERATURE_SERVICE__radio_locked_cb
 * Зовёт сам: temp_sense__no_rf
 */
	.section .text.temp_service__sample_without_rf,"ax",@progbits
	.global temp_service__sample_without_rf
temp_service__sample_without_rf:
	.global L_8ddfa4
L_8ddfa4:
	push_s blink
L_8ddfa6:
	mov_s r0,0x803e84
L_8ddfac:
	bl L_8ddf70
L_8ddfb0:
	mov_s r1,0x854800
L_8ddfb6:
	st.as r0,[gp,-0xd]
L_8ddfba:
	st_s r0,[r1,0xc]
L_8ddfbc:
	pop_s blink
L_8ddfbe:
	j_s [blink]
