/* flash_cfg__set_bb_sensor_calib @ 0x8e62fc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__load_from_flash
 * Глобалы (через gp): 0x80020e, 0x800210
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global flash_cfg__set_bb_sensor_calib
flash_cfg__set_bb_sensor_calib:
	.global L_8e62fc
L_8e62fc:
	stw.as r0,[gp,0x45]
L_8e6300:
	j_s.d [blink]
L_8e6302:
	stw.as r1,[gp,0x46]
L_8e6306:
	nop_s
