/* rgf_reg_88a200 @ 0x8d5130, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, power_halt_seq
 * Зовёт сам: hwd_abif__rgf_88ae00, hwm__apply_channel_config
 */
	.section .text.rgf_reg_88a200,"ax",@progbits
	.global rgf_reg_88a200
rgf_reg_88a200:
	.global L_8d5130
L_8d5130:
	cmp_s r0,0x1
L_8d5132:
	push_s blink
L_8d5134:
	mov_s r0,0x0
L_8d5136:
	bne_s L_8d5144
L_8d5138:
	bl L_8d508c
L_8d513c:
	bl.d L_8cb9a8
L_8d5140:
	mov_s r0,0x1
L_8d5142:
	b_s L_8d5160
	.global L_8d5144
L_8d5144:
	bl L_8cb9a8
L_8d5148:
	mov_s r1,0x88a200
L_8d514e:
	ld_s r0,[r1,0x4]
L_8d5150:
	or r0,r0,0x7e000
L_8d5158:
	st_s r0,[r1,0x4]
L_8d515a:
	bl.d L_8d508c
L_8d515e:
	mov_s r0,0x1
	.global L_8d5160
L_8d5160:
	pop_s blink
L_8d5162:
	j_s [blink]
