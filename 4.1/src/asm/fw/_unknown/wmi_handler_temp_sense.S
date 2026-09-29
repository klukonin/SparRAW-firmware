/* wmi_handler_temp_sense @ 0x8e420c, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Temperature measurement command (mode=%d)
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, get_g_8000a0, get_g_80013c, l2mgr__send_temp_sense_done, temp_sense__get_cached
 */
	.section .text.wmi_handler_temp_sense,"ax",@progbits
	.global wmi_handler_temp_sense
wmi_handler_temp_sense:
	.global L_8e420c
L_8e420c:
	push_s blink
L_8e420e:
	bl L_8c02bc
L_8e4212:
	mov_s r16,r0
L_8e4214:
	mov_s r14,r1
L_8e4216:
	mov_s r2,0x1006070
L_8e421c:
	mov_s r0,0x0
L_8e421e:
	mov_s r1,0x2
L_8e4220:
	bl.d L_8edfcc
L_8e4224:
	ld_s r3,[r14,0x8]
L_8e4226:
	ld_s r0,[r14,0x8]
L_8e4228:
	breq r0,0x1,L_8e423a
L_8e422c:
	mov_s r0,0x210d8
L_8e4232:
	bl.d L_8d9e84
L_8e4236:
	mov_s r1,r16
L_8e4238:
	b_s L_8e4266
	.global L_8e423a
L_8e423a:
	ld_s r0,[r14]
L_8e423c:
	mov r15,-0x1
L_8e4240:
	cmp_s r0,0x0
L_8e4242:
	mov.eq r13,r15
L_8e4246:
	beq_s L_8e424e
L_8e4248:
	bl L_8c98a4
L_8e424c:
	mov_s r13,r0
	.global L_8e424e
L_8e424e:
	ld_s r0,[r14,0x4]
L_8e4250:
	cmp_s r0,0x0
L_8e4252:
	mov.eq r1,r15
L_8e4256:
	beq_s L_8e425e
L_8e4258:
	bl L_8ca7fc
L_8e425c:
	mov_s r1,r0
	.global L_8e425e
L_8e425e:
	mov_s r0,r13
L_8e4260:
	bl.d L_8e10d8
L_8e4264:
	mov_s r2,r16
	.global L_8e4266
L_8e4266:
	b L_8c0324
L_8e426a:
	nop_s
