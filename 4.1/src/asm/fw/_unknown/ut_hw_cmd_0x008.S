/* ut_hw_cmd_0x008 @ 0x8e59d8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__gtk_key_id, stream_mgr__foreach_pring_of_owner
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, vring_ba__build_cfg, vring_by_index
 */
	.section .text.ut_hw_cmd_0x008,"ax",@progbits
	.global ut_hw_cmd_0x008
ut_hw_cmd_0x008:
	.global L_8e59d8
L_8e59d8:
	push_s blink
L_8e59da:
	bl L_8c02c4
L_8e59de:
	mov_s r14,r1
L_8e59e0:
	mov_s r13,r2
L_8e59e2:
	bl.d L_8cacc0
L_8e59e6:
	ldb_s r0,[r0,0x5]
L_8e59e8:
	mov_s r1,r14
L_8e59ea:
	bl.d L_8e2058
L_8e59ee:
	mov_s r2,r13
L_8e59f0:
	b L_8c0334
