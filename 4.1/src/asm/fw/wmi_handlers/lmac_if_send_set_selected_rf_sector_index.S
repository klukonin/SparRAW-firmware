/* lmac_if_send_set_selected_rf_sector_index @ 0x8cae8c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_mbox__alloc_slot, memcpy_fw, send_cmd2_lmac
 */
	.section .text.lmac_if_send_set_selected_rf_sector_index,"ax",@progbits
	.global lmac_if_send_set_selected_rf_sector_index
lmac_if_send_set_selected_rf_sector_index:
	.global L_8cae8c
L_8cae8c:
	push_s blink
L_8cae8e:
	bl L_8c02c4
L_8cae92:
	bl.d L_8c2b0c
L_8cae96:
	mov_s r14,r0
L_8cae98:
	mov_s r13,r0
L_8cae9a:
	mov_s r1,r14
L_8cae9c:
	bl.d L_8c0460
L_8caea0:
	mov_s r2,0x4
L_8caea2:
	mov_s r0,r13
L_8caea4:
	mov_s r1,0x3a
L_8caea6:
	mov_s r2,0x4
L_8caea8:
	bl.d L_8e0694
L_8caeac:
	mov_s r3,0x0
L_8caeae:
	b L_8c0334
L_8caeb2:
	nop_s
