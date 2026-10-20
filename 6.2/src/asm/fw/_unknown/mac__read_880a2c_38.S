/* mac__read_880a2c_38 @ 0x8f3570, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bootloader_version__log, wmi_fw_ver
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__read_880a2c_38
mac__read_880a2c_38:
	.global L_8f3570
L_8f3570:
	push_s r13
L_8f3572:
	breq_s r3,0,L_8f357e
L_8f3574:
	mov_s r13,0x880a00
L_8f357a:
	ld_s r13,[r13,0x38]
L_8f357c:
	st_s r13,[r3]
	.global L_8f357e
L_8f357e:
	breq_s r2,0,L_8f358a
L_8f3580:
	mov_s r3,0x880a00
L_8f3586:
	ld_s r3,[r3,0x34]
L_8f3588:
	st_s r3,[r2]
	.global L_8f358a
L_8f358a:
	breq_s r1,0,L_8f3596
L_8f358c:
	mov_s r2,0x880a00
L_8f3592:
	ld_s r2,[r2,0x30]
L_8f3594:
	st_s r2,[r1]
	.global L_8f3596
L_8f3596:
	breq_s r0,0,L_8f35a2
L_8f3598:
	mov_s r1,0x880a00
L_8f359e:
	ld_s r1,[r1,0x2c]
L_8f35a0:
	st_s r1,[r0]
	.global L_8f35a2
L_8f35a2:
	j_s.d [blink]
L_8f35a4:
	pop_s r13
L_8f35a6:
	nop_s
