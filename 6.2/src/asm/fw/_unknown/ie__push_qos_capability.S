/* ie__push_qos_capability @ 0x8e1f4c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Pushed QoS Capability IE [%x] length 3
 * Зовут его: mgmt_tx__append_probe_resp_ies, mgmt_tx__assoc_req_ies
 * Зовёт сам: fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ie__push_qos_capability
ie__push_qos_capability:
	.global L_8e1f4c
L_8e1f4c:
	push_s blink
L_8e1f4e:
	mov_s r1,0x2e
L_8e1f50:
	stb_s r1,[r0]
L_8e1f52:
	mov_s r1,0x1
L_8e1f54:
	stb_s r1,[r0,0x1]
L_8e1f56:
	ldb.a r2,[r0,0x2]
L_8e1f5a:
	mov_s r1,0x100fb10
L_8e1f60:
	bset_s r2,r2,0x3
L_8e1f62:
	stb_s r2,[r0]
L_8e1f64:
	bl.d L_8dcc10
L_8e1f68:
	mov_s r0,0x2d
L_8e1f6a:
	mov_s r0,0x3
L_8e1f6c:
	pop_s blink
L_8e1f6e:
	j_s [blink]
