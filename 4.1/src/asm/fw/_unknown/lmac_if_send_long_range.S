/* lmac_if_send_long_range @ 0x8e7e00, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.lmac_if_send_long_range,"ax",@progbits
	.global lmac_if_send_long_range
lmac_if_send_long_range:
	.global L_8e7e00
L_8e7e00:
	push_s blink
L_8e7e02:
	bl.d L_8c02c0
L_8e7e06:
	mov_s r1,0x1
L_8e7e08:
	mov_s r14,r0
L_8e7e0a:
	mov_s r15,r2
L_8e7e0c:
	mov_s r0,0x857280
L_8e7e12:
	bl.d L_8c2b0c
L_8e7e16:
	st_s r1,[r0,0x18]
L_8e7e18:
	mov_s r1,0x41
L_8e7e1a:
	mov_s r2,0x4
L_8e7e1c:
	mov_s r13,0x0
L_8e7e1e:
	bl.d L_8e0694
L_8e7e22:
	mov_s r3,r13
L_8e7e24:
	bl.d L_8c2c38
L_8e7e28:
	mov_s r0,r14
L_8e7e2a:
	mov_s r1,r0
L_8e7e2c:
	stb_s r13,[r0]
L_8e7e2e:
	mov_s r0,r14
L_8e7e30:
	mov_s r2,r13
L_8e7e32:
	mov_s r3,0x1a05
L_8e7e38:
	mov r4,0x4
L_8e7e3c:
	mov_s r5,r15
L_8e7e3e:
	mov_s r6,r13
L_8e7e40:
	bl.d L_8e0460
L_8e7e44:
	mov_s r7,r13
L_8e7e46:
	b L_8c032c
L_8e7e4a:
	nop_s
