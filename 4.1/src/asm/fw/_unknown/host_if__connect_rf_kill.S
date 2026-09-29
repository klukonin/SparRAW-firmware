/* host_if__connect_rf_kill @ 0x8e7774, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Connect IGNORED due to RF-KILL enabled, sending disconnect event
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, l2mgr__send_disconnect_evt, mid__copy_bssid, mid_list__by_mid
 */
	.section .text.host_if__connect_rf_kill,"ax",@progbits
	.global host_if__connect_rf_kill
host_if__connect_rf_kill:
	.global L_8e7774
L_8e7774:
	push_s blink
L_8e7776:
	bl.d L_8c02c4
L_8e777a:
	mov_s r0,r1
L_8e777c:
	sub_s sp,sp,0x8
L_8e777e:
	bl.d L_8ca1b0
L_8e7782:
	mov_s r14,r1
L_8e7784:
	add_s r0,r0,0x48
L_8e7786:
	mov_s r13,sp
L_8e7788:
	bl.d L_8c9ae4
L_8e778c:
	mov_s r1,r13
L_8e778e:
	mov_s r2,0x1009f88
L_8e7794:
	mov_s r0,0x0
L_8e7796:
	bl.d L_8edfb0
L_8e779a:
	mov_s r1,0x1
L_8e779c:
	mov_s r0,r13
L_8e779e:
	mov_s r1,0x4
L_8e77a0:
	mov_s r2,0x6
L_8e77a2:
	bl.d L_8f051c
L_8e77a6:
	mov_s r3,r14
L_8e77a8:
	b.d L_8c0334
L_8e77ac:
	add_s sp,sp,0x8
L_8e77ae:
	nop_s
