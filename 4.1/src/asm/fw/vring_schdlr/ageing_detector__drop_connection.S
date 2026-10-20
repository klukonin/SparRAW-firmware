/* ageing_detector__drop_connection @ 0x8c7a40, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_ppdu_ageing_timeout_detector__task
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn__disconnect, conn_mgr__by_cid
 */
	.section .text.ageing_detector__drop_connection,"ax",@progbits
	.global ageing_detector__drop_connection
ageing_detector__drop_connection:
	.global L_8c7a40
L_8c7a40:
	push_s blink
L_8c7a42:
	bl L_8c02c4
L_8c7a46:
	mov_s r14,r1
L_8c7a48:
	bl.d L_8c9e44
L_8c7a4c:
	mov_s r13,r2
L_8c7a4e:
	cmp_s r0,0x0
L_8c7a50:
	mov.ne r1,r14
L_8c7a54:
	bl.ne.d L_8eb190
L_8c7a58:
	mov.ne r2,r13
L_8c7a5c:
	b L_8c0334
