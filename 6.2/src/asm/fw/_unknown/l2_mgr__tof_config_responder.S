/* l2_mgr__tof_config_responder @ 0x8e95fc, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::tof_config_responder
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, field_rw_0x04__8e6e08, ftm__ctx_addr, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__tof_config_responder
l2_mgr__tof_config_responder:
	.global L_8e95fc
L_8e95fc:
	push_s blink
L_8e95fe:
	push_s r13
L_8e9600:
	mov_s r13,r0
L_8e9602:
	mov_s r1,0x100e974
L_8e9608:
	bl.d L_8dcba8
L_8e960c:
	mov_s r0,0x2b
L_8e960e:
	bl.d L_8ccf04
L_8e9612:
	ldb_s r13,[r13]
L_8e9614:
	bl.d L_8e6e08
L_8e9618:
	mov_s r1,r13
L_8e961a:
	b L_8c025c
L_8e961e:
	nop_s
