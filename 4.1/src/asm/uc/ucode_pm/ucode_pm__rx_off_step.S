/* ucode_pm__rx_off_step @ 0x936cec, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ucode_pm.c
 * Зовут его: qset1_mask__any_pending
 * Зовёт сам: grant_detect_step, rfc_ctrl__switch, set_g_80058c, sxd_hal__read_backoff_status, uc_sysassert, uc_wait_two_events
 */
	.section .text.ucode_pm__rx_off_step,"ax",@progbits
	.global ucode_pm__rx_off_step
ucode_pm__rx_off_step:
	.global L_936cec
L_936cec:
	push_s blink
L_936cee:
	bl L_9377bc
L_936cf2:
	mov_s r0,0x3
L_936cf4:
	bl.d L_92b9d0
L_936cf8:
	mov_s r1,0xff
L_936cfa:
	mov_s r0,0x0
L_936cfc:
	mov_s r1,0x1
L_936cfe:
	bl.d L_92a558
L_936d02:
	mov_s r2,r1
L_936d04:
	bl L_936d40
L_936d08:
	mov_s r1,0x8009ec
L_936d0e:
	ld_s r0,[r1,0x4]
L_936d10:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_936d12:
	st_s r0,[r1,0x4]
L_936d14:
	mov_s r0,0x5
L_936d16:
	mov_s r1,r0
L_936d18:
	bl.d L_9316b4
L_936d1c:
	mov_s r2,0xa
L_936d1e:
	nop_s
L_936d20:
	nop_s
L_936d22:
	nop_s
L_936d24:
	mov_s r0,r42
L_936d26:
	bbit1 r0,0xe,L_936d3c
L_936d2a:
	mov_s r0,blink
L_936d2c:
	mov_s r2,0x1001ff8
L_936d32:
	mov_s r1,0x10
L_936d34:
	bl.d L_925548
L_936d38:
	mov r3,0x100
	.global L_936d3c
L_936d3c:
	pop_s blink
L_936d3e:
	j_s [blink]
