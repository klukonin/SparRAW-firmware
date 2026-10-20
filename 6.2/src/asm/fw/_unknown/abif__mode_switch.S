/* abif__mode_switch @ 0x8d7bd0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, power_halt_seq
 * Зовёт сам: hwd_abif__caf_pwdn_mode, hwm__apply_channel_config
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global abif__mode_switch
abif__mode_switch:
	.global L_8d7bd0
L_8d7bd0:
	cmp_s r0,0x1
L_8d7bd2:
	push_s blink
L_8d7bd4:
	mov_s r0,0x0
L_8d7bd6:
	bne_s L_8d7be4
L_8d7bd8:
	bl L_8d7b2c
L_8d7bdc:
	bl.d L_8ce690
L_8d7be0:
	mov_s r0,0x1
L_8d7be2:
	b_s L_8d7c00
	.global L_8d7be4
L_8d7be4:
	bl L_8ce690
L_8d7be8:
	mov_s r1,0x88a200
L_8d7bee:
	ld_s r0,[r1,0x4]
L_8d7bf0:
	or r0,r0,0x7e000
L_8d7bf8:
	st_s r0,[r1,0x4]
L_8d7bfa:
	bl.d L_8d7b2c
L_8d7bfe:
	mov_s r0,0x1
	.global L_8d7c00
L_8d7c00:
	pop_s blink
L_8d7c02:
	j_s [blink]
