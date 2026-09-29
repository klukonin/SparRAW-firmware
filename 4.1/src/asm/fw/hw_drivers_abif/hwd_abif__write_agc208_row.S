/* hwd_abif__write_agc208_row @ 0x8cca2c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__write_agc208_row,"ax",@progbits
	.global hwd_abif__write_agc208_row
hwd_abif__write_agc208_row:
	.global L_8cca2c
L_8cca2c:
	push_s blink
L_8cca2e:
	bl L_8c02c4
L_8cca32:
	cmp_s r0,0x40
L_8cca34:
	mov_s r13,r0
L_8cca36:
	mov_s r14,r1
L_8cca38:
	bge_s L_8cca5e
	.global L_8cca3a
L_8cca3a:
	mov lp_count,0x3
L_8cca3e:
	mov_s r1,0x0
L_8cca40:
	lp L_8cca5a
L_8cca44:
	add2 r3,r1,r13
L_8cca48:
	ld.as r2,[r14,r1]
L_8cca4c:
	mov_s r0,0x88a208
L_8cca52:
	add2_s r0,r0,r3
L_8cca54:
	st_s r2,[r0]
L_8cca56:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8cca58:
	extb_s r1,r1
	.global L_8cca5a
L_8cca5a:
	b L_8c0334
	.global L_8cca5e
L_8cca5e:
	mov_s r0,blink
L_8cca60:
	mov_s r2,0x1019954
L_8cca66:
	mov_s r1,0x12e3
L_8cca6c:
	bl.d L_8c82c0
L_8cca70:
	mov r3,0x44d
L_8cca74:
	b_s L_8cca3a
L_8cca76:
	nop_s
