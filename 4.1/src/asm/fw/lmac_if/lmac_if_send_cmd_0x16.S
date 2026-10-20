/* lmac_if_send_cmd_0x16 @ 0x8d8bd0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__lmac_ready_evt
 * Зовёт сам: basic_if__alloc_mbox_slot, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x16,"ax",@progbits
	.global lmac_if_send_cmd_0x16
lmac_if_send_cmd_0x16:
	.global L_8d8bd0
L_8d8bd0:
	push_s blink
L_8d8bd2:
	mov_s r0,0x803e3c
L_8d8bd8:
	bl L_8c2c38
L_8d8bdc:
	mov_s r1,0x800d08
L_8d8be2:
	ldb_s r1,[r1]
L_8d8be4:
	mov_s r2,0x4
L_8d8be6:
	stb_s r1,[r0]
L_8d8be8:
	mov_s r1,0x16
L_8d8bea:
	bl.d L_8e0694
L_8d8bee:
	mov_s r3,0x0
L_8d8bf0:
	pop_s blink
L_8d8bf2:
	j_s [blink]
