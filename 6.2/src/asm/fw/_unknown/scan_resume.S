/* scan_resume @ 0x8f8304, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_resume()
 *   scan_resume() resumed on MID#%d.
 * Зовут его: stream_mgr__ready_step
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit1, scan_mngr__resume_scan
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_resume
scan_resume:
	.global L_8f8304
L_8f8304:
	push_s blink
L_8f8306:
	push_s r13
L_8f8308:
	mov_s r13,r0
L_8f830a:
	mov_s r1,0x1016e08
L_8f8310:
	bl.d L_8dcba8
L_8f8314:
	mov_s r0,0x2c
L_8f8316:
	ld_s r0,[r13,0x8]
L_8f8318:
	ld_s r0,[r0,0x78]
L_8f831a:
	breq_s r0,0,L_8f8332
L_8f831c:
	ld_s r2,[r13,0x4]
L_8f831e:
	mov_s r1,0x1016e18
L_8f8324:
	mov_s r0,0x2c
L_8f8326:
	bl.d L_8dcc10
L_8f832a:
	ldb_s r2,[r2,0x10]
L_8f832c:
	bl.d L_8f8028
L_8f8330:
	ld_s r0,[r13,0x8]
	.global L_8f8332
L_8f8332:
	b L_8c025c
L_8f8336:
	nop_s
