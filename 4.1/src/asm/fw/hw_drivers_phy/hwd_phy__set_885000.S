/* hwd_phy__set_885000 @ 0x8cf140, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, ut_hw_flows_cmd_0x407
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.hwd_phy__set_885000,"ax",@progbits
	.global hwd_phy__set_885000
hwd_phy__set_885000:
	.global L_8cf140
L_8cf140:
	push_s blink
L_8cf142:
	bl.d L_8c02c0
L_8cf146:
	mov_s r7,r1
L_8cf148:
	mov_s r6,r2
L_8cf14a:
	mov_s r2,0x1
L_8cf14c:
	mov_s r14,0x0
L_8cf14e:
	bset r14,r14,r5
L_8cf152:
	asr r1,r14,0x1f
L_8cf156:
	mov_s r15,0x885000
L_8cf15c:
	st_s r14,[r15,0x8]
L_8cf15e:
	st_s r1,[r15,0xc]
L_8cf160:
	st_s r2,[r15,0x4]
L_8cf162:
	asl_s r0,r0
L_8cf164:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cf166:
	asl r1,r7,0x4
L_8cf16a:
	add_s r1,r1,r0
L_8cf16c:
	asl r0,r6,0x5
L_8cf170:
	add_s r0,r0,r1
L_8cf172:
	asl_s r3,r3,0x8
L_8cf174:
	add_s r3,r3,r0
L_8cf176:
	asl r13,r4,0x14
L_8cf17a:
	add_s r13,r13,r3
L_8cf17c:
	st_s r13,[r15]
L_8cf17e:
	b L_8c032c
L_8cf182:
	nop_s
