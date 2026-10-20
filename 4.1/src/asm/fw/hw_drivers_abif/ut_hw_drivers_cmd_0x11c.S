/* ut_hw_drivers_cmd_0x11c @ 0x8cc140, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x11c,"ax",@progbits
	.global ut_hw_drivers_cmd_0x11c
ut_hw_drivers_cmd_0x11c:
	.global L_8cc140
L_8cc140:
	push_s blink
L_8cc142:
	bl L_8c02bc
L_8cc146:
	cmp_s r0,0x40
L_8cc148:
	mov_s r13,r0
L_8cc14a:
	mov_s r16,r1
L_8cc14c:
	bge_s L_8cc170
	.global L_8cc14e
L_8cc14e:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cc150:
	/* add_s r13,0x3 */
	.byte 0x03,0xe5
L_8cc152:
	mov_s r0,0x88a208
L_8cc158:
	add2_s r0,r0,r13
L_8cc15a:
	ld_s r1,[r0]
L_8cc15c:
	asl r14,r16,0xc
L_8cc160:
	and r1,r1,0xfffe0fff
L_8cc168:
	or_s r14,r14,r1
L_8cc16a:
	st_s r14,[r0]
L_8cc16c:
	b L_8c0324
	.global L_8cc170
L_8cc170:
	mov_s r0,blink
L_8cc172:
	mov_s r2,0x1019954
L_8cc178:
	mov_s r1,0xff
L_8cc17a:
	bset_s r1,r1,0xc
L_8cc17c:
	bl.d L_8c82c0
L_8cc180:
	mov r3,0x614
L_8cc184:
	b_s L_8cc14e
L_8cc186:
	nop_s
