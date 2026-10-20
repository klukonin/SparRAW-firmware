/* wmi_handler_otp_write @ 0x8e7fdc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   OTP write failed!
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, otp__write_bytes
 */
	.section .text.wmi_handler_otp_write,"ax",@progbits
	.global wmi_handler_otp_write
wmi_handler_otp_write:
	.global L_8e7fdc
L_8e7fdc:
	push_s blink
L_8e7fde:
	push_s r13
L_8e7fe0:
	mov_s r13,r1
L_8e7fe2:
	mov_s r4,r2
L_8e7fe4:
	mov_s r0,0x803e84
L_8e7fea:
	mov_s r1,0x0
L_8e7fec:
	bl.d L_8f3a40
L_8e7ff0:
	mov_s r2,r13
L_8e7ff2:
	brne_s r0,0,L_8e8002
L_8e7ff4:
	mov_s r2,0x1005ffc
L_8e7ffa:
	mov_s r0,0x0
L_8e7ffc:
	bl.d L_8edfb0
L_8e8000:
	mov_s r1,0x0
	.global L_8e8002
L_8e8002:
	b L_8c033c
L_8e8006:
	nop_s
