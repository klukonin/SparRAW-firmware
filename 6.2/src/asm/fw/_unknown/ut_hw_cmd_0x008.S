/* ut_hw_cmd_0x008 @ 0x8eacb0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__enable_first_pending_gtk, vring__reinstall_keys_for_mid
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, ut_hw_cmd_008__params, vring_tbl__entry_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_cmd_0x008
ut_hw_cmd_0x008:
	.global L_8eacb0
L_8eacb0:
	push_s blink
L_8eacb2:
	bl L_8c01e4
L_8eacb6:
	mov_s r14,r1
L_8eacb8:
	mov_s r13,r2
L_8eacba:
	bl.d L_8ccfd8
L_8eacbe:
	ldb_s r0,[r0,0x5]
L_8eacc0:
	mov_s r1,r14
L_8eacc2:
	bl.d L_8e6f94
L_8eacc6:
	mov_s r2,r13
L_8eacc8:
	b L_8c0254
