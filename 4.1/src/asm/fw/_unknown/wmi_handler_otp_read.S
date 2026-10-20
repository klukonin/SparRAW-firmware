/* wmi_handler_otp_read @ 0x8dde58, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   read size is outside of otp boundaries!
 *   OTP read failed!
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit0, otp__read_bytes
 */
	.section .text.wmi_handler_otp_read,"ax",@progbits
	.global wmi_handler_otp_read
wmi_handler_otp_read:
	.global L_8dde58
L_8dde58:
	push_s blink
L_8dde5a:
	bl L_8c02b8
L_8dde5e:
	mov_s r16,r0
L_8dde60:
	mov_s r14,r1
L_8dde62:
	mov_s r13,r2
L_8dde64:
	add_s r0,r2,r1
L_8dde66:
	cmp_s r0,0x2000
L_8dde6c:
	mov_s r17,r3
L_8dde6e:
	bls_s L_8dde80
L_8dde70:
	mov_s r2,0x1005fc0
	.global L_8dde76
L_8dde76:
	mov_s r0,0x0
L_8dde78:
	bl.d L_8edfb0
L_8dde7c:
	mov_s r1,r0
L_8dde7e:
	b_s L_8ddec8
	.global L_8dde80
L_8dde80:
	bl.d L_8c2c38
L_8dde84:
	mov_s r0,r16
L_8dde86:
	mov_s r15,r0
L_8dde88:
	mov_s r0,0x803e84
L_8dde8e:
	mov_s r1,0x0
L_8dde90:
	mov_s r2,r14
L_8dde92:
	mov_s r3,r13
L_8dde94:
	bl.d L_8f397c
L_8dde98:
	mov_s r4,r15
L_8dde9a:
	brne_s r0,0,L_8ddea4
L_8dde9c:
	mov_s r2,0x1005fe8
L_8ddea2:
	b_s L_8dde76
	.global L_8ddea4
L_8ddea4:
	add r4,r13,0x1
L_8ddea8:
	extw r4,r4
L_8ddeac:
	mov_s r0,r16
L_8ddeae:
	mov_s r1,r15
L_8ddeb0:
	mov_s r2,0x0
L_8ddeb2:
	mov_s r3,0x1856
L_8ddeb8:
	mov r5,r17
L_8ddebc:
	mov r6,0x0
L_8ddec0:
	bl.d L_8e0460
L_8ddec4:
	mov r7,0x0
	.global L_8ddec8
L_8ddec8:
	b L_8c031c
