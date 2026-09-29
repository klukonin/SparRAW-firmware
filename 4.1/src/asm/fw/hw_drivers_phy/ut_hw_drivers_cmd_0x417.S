/* ut_hw_drivers_cmd_0x417 @ 0x8cfa40, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x417,"ax",@progbits
	.global ut_hw_drivers_cmd_0x417
ut_hw_drivers_cmd_0x417:
	.global L_8cfa40
L_8cfa40:
	push_s blink
L_8cfa42:
	push_s r13
L_8cfa44:
	mov_s r13,r0
L_8cfa46:
	bclr.f r0,r0,0x0
L_8cfa4a:
	bne_s L_8cfa5e
	.global L_8cfa4c
L_8cfa4c:
	mov_s r1,0x885180
L_8cfa52:
	ld_s r0,[r1,0x20]
L_8cfa54:
	bclr_s r0,r0,0x0
L_8cfa56:
	or_s r13,r13,r0
L_8cfa58:
	st_s r13,[r1,0x20]
L_8cfa5a:
	b L_8c033c
	.global L_8cfa5e
L_8cfa5e:
	mov_s r0,blink
L_8cfa60:
	mov_s r2,0x1018690
L_8cfa66:
	mov_s r1,0xac
L_8cfa68:
	bl.d L_8c82c0
L_8cfa6c:
	mov r3,0x25e
L_8cfa70:
	b_s L_8cfa4c
L_8cfa72:
	nop_s
