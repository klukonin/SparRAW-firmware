/* ut_hw_drivers_cmd_0x12d @ 0x8cbe14, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x12d,"ax",@progbits
	.global ut_hw_drivers_cmd_0x12d
ut_hw_drivers_cmd_0x12d:
	.global L_8cbe14
L_8cbe14:
	push_s blink
L_8cbe16:
	push_s r13
L_8cbe18:
	mov_s r13,r0
L_8cbe1a:
	bic.f r0,r0,0xff
L_8cbe1e:
	bne_s L_8cbe36
	.global L_8cbe20
L_8cbe20:
	mov_s r1,0x88ae00
L_8cbe26:
	ld_s r0,[r1,0x60]
L_8cbe28:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cbe2a:
	bic r0,r0,0x3fc
L_8cbe2e:
	or_s r13,r13,r0
L_8cbe30:
	st_s r13,[r1,0x60]
L_8cbe32:
	b L_8c033c
	.global L_8cbe36
L_8cbe36:
	mov_s r0,blink
L_8cbe38:
	mov_s r2,0x1019954
L_8cbe3e:
	mov_s r1,0xac
L_8cbe40:
	bl.d L_8c82c0
L_8cbe44:
	mov r3,0x22a
L_8cbe48:
	b_s L_8cbe20
L_8cbe4a:
	nop_s
