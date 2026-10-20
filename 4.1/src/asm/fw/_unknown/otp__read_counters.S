/* otp__read_counters @ 0x8ee968, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: otp__log_params
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, xpm_read_cnt
 */
	.section .text.otp__read_counters,"ax",@progbits
	.global otp__read_counters
otp__read_counters:
	.global L_8ee968
L_8ee968:
	push_s blink
L_8ee96a:
	bl L_8c02c0
L_8ee96e:
	mov_s r15,r0
L_8ee970:
	mov_s r14,0x0
L_8ee972:
	mov_s r13,0x8
	.global L_8ee974
L_8ee974:
	mov_s r0,0x803e84
L_8ee97a:
	asl_s r2,r14,0x3
L_8ee97c:
	bl.d L_8f39d0
L_8ee980:
	ldb_s r1,[r0]
L_8ee982:
	add_s r12,r15,r14
L_8ee984:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8ee986:
	stb_s r0,[r12]
L_8ee988:
	/* brhs.d r13,0x1,0x008ee974 */
	.byte 0xed,0x0d,0x75,0x90
L_8ee98c:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8ee98e:
	b L_8c032c
L_8ee992:
	nop_s
