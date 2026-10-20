/* temp_sense__no_rf @ 0x8ddf70, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   No temperature measurment - NO RF on current platform!!!
 * Зовут его: temp_service__sample_without_rf
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fr_clr_mdm_crc_statistics, fw_log__emit0, rf__is_present, temp_measure_step
 */
	.section .text.temp_sense__no_rf,"ax",@progbits
	.global temp_sense__no_rf
temp_sense__no_rf:
	.global L_8ddf70
L_8ddf70:
	push_s blink
L_8ddf72:
	bl L_8c02c4
L_8ddf76:
	mov_s r14,r0
L_8ddf78:
	bl.d L_8d750c
L_8ddf7c:
	mov r13,-0x1
L_8ddf80:
	brne_s r0,0,L_8ddf94
L_8ddf82:
	mov_s r2,0x10053f8
L_8ddf88:
	mov_s r0,0x0
L_8ddf8a:
	bl.d L_8edfb0
L_8ddf8e:
	mov_s r1,0x1
L_8ddf90:
	mov_s r0,r13
L_8ddf92:
	b_s L_8ddfa0
	.global L_8ddf94
L_8ddf94:
	bl.d L_8c9220
L_8ddf98:
	mov_s r0,r14
L_8ddf9a:
	bl.d L_8ddda8
L_8ddf9e:
	mov_s r0,r14
	.global L_8ddfa0
L_8ddfa0:
	b L_8c0334
