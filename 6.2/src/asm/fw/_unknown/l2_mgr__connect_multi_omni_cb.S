/* l2_mgr__connect_multi_omni_cb @ 0x8c7300, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::connect_multi_omni_cb() curr_systime %d
 * Зовут его: l2_mgr__connect_multi_omni
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, l2_mgr__connect, l2_mgr__connect_setup, mid_list__by_mid_fw, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__connect_multi_omni_cb
l2_mgr__connect_multi_omni_cb:
	.global L_8c7300
L_8c7300:
	push_s blink
L_8c7302:
	bl L_8c01e4
L_8c7306:
	mov_s r14,r0
L_8c7308:
	bl.d L_8e9524
L_8c730c:
	mov_s r13,r1
L_8c730e:
	mov_s r2,r0
L_8c7310:
	mov_s r1,0x100ea2c
L_8c7316:
	bl.d L_8dcc10
L_8c731a:
	mov_s r0,0x2b
L_8c731c:
	bl.d L_8cc3dc
L_8c7320:
	mov_s r0,r13
L_8c7322:
	mov_s r1,0x0
L_8c7324:
	st.as r1,[r0,0xab]
L_8c7328:
	mov_s r0,r14
L_8c732a:
	bl.d L_8f85d4
L_8c732e:
	mov_s r1,r13
L_8c7330:
	mov_s r0,r14
L_8c7332:
	bl.d L_8f1e18
L_8c7336:
	mov_s r1,r13
L_8c7338:
	b L_8c0254
