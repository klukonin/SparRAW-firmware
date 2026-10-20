/* lmac_if_send_set_selected_rf_sector_index @ 0x8cd1c0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_send_set_selected_rf_sector_index
lmac_if_send_set_selected_rf_sector_index:
	.global L_8cd1c0
L_8cd1c0:
	push_s blink
L_8cd1c2:
	bl L_8c01e4
L_8cd1c6:
	bl.d L_8c3284
L_8cd1ca:
	mov_s r14,r0
L_8cd1cc:
	mov_s r13,r0
L_8cd1ce:
	mov_s r1,r14
L_8cd1d0:
	bl.d L_8c0380
L_8cd1d4:
	mov_s r2,0x4
L_8cd1d6:
	mov_s r0,r13
L_8cd1d8:
	mov_s r1,0x3a
L_8cd1da:
	mov_s r2,0x4
L_8cd1dc:
	bl.d L_8e5204
L_8cd1e0:
	mov_s r3,0x0
L_8cd1e2:
	b L_8c0254
L_8cd1e6:
	nop_s
