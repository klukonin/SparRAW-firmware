/* hw_modes__program_rf_clocks @ 0x8d7c3c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, power_halt_seq
 * Зовёт сам: hwd__program_889_group, hwd_abif__fs_off, hwd_abif__fs_on, hwd_abif__uses_rgf_889480_8ced4c, radio__get_channel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_modes__program_rf_clocks
hw_modes__program_rf_clocks:
	.global L_8d7c3c
L_8d7c3c:
	cmp_s r0,0x1
L_8d7c3e:
	push_s blink
L_8d7c40:
	mov_s r0,0x0
L_8d7c42:
	bne_s L_8d7c54
L_8d7c44:
	bl L_8d31dc
L_8d7c48:
	bl L_8cea04
L_8d7c4c:
	bl.d L_8ced4c
L_8d7c50:
	mov_s r0,0x1
L_8d7c52:
	b_s L_8d7c6c
	.global L_8d7c54
L_8d7c54:
	bl L_8ced4c
L_8d7c58:
	mov_s r0,0x8042c8
L_8d7c5e:
	bl L_8cc13c
L_8d7c62:
	bl L_8cea38
L_8d7c66:
	bl.d L_8d31dc
L_8d7c6a:
	mov_s r0,0x1
	.global L_8d7c6c
L_8d7c6c:
	pop_s blink
L_8d7c6e:
	j_s [blink]
