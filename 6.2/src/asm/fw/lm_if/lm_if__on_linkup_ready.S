/* lm_if__on_linkup_ready @ 0x8dae84, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_main_sm__action_8c475c
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_sysassert_fatal, hw__is_fpga_platform, lm__notify_linkup, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_if__on_linkup_ready
lm_if__on_linkup_ready:
	.global L_8dae84
L_8dae84:
	push_s blink
L_8dae86:
	push_s r13
L_8dae88:
	bl.d L_8da2c8
L_8dae8c:
	mov_s r13,r0
L_8dae8e:
	breq_s r0,0,L_8dae9a
L_8dae90:
	mov_s r0,r13
L_8dae92:
	bl.d L_8dae74
L_8dae96:
	mov_s r1,0x0
L_8dae98:
	b_s L_8daed2
	.global L_8dae9a
L_8dae9a:
	ld_s r0,[r13]
L_8dae9c:
	breq_s r0,0,L_8daeb8
	.global L_8dae9e
L_8dae9e:
	bl L_8e9524
L_8daea2:
	ld_s r2,[r13,0x8]
L_8daea4:
	sub r1,r0,r2
L_8daea8:
	cmp r1,0x7d0
L_8daeac:
	ld_s r0,[r13]
L_8daeae:
	bhs_s L_8daec6
L_8daeb0:
	add r2,r13,0xc
L_8daeb4:
	mov_s r1,0x0
L_8daeb6:
	b_s L_8daeca
	.global L_8daeb8
L_8daeb8:
	mov_s r0,blink
L_8daeba:
	mov_s r1,0x125f
L_8daec0:
	bl L_8c9b28
L_8daec4:
	b_s L_8dae9e
	.global L_8daec6
L_8daec6:
	mov_s r1,0x0
L_8daec8:
	mov_s r2,r1
	.global L_8daeca
L_8daeca:
	mov_s r3,0x0
L_8daecc:
	bl.d L_8d9b6c
L_8daed0:
	mov_s r4,r3
	.global L_8daed2
L_8daed2:
	b L_8c025c
L_8daed6:
	nop_s
