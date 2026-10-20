/* l2_mgr__scan_start_log @ 0x8f8338, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Start scan <ts: %d>
 * Зовут его: l2_mgr__wmi_scan_cmd
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, find_sm__start_search, fw_log_emit1, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__scan_start_log
l2_mgr__scan_start_log:
	.global L_8f8338
L_8f8338:
	push_s blink
L_8f833a:
	bl L_8c01dc
L_8f833e:
	mov_s r13,r0
L_8f8340:
	mov_s r16,r1
L_8f8342:
	mov_s r15,r2
L_8f8344:
	bl.d L_8e9524
L_8f8348:
	mov_s r14,r3
L_8f834a:
	mov_s r2,r0
L_8f834c:
	mov_s r1,0x1016dd8
L_8f8352:
	bl.d L_8dcc10
L_8f8356:
	mov_s r0,0x2c
L_8f8358:
	ld_s r0,[r13,0x8]
L_8f835a:
	mov_s r1,r16
L_8f835c:
	mov_s r2,r15
L_8f835e:
	bl.d L_8f9920
L_8f8362:
	mov_s r3,r14
L_8f8364:
	b L_8c0244
