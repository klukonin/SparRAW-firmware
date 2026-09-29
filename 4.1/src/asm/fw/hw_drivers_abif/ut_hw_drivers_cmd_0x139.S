/* ut_hw_drivers_cmd_0x139 @ 0x8ccbd0, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x139,"ax",@progbits
	.global ut_hw_drivers_cmd_0x139
ut_hw_drivers_cmd_0x139:
	.global L_8ccbd0
L_8ccbd0:
	push_s blink
L_8ccbd2:
	bl L_8c02b4
L_8ccbd6:
	xor r17,r0,0x1e
L_8ccbda:
	bic.f 0x0,r17,0x3f
L_8ccbde:
	mov_s r18,r1
L_8ccbe0:
	mov_s r16,r2
L_8ccbe2:
	bne_s L_8ccc30
	.global L_8ccbe4
L_8ccbe4:
	xor r18,r18,0x12
L_8ccbe8:
	bic.f 0x0,r18,0x3f
L_8ccbec:
	bne_s L_8ccc44
	.global L_8ccbee
L_8ccbee:
	xor r16,r16,0x34
L_8ccbf2:
	bic.f 0x0,r16,0x3f
L_8ccbf6:
	bne_s L_8ccc58
	.global L_8ccbf8
L_8ccbf8:
	mov_s r2,0x889300
L_8ccbfe:
	ld_s r3,[r2,0x64]
L_8ccc00:
	asl r1,r17,0x8
L_8ccc04:
	mov_s r0,0xffc0ffff
L_8ccc0a:
	mov_s r13,0xffc0c0ff
L_8ccc10:
	and_s r3,r3,r13
L_8ccc12:
	and_s r0,r0,r1
L_8ccc14:
	or_s r0,r0,r3
L_8ccc16:
	asl r1,r18,0x10
L_8ccc1a:
	or_s r1,r1,r0
L_8ccc1c:
	and r1,r1,0xc0ffffff
L_8ccc24:
	asl r0,r16,0x18
L_8ccc28:
	or_s r0,r0,r1
L_8ccc2a:
	st_s r0,[r2,0x64]
L_8ccc2c:
	b L_8c0314
	.global L_8ccc30
L_8ccc30:
	mov_s r0,blink
L_8ccc32:
	mov_s r2,0x1019954
L_8ccc38:
	mov_s r1,0xaf
L_8ccc3a:
	bl.d L_8c82c0
L_8ccc3e:
	mov r3,0x722
L_8ccc42:
	b_s L_8ccbe4
	.global L_8ccc44
L_8ccc44:
	mov_s r0,blink
L_8ccc46:
	mov_s r2,0x1019954
L_8ccc4c:
	mov_s r1,0xb0
L_8ccc4e:
	bl.d L_8c82c0
L_8ccc52:
	mov r3,0x722
L_8ccc56:
	b_s L_8ccbee
	.global L_8ccc58
L_8ccc58:
	mov_s r0,blink
L_8ccc5a:
	mov_s r2,0x1019954
L_8ccc60:
	mov_s r1,0xb1
L_8ccc62:
	bl.d L_8c82c0
L_8ccc66:
	mov r3,0x722
L_8ccc6a:
	b_s L_8ccbf8
