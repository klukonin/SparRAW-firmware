/* hwd_phy__get_883100 @ 0x8cfc1c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, phy__report_gain_to_ucode
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, hwd_phy__set_883000
 */
	.section .text.hwd_phy__get_883100,"ax",@progbits
	.global hwd_phy__get_883100
hwd_phy__get_883100:
	.global L_8cfc1c
L_8cfc1c:
	push_s blink
L_8cfc1e:
	bl.d L_8c02c0
L_8cfc22:
	add_s r1,r1,r0
L_8cfc24:
	mov_s r14,0x883100
L_8cfc2a:
	ld_s r14,[r14,0x38]
L_8cfc2c:
	add_s r2,r2,r0
L_8cfc2e:
	bmsk_s r14,r14,0x5
L_8cfc30:
	cmp_s r1,r14
L_8cfc32:
	mov.cc r15,r14
L_8cfc36:
	mov.cs r15,r1
L_8cfc3a:
	cmp_s r2,r14
L_8cfc3c:
	mov.cc r1,r14
L_8cfc40:
	mov.cs r1,r2
L_8cfc44:
	add_s r3,r3,r0
L_8cfc46:
	cmp_s r3,r14
L_8cfc48:
	mov.cc r3,r14
L_8cfc4c:
	add r13,r4,r0
L_8cfc50:
	cmp_s r13,r14
L_8cfc52:
	mov.cc r13,r14
L_8cfc56:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8cfc58:
	or_s r1,r1,r15
L_8cfc5a:
	asl_s r3,r3,0xc
L_8cfc5c:
	or_s r3,r3,r1
L_8cfc5e:
	asl_s r13,r13,0x12
L_8cfc60:
	bl.d L_8cfc70
L_8cfc64:
	or r1,r13,r3
L_8cfc68:
	b.d L_8c032c
L_8cfc6c:
	or r0,r13,r3
