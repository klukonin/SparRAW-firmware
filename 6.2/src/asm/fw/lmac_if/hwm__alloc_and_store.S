/* hwm__alloc_and_store @ 0x8dbea8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ut_hw_flows__hwm_alloc_and_store_thunk, wmi_tof_set_tx_rx_offset
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm__alloc_and_store
hwm__alloc_and_store:
	.global L_8dbea8
L_8dbea8:
	push_s blink
L_8dbeaa:
	bl L_8c01e4
L_8dbeae:
	mov_s r14,r0
L_8dbeb0:
	bl.d L_8c3284
L_8dbeb4:
	mov_s r13,r1
L_8dbeb6:
	st_s r14,[r0]
L_8dbeb8:
	st_s r13,[r0,0x4]
L_8dbeba:
	mov_s r1,0x2c
L_8dbebc:
	mov_s r2,0x8
L_8dbebe:
	bl.d L_8e5204
L_8dbec2:
	mov_s r3,0x0
L_8dbec4:
	b L_8c0254
