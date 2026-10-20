/* ut_hw_drivers_cmd_0x40d @ 0x8d0168, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x40d,"ax",@progbits
	.global ut_hw_drivers_cmd_0x40d
ut_hw_drivers_cmd_0x40d:
	.global L_8d0168
L_8d0168:
	push_s blink
L_8d016a:
	bl L_8c02b8
L_8d016e:
	mov_s r13,r1
L_8d0170:
	mov_s r16,r2
L_8d0172:
	mov r17,-0x400
L_8d0176:
	breq_s r0,0,L_8d01d0
L_8d0178:
	tst r13,r17
L_8d017c:
	bne_s L_8d01a8
	.global L_8d017e
L_8d017e:
	tst r16,r17
L_8d0182:
	bne_s L_8d01bc
	.global L_8d0184
L_8d0184:
	mov_s r0,0x884000
L_8d018a:
	ld_s r3,[r0,0x24]
L_8d018c:
	mov_s r1,0xfc00ffff
L_8d0192:
	mov_s r2,0xec00fc00
L_8d0198:
	and_s r2,r2,r3
L_8d019a:
	and_s r13,r13,r1
L_8d019c:
	or_s r13,r13,r2
L_8d019e:
	asl r1,r16,0x10
L_8d01a2:
	or_s r1,r1,r13
L_8d01a4:
	st_s r1,[r0,0x24]
L_8d01a6:
	b_s L_8d01e4
	.global L_8d01a8
L_8d01a8:
	mov_s r0,blink
L_8d01aa:
	mov_s r2,0x1018690
L_8d01b0:
	mov_s r1,0xb0
L_8d01b2:
	bl.d L_8c82c0
L_8d01b6:
	mov r3,0x184
L_8d01ba:
	b_s L_8d017e
	.global L_8d01bc
L_8d01bc:
	mov_s r0,blink
L_8d01be:
	mov_s r2,0x1018690
L_8d01c4:
	mov_s r1,0xb1
L_8d01c6:
	bl.d L_8c82c0
L_8d01ca:
	mov r3,0x184
L_8d01ce:
	b_s L_8d0184
	.global L_8d01d0
L_8d01d0:
	mov_s r1,0x884000
L_8d01d6:
	ld_s r0,[r1,0x24]
L_8d01d8:
	and r0,r0,0xec00fc00
L_8d01e0:
	bset_s r0,r0,0x1c
L_8d01e2:
	st_s r0,[r1,0x24]
	.global L_8d01e4
L_8d01e4:
	b L_8c031c
