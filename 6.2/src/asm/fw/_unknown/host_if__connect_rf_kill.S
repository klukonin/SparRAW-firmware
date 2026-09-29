/* host_if__connect_rf_kill @ 0x8ec484, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Connect IGNORED due to RF-KILL enabled, sending disconnect event
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, l2mgr__send_disconnect_evt, mid__copy_bssid, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_if__connect_rf_kill
host_if__connect_rf_kill:
	.global L_8ec484
L_8ec484:
	push_s blink
L_8ec486:
	bl.d L_8c01e4
L_8ec48a:
	mov_s r0,r1
L_8ec48c:
	sub_s sp,sp,0x8
L_8ec48e:
	bl.d L_8cc3dc
L_8ec492:
	mov_s r14,r1
L_8ec494:
	add_s r0,r0,0x48
L_8ec496:
	mov_s r13,sp
L_8ec498:
	bl.d L_8cbb58
L_8ec49c:
	mov_s r1,r13
L_8ec49e:
	mov_s r1,0x100b534
L_8ec4a4:
	bl.d L_8dcba8
L_8ec4a8:
	mov_s r0,0x10
L_8ec4aa:
	mov_s r0,r13
L_8ec4ac:
	mov_s r1,0x4
L_8ec4ae:
	mov_s r2,0x6
L_8ec4b0:
	bl.d L_8e538c
L_8ec4b4:
	mov_s r3,r14
L_8ec4b6:
	b.d L_8c0254
L_8ec4ba:
	add_s sp,sp,0x8
