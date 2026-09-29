/* lmac_if__send_cmd_0x16_calib_b4 @ 0x8dc120, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__lmac_ready_evt
 * Зовёт сам: __ld_r13_to_r13_ret, calib_obj4__reset_d4, calib_obj__get_byte_b4, lmac_if__post_cmd, mem_pool__alloc_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__send_cmd_0x16_calib_b4
lmac_if__send_cmd_0x16_calib_b4:
	.global L_8dc120
L_8dc120:
	push_s blink
L_8dc122:
	mov_s r0,0x804280
L_8dc128:
	bl.d L_8c33d0
L_8dc12c:
	push_s r13
L_8dc12e:
	bl.d L_8cbb90
L_8dc132:
	mov_s r13,r0
L_8dc134:
	bl L_8cbbbc
L_8dc138:
	mov_s r1,0x16
L_8dc13a:
	stb_s r0,[r13]
L_8dc13c:
	mov_s r0,r13
L_8dc13e:
	mov_s r2,0x4
L_8dc140:
	bl.d L_8e5204
L_8dc144:
	mov_s r3,0x0
L_8dc146:
	b L_8c025c
L_8dc14a:
	nop_s
