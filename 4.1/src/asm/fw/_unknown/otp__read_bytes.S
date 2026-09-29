/* otp__read_bytes @ 0x8f397c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   read size is outside of otp boundaries!
 * Зовут его: wmi_handler_otp_read
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit0, xpm_read_cnt
 */
	.section .text.otp__read_bytes,"ax",@progbits
	.global otp__read_bytes
otp__read_bytes:
	.global L_8f397c
L_8f397c:
	push_s blink
L_8f397e:
	bl L_8c02b8
L_8f3982:
	mov_s r16,r0
L_8f3984:
	mov_s r15,r2
L_8f3986:
	add_s r0,r3,r2
L_8f3988:
	cmp_s r0,0x2000
L_8f398e:
	mov r17,r4
L_8f3992:
	bls_s L_8f39a6
L_8f3994:
	mov_s r2,0x1005320
L_8f399a:
	mov_s r0,0x0
L_8f399c:
	bl.d L_8edfb0
L_8f39a0:
	mov_s r1,0x0
L_8f39a2:
	mov_s r0,0x0
L_8f39a4:
	b_s L_8f39ca
	.global L_8f39a6
L_8f39a6:
	brlo.d r3,0x1,L_8f39c8
L_8f39aa:
	mov_s r14,0x0
L_8f39ac:
	mov_s r13,r3
	.global L_8f39ae
L_8f39ae:
	add3 r2,r15,r14
L_8f39b2:
	mov_s r0,r16
L_8f39b4:
	bl.d L_8f39d0
L_8f39b8:
	mov_s r1,0x0
L_8f39ba:
	add r12,r17,r14
L_8f39be:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8f39c0:
	stb_s r0,[r12]
L_8f39c2:
	/* brhs.d r13,0x1,0x008f39ae */
	.byte 0xef,0x0d,0x75,0x90
L_8f39c6:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8f39c8
L_8f39c8:
	mov_s r0,0x1
	.global L_8f39ca
L_8f39ca:
	b L_8c031c
L_8f39ce:
	nop_s
