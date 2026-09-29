/* hwd_phy__self_digital_loopback @ 0x8d2b0c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__self_digital_loopback
hwd_phy__self_digital_loopback:
	.global L_8d2b0c
L_8d2b0c:
	push_s blink
L_8d2b0e:
	push_s r13
L_8d2b10:
	mov_s r13,r0
L_8d2b12:
	bclr.f r0,r0,0x0
L_8d2b16:
	bne_s L_8d2b2c
	.global L_8d2b18
L_8d2b18:
	mov_s r1,0x883000
L_8d2b1e:
	ld_s r0,[r1,0x10]
L_8d2b20:
	asl_s r13,r13
L_8d2b22:
	bclr_s r0,r0,0x1
L_8d2b24:
	or_s r13,r13,r0
L_8d2b26:
	st_s r13,[r1,0x10]
L_8d2b28:
	b L_8c025c
	.global L_8d2b2c
L_8d2b2c:
	mov_s r0,blink
L_8d2b2e:
	bl.d L_8c9b28
L_8d2b32:
	mov_s r1,0xac
L_8d2b34:
	b_s L_8d2b18
L_8d2b36:
	nop_s
