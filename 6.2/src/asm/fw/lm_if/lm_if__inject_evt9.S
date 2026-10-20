/* lm_if__inject_evt9 @ 0x8e011c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__rearm_all_detectors, l2_mgr__wmi_scan_cmd
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_if__inject_evt9
lm_if__inject_evt9:
	.global L_8e011c
L_8e011c:
	push_s blink
L_8e011e:
	push_s r13
L_8e0120:
	mov_s r13,r0
L_8e0122:
	ld_s r0,[r0]
L_8e0124:
	breq_s r0,0,L_8e0138
	.global L_8e0126
L_8e0126:
	ld_s r0,[r13]
L_8e0128:
	mov_s r1,0x9
L_8e012a:
	mov_s r2,0x0
L_8e012c:
	mov_s r3,r2
L_8e012e:
	bl.d L_8d9b6c
L_8e0132:
	mov_s r4,r2
L_8e0134:
	b L_8c025c
	.global L_8e0138
L_8e0138:
	mov_s r0,blink
L_8e013a:
	mov_s r1,0x1262
L_8e0140:
	bl L_8c9b28
L_8e0144:
	b_s L_8e0126
L_8e0146:
	nop_s
