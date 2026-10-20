/* stats__log_counters @ 0x8f62f8, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   total_tx_d_bytes = 0x%x, total_rx_d_bytes = 0x%x
 *   total_tx_mpdus = 0x%x, total_tx_err_mpdus = 0x%x
 *   total_rx_mpdus = 0x%x, total_rx_err_mpdus = 0x%x
 *   mcs=0x%x, total_rx_mpdus_at_the_mcs = 0x%x, total_rx_err_mpdus_at_the_mcs = 0x%x
 * Зовут его: mac_ampdu_statistics_timeout_cb
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, fw_log_emit3, fw_sysapi_mgr__send_evt2host, memset0_words, stats__delta_since_baseline
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stats__log_counters
stats__log_counters:
	.global L_8f62f8
L_8f62f8:
	push_s blink
L_8f62fa:
	bl.d L_8c01e4
L_8f62fe:
	mov_s r1,0x28
L_8f6300:
	sub_s sp,sp,0x28
L_8f6302:
	mov_s r13,r0
L_8f6304:
	bl.d L_8c1cd8
L_8f6308:
	mov_s r0,sp
L_8f630a:
	mov_s r14,sp
L_8f630c:
	mov_s r0,r13
L_8f630e:
	bl.d L_8f64f4
L_8f6312:
	mov_s r1,r14
L_8f6314:
	ld_s r2,[sp,0x0]
L_8f6316:
	mov_s r1,0x1012c74
L_8f631c:
	mov_s r0,0x20
L_8f631e:
	bl.d L_8dcc80
L_8f6322:
	ld_s r3,[sp,0x8]
L_8f6324:
	mov_s r1,0x1012ca8
L_8f632a:
	ld_s r2,[sp,0x10]
L_8f632c:
	mov_s r0,0x20
L_8f632e:
	bl.d L_8dcc80
L_8f6332:
	ld_s r3,[sp,0x14]
L_8f6334:
	mov_s r1,0x1012cdc
L_8f633a:
	ld_s r2,[sp,0x18]
L_8f633c:
	mov_s r0,0x20
L_8f633e:
	bl.d L_8dcc80
L_8f6342:
	ld_s r3,[sp,0x1c]
L_8f6344:
	mov_s r1,0x1012d10
L_8f634a:
	ld r4,[sp, 0x24]
L_8f634e:
	mov_s r0,0x20
L_8f6350:
	ldb_s r2,[r13,0x14]
L_8f6352:
	bl.d L_8dcd00
L_8f6356:
	ld_s r3,[sp,0x20]
L_8f6358:
	add r4,r13,0x4
L_8f635c:
	mov_s r0,r13
L_8f635e:
	ld_s r1,[r13,0x20]
L_8f6360:
	mov_s r2,r14
L_8f6362:
	bl.d L_8f8948
L_8f6366:
	mov_s r3,0x28
L_8f6368:
	b.d L_8c0254
L_8f636c:
	add_s sp,sp,0x28
L_8f636e:
	nop_s
