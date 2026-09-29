/* hwd_abif__fs_off @ 0x8cea04, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__program_rf_clocks, hwm_analog_channel_switch, init_rf_hw
 * Зовёт сам: abif__mask_fs_unlock_irq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__fs_off
hwd_abif__fs_off:
	.global L_8cea04
L_8cea04:
	push_s blink
L_8cea06:
	bl L_8d00e8
L_8cea0a:
	mov_s r2,0x889400
L_8cea10:
	ld_s r0,[r2,0x1c]
L_8cea12:
	mov_s r1,0x889800
L_8cea18:
	bic r0,r0,0x3
L_8cea1c:
	st_s r0,[r2,0x1c]
L_8cea1e:
	ld_s r0,[r2,0x1c]
L_8cea20:
	bset_s r0,r0,0x4
L_8cea22:
	st_s r0,[r2,0x1c]
L_8cea24:
	ld.as r0,[r1,-0xd7]
L_8cea28:
	bic r0,r0,0x7c0
L_8cea2c:
	bset_s r0,r0,0xa
L_8cea2e:
	st.as r0,[r1,-0xd7]
L_8cea32:
	pop_s blink
L_8cea34:
	j_s [blink]
L_8cea36:
	nop_s
