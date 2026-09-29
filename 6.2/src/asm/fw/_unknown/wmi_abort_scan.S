/* wmi_abort_scan @ 0x8eca3c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, l2_mgr__aborting_scan, pcp_psc_sm__send_usol_psc_resp_sm
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_abort_scan
wmi_abort_scan:
	.global L_8eca3c
L_8eca3c:
	push_s blink
L_8eca3e:
	push_s r13
L_8eca40:
	bl.d L_8c1da4
L_8eca44:
	mov_s r13,r0
L_8eca46:
	cmp_s r0,0x0
L_8eca48:
	mov.eq r0,0x4
L_8eca4c:
	bl.eq.d L_8e5d48
L_8eca50:
	mov.eq r1,r13
L_8eca54:
	b L_8c025c
