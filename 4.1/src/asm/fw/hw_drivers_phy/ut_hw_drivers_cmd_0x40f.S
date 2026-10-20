/* ut_hw_drivers_cmd_0x40f @ 0x8d00f0, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x40f,"ax",@progbits
	.global ut_hw_drivers_cmd_0x40f
ut_hw_drivers_cmd_0x40f:
	.global L_8d00f0
L_8d00f0:
	push_s blink
L_8d00f2:
	bl L_8c02bc
L_8d00f6:
	mov_s r15,r1
L_8d00f8:
	mov_s r16,r2
L_8d00fa:
	mov_s r14,0x884100
L_8d0100:
	mov r13,-0x400
L_8d0104:
	breq_s r0,0,L_8d0154
L_8d0106:
	mov_s r0,0x0
L_8d0108:
	st_s r0,[r14,0x3c]
L_8d010a:
	tst_s r15,r13
L_8d010c:
	bne_s L_8d012c
	.global L_8d010e
L_8d010e:
	tst r16,r13
L_8d0112:
	bne_s L_8d0140
	.global L_8d0114
L_8d0114:
	ld_s r1,[r14,0x38]
L_8d0116:
	mov_s r0,0xfc00ffff
L_8d011c:
	and_s r13,r13,r1
L_8d011e:
	and_s r13,r13,r0
L_8d0120:
	and_s r15,r15,r0
L_8d0122:
	or_s r15,r15,r13
L_8d0124:
	asl r0,r16,0x10
L_8d0128:
	or_s r0,r0,r15
L_8d012a:
	b_s L_8d0162
	.global L_8d012c
L_8d012c:
	mov_s r0,blink
L_8d012e:
	mov_s r2,0x1018690
L_8d0134:
	mov_s r1,0xad
L_8d0136:
	bl.d L_8c82c0
L_8d013a:
	mov r3,0x1b1
L_8d013e:
	b_s L_8d010e
	.global L_8d0140
L_8d0140:
	mov_s r0,blink
L_8d0142:
	mov_s r2,0x1018690
L_8d0148:
	mov_s r1,0xae
L_8d014a:
	bl.d L_8c82c0
L_8d014e:
	mov r3,0x1b1
L_8d0152:
	b_s L_8d0114
	.global L_8d0154
L_8d0154:
	mov_s r0,0x1
L_8d0156:
	st_s r0,[r14,0x3c]
L_8d0158:
	ld_s r0,[r14,0x38]
L_8d015a:
	and r0,r0,0xfc00fc00
	.global L_8d0162
L_8d0162:
	st_s r0,[r14,0x38]
L_8d0164:
	b L_8c0324
