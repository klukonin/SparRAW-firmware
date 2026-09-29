/* stream_mgr__macq_removed @ 0x8c8d9c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   STREAM_MGR: TX MACQ [%d] REMOVED.
 * Зовут его: queue_deleted_evt
 * Зовёт сам: STREAM_MGR__2, __ld_r13_to_r13_ret, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__macq_removed
stream_mgr__macq_removed:
	.global L_8c8d9c
L_8c8d9c:
	push_s blink
L_8c8d9e:
	push_s r13
L_8c8da0:
	mov_s r2,r0
L_8c8da2:
	mov_s r1,0x0
L_8c8da4:
	b_s L_8c8da8
	.global L_8c8da6
L_8c8da6:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8c8da8
L_8c8da8:
	brhs r1,0xa,L_8c8dda
L_8c8dac:
	mov_s r0,0x847f34
L_8c8db2:
	sub r0,r0,0x400
L_8c8db6:
	add2_s r0,r0,r1
L_8c8db8:
	ld r13,[r0,0x44c]
L_8c8dc0:
	breq_s r13,0,L_8c8da6
L_8c8dc2:
	ldb_s r0,[r13,0x5]
L_8c8dc4:
	brne r2,r0,L_8c8da6
L_8c8dc8:
	mov_s r1,0x1010d00
L_8c8dce:
	bl.d L_8dcc10
L_8c8dd2:
	mov_s r0,0x2b
L_8c8dd4:
	bl.d L_8e81ac
L_8c8dd8:
	mov_s r0,r13
	.global L_8c8dda
L_8c8dda:
	b L_8c025c
L_8c8dde:
	nop_s
