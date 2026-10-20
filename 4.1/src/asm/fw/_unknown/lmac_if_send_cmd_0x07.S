/* lmac_if_send_cmd_0x07 @ 0x8efb90, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: __ld_r13_ret, bf_w_s0_w5, bf_w_s16_w5, bf_w_s24_w5, bf_w_s8_w5, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x07,"ax",@progbits
	.global lmac_if_send_cmd_0x07
lmac_if_send_cmd_0x07:
	.global L_8efb90
L_8efb90:
	push_s blink
L_8efb92:
	bl.d L_8c2b0c
L_8efb96:
	push_s r13
L_8efb98:
	mov_s r2,r0
L_8efb9a:
	mov_s r0,0x1
L_8efb9c:
	st_s r0,[r2,0xc]
L_8efb9e:
	mov_s r3,0x19
L_8efba0:
	add_s r0,r2,0x4
L_8efba2:
	mov_s r1,r3
L_8efba4:
	bl.d L_8e8354
L_8efba8:
	mov_s r13,0x0
L_8efbaa:
	mov_s r1,0x1c
L_8efbac:
	bl L_8e8564
L_8efbb0:
	mov_s r1,0x18
L_8efbb2:
	bl L_8e83d8
L_8efbb6:
	mov_s r1,r3
L_8efbb8:
	bl.d L_8e8450
L_8efbbc:
	mov_s r3,r13
L_8efbbe:
	mov_s r0,r2
L_8efbc0:
	mov_s r1,0x7
L_8efbc2:
	bl.d L_8e0694
L_8efbc6:
	mov_s r2,0x10
L_8efbc8:
	bl L_8c2b0c
L_8efbcc:
	mov_s r1,r13
L_8efbce:
	mov_s r2,r0
L_8efbd0:
	mov_s r0,0x2
L_8efbd2:
	st_s r0,[r2,0xc]
L_8efbd4:
	add r0,r2,0x8
L_8efbd8:
	bl.d L_8e8354
L_8efbdc:
	mov_s r3,r13
L_8efbde:
	mov_s r1,0xa
L_8efbe0:
	bl L_8e8564
L_8efbe4:
	mov_s r0,r2
L_8efbe6:
	mov_s r1,0x7
L_8efbe8:
	bl.d L_8e0694
L_8efbec:
	mov_s r2,0x10
L_8efbee:
	.byte 0x51,0x07
