/* hwd_phy__tx_play_buffer_stop @ 0x8d2e18, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__tx_play_buffer_stop
hwd_phy__tx_play_buffer_stop:
	.global L_8d2e18
L_8d2e18:
	mov_s r1,0x884000
L_8d2e1e:
	ld_s r0,[r1,0x8]
L_8d2e20:
	bclr_s r0,r0,0x0
L_8d2e22:
	st_s r0,[r1,0x8]
L_8d2e24:
	mov_s r1,0x880180
L_8d2e2a:
	ld_s r0,[r1,0x60]
L_8d2e2c:
	bic r0,r0,0x1c0
L_8d2e30:
	st_s r0,[r1,0x60]
L_8d2e32:
	mov_s r1,0x884100
L_8d2e38:
	ld_s r0,[r1,0x40]
L_8d2e3a:
	bclr_s r0,r0,0x0
L_8d2e3c:
	st_s r0,[r1,0x40]
L_8d2e3e:
	ld_s r0,[r1,0x48]
L_8d2e40:
	mov_s r0,0x1
L_8d2e42:
	st_s r0,[r1,0x48]
L_8d2e44:
	j_s [blink]
L_8d2e46:
	nop_s
