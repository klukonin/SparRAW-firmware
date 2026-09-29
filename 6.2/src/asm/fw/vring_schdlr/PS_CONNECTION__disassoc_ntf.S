/* PS_CONNECTION__disassoc_ntf @ 0x8c8ff0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_CONNECTION::disassoc_ntf (m_conn_p=0x%x)
 * Зовут его: m_connect_devid
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit1, ps_conn__post_disassoc_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global PS_CONNECTION__disassoc_ntf
PS_CONNECTION__disassoc_ntf:
	.global L_8c8ff0
L_8c8ff0:
	push_s blink
L_8c8ff2:
	bl L_8c01e4
L_8c8ff6:
	mov_s r13,r0
L_8c8ff8:
	mov_s r1,0x100253c
L_8c8ffe:
	mov_s r0,0x2e
L_8c9000:
	bl.d L_8dcc10
L_8c9004:
	ld_s r2,[r13,0x34]
L_8c9006:
	add_s r0,r13,0x4
L_8c9008:
	mov_s r1,0x4
L_8c900a:
	mov_s r14,0x0
L_8c900c:
	mov_s r2,r14
L_8c900e:
	mov_s r3,r14
L_8c9010:
	bl.d L_8d9b6c
L_8c9014:
	mov_s r4,r14
L_8c9016:
	bl.d L_8c6994
L_8c901a:
	add r0,r13,0x38
L_8c901e:
	b.d L_8c0254
L_8c9022:
	st_s r14,[r13,0x34]
