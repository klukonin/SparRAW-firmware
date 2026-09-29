/* mem_resource__check_timeout_cb @ 0x8c6264, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   check_memory_resource_timeout_cb
 *   calib_bb_gain_dc::check_online_estimation_condition  G_RX_VGA_RANGE_CONFIG.VGA_DC_FINE_FORCE=1
 * Зовёт сам: __ld_r13_to_r13_ret, assoc_ready_check_trig, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mem_resource__check_timeout_cb
mem_resource__check_timeout_cb:
	.global L_8c6264
L_8c6264:
	push_s blink
L_8c6266:
	push_s r13
L_8c6268:
	mov_s r13,r0
L_8c626a:
	mov_s r1,0x100ca34
L_8c6270:
	bl.d L_8dcba8
L_8c6274:
	mov_s r0,0x2b
L_8c6276:
	breq_s r13,0,L_8c6288
	.global L_8c6278
L_8c6278:
	mov_s r0,0x0
L_8c627a:
	st.as r0,[r13,0xaa]
L_8c627e:
	bl.d L_8c3db0
L_8c6282:
	mov_s r0,r13
L_8c6284:
	b L_8c025c
	.global L_8c6288
L_8c6288:
	mov_s r0,blink
L_8c628a:
	mov_s r1,0x1461
L_8c6290:
	bl L_8c9b28
L_8c6294:
	b_s L_8c6278
L_8c6296:
	nop_s
L_8c6298:
	j_s.d [blink]
L_8c629a:
	mov_s r0,0x0
L_8c629c:
	push_s blink
L_8c629e:
	push_s r13
L_8c62a0:
	mov_s r13,0x800510
L_8c62a6:
	ld_s r0,[r13,0x4]
L_8c62a8:
	brne r0,0x1,L_8c62c0
L_8c62ac:
	mov_s r1,0x100a1f4
L_8c62b2:
	bl.d L_8dcba8
L_8c62b6:
	mov_s r0,0x26
L_8c62b8:
	mov_s r0,0x0
L_8c62ba:
	st_s r0,[r13,0x4]
L_8c62bc:
	mov_s r0,0x1
L_8c62be:
	b_s L_8c62c2
	.global L_8c62c0
L_8c62c0:
	mov_s r0,0x0
	.global L_8c62c2
L_8c62c2:
	b L_8c025c
L_8c62c6:
	nop_s
