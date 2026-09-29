/* lmac_if_send_get_selected_rf_sector_index @ 0x8cae64, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_mbox__alloc_slot, memcpy_fw, send_cmd2_lmac
 */
	.section .text.lmac_if_send_get_selected_rf_sector_index,"ax",@progbits
	.global lmac_if_send_get_selected_rf_sector_index
lmac_if_send_get_selected_rf_sector_index:
	.global L_8cae64
L_8cae64:
	push_s blink
L_8cae66:
	bl L_8c02c4
L_8cae6a:
	bl.d L_8c2b0c
L_8cae6e:
	mov_s r14,r0
L_8cae70:
	mov_s r13,r0
L_8cae72:
	mov_s r1,r14
L_8cae74:
	bl.d L_8c0460
L_8cae78:
	mov_s r2,0x4
L_8cae7a:
	mov_s r0,r13
L_8cae7c:
	mov_s r1,0x39
L_8cae7e:
	mov_s r2,0x4
L_8cae80:
	bl.d L_8e0694
L_8cae84:
	mov_s r3,0x0
L_8cae86:
	b L_8c0334
L_8cae8a:
	nop_s
