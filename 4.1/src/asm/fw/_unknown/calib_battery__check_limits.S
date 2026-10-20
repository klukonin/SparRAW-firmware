/* calib_battery__check_limits @ 0x8d40c0, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_battery_phy_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_phy__read_status_pair
 * Глобалы (через gp): 0x8001ff
 */
	.section .text.calib_battery__check_limits,"ax",@progbits
	.global calib_battery__check_limits
calib_battery__check_limits:
	.global L_8d40c0
L_8d40c0:
	push_s blink
L_8d40c2:
	bl L_8c02c4
L_8d40c6:
	sub_s sp,sp,0x8
L_8d40c8:
	mov_s r13,r0
L_8d40ca:
	mov_s r14,r1
L_8d40cc:
	mov_s r0,0x0
L_8d40ce:
	stb_s r0,[r13,0x8]
L_8d40d0:
	stb_s r0,[r13,0x9]
L_8d40d2:
	bl.d L_8cf6f8
L_8d40d6:
	mov_s r0,sp
L_8d40d8:
	/* add_s r14,0x2 */
	.byte 0x02,0xe6
L_8d40da:
	mov_s r0,0x1d
L_8d40dc:
	ld_s r1,[sp,0x0]
L_8d40de:
	asl_s r0,r0,r14
L_8d40e0:
	abs_s r2,r1
L_8d40e2:
	brge r0,r2,L_8d40ea
L_8d40e6:
	mov_s r0,0x1
L_8d40e8:
	stb_s r0,[r13,0x8]
	.global L_8d40ea
L_8d40ea:
	ldb_s r0,[gp,0x8f]
L_8d40ec:
	asl_s r0,r0,r14
L_8d40ee:
	brge r2,r0,L_8d40f6
L_8d40f2:
	mov_s r0,0x1
L_8d40f4:
	stb_s r0,[r13,0x9]
	.global L_8d40f6
L_8d40f6:
	ld_s r0,[sp,0x4]
L_8d40f8:
	st_s r1,[r13]
L_8d40fa:
	st_s r0,[r13,0x4]
L_8d40fc:
	b.d L_8c0334
L_8d4100:
	add_s sp,sp,0x8
L_8d4102:
	nop_s
