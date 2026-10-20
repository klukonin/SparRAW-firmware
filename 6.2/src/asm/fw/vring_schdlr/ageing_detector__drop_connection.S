/* ageing_detector__drop_connection @ 0x8c90f0, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_ppdu_ageing_timeout_detector__task
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn__disconnect, conn_mgr__by_cid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ageing_detector__drop_connection
ageing_detector__drop_connection:
	.global L_8c90f0
L_8c90f0:
	push_s blink
L_8c90f2:
	bl L_8c01e4
L_8c90f6:
	mov_s r14,r1
L_8c90f8:
	bl.d L_8cbffc
L_8c90fc:
	mov_s r13,r2
L_8c90fe:
	cmp_s r0,0x0
L_8c9100:
	mov.ne r1,r14
L_8c9104:
	bl.ne.d L_8f2540
L_8c9108:
	mov.ne r2,r13
L_8c910c:
	b L_8c0254
