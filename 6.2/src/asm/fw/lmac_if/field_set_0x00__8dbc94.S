/* field_set_0x00__8dbc94 @ 0x8dbc94, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ut_hw_flows__field_set_thunk
 * Зовёт сам: __ld_r13_to_r13_ret, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_set_0x00__8dbc94
field_set_0x00__8dbc94:
	.global L_8dbc94
L_8dbc94:
	push_s blink
L_8dbc96:
	push_s r13
L_8dbc98:
	bl.d L_8c3284
L_8dbc9c:
	mov_s r13,r0
L_8dbc9e:
	stb_s r13,[r0]
L_8dbca0:
	mov_s r1,0x12
L_8dbca2:
	mov_s r2,0x1
L_8dbca4:
	bl.d L_8e5204
L_8dbca8:
	mov_s r3,0x0
L_8dbcaa:
	b L_8c025c
L_8dbcae:
	nop_s
