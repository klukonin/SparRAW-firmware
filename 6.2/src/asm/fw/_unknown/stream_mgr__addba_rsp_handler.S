/* stream_mgr__addba_rsp_handler @ 0x8c3124, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stream_mgr::addba_rsp_handler AFTER DISCONNECTION
 * Зовут его: stream_mgr__action
 * Зовёт сам: __ld_r13_to_r13_ret, ba_sm_evt_type, fw_log_emit0, vring_tbl__find_by_tid_cid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__addba_rsp_handler
stream_mgr__addba_rsp_handler:
	.global L_8c3124
L_8c3124:
	push_s blink
L_8c3126:
	push_s r13
L_8c3128:
	mov_s r13,r0
L_8c312a:
	ldb_s r0,[r0,0x5]
L_8c312c:
	lsr_s r0,r0,0x2
L_8c312e:
	bl.d L_8cce44
L_8c3132:
	bmsk_s r0,r0,0x3
L_8c3134:
	brne_s r0,0,L_8c3144
L_8c3136:
	mov_s r1,0x101055c
L_8c313c:
	bl.d L_8dcba8
L_8c3140:
	mov_s r0,0x1b
L_8c3142:
	b_s L_8c3150
	.global L_8c3144
L_8c3144:
	mov_s r1,0x4
L_8c3146:
	mov_s r2,r13
L_8c3148:
	mov_s r3,0x0
L_8c314a:
	bl.d L_8d9c4c
L_8c314e:
	mov_s r4,r3
	.global L_8c3150
L_8c3150:
	b L_8c025c
