/* lmac_if_send_cmd_0x05 @ 0x8d8e2c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__set_sectors_hal
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, basic_if__alloc_mbox_slot, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x05,"ax",@progbits
	.global lmac_if_send_cmd_0x05
lmac_if_send_cmd_0x05:
	.global L_8d8e2c
L_8d8e2c:
	push_s blink
L_8d8e2e:
	bl L_8c02b8
L_8d8e32:
	mov_s r14,r0
L_8d8e34:
	mov_s r13,r1
L_8d8e36:
	mov_s r15,r2
L_8d8e38:
	mov_s r16,r3
L_8d8e3a:
	mov_s r0,0x803e3c
L_8d8e40:
	bl.d L_8c2c38
L_8d8e44:
	mov r17,r4
L_8d8e48:
	mov_s r1,0x2
L_8d8e4a:
	st_s r1,[r0,0xc]
L_8d8e4c:
	stb_s r14,[r0,0x8]
L_8d8e4e:
	stw_s r13,[r0,0x2]
L_8d8e50:
	stb_s r15,[r0]
L_8d8e52:
	stw r16,[r0, 0x6]
L_8d8e56:
	stb r17,[r0, 0x4]
L_8d8e5a:
	mov_s r1,0x5
L_8d8e5c:
	mov_s r2,0x24
L_8d8e5e:
	bl.d L_8e0694
L_8d8e62:
	mov_s r3,0x0
L_8d8e64:
	b L_8c031c
