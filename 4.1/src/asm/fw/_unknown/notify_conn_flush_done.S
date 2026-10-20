/* notify_conn_flush_done @ 0x8db1fc, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   notify_conn_flush_done: m_connection_pending_flush_msk = 0x%x.
 * Зовут его: fwq_tx__on_flush_done
 * Зовёт сам: TX_INTERNAL_API__connection, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, u_schd__cancel
 */
	.section .text.notify_conn_flush_done,"ax",@progbits
	.global notify_conn_flush_done
notify_conn_flush_done:
	.global L_8db1fc
L_8db1fc:
	push_s blink
L_8db1fe:
	bl L_8c02c4
L_8db202:
	mov_s r13,r0
L_8db204:
	ld_s r0,[r0,0x14]
L_8db206:
	mov_s r14,r1
L_8db208:
	bclr r0,r0,r1
L_8db20c:
	ld_s r1,[r13]
L_8db20e:
	st_s r0,[r13,0x14]
L_8db210:
	ld_s r0,[r1,0x20]
L_8db212:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8db214:
	st_s r0,[r1,0x20]
L_8db216:
	ld_s r0,[r13,0x14]
L_8db218:
	brne_s r0,0,L_8db226
L_8db21a:
	ld_s r0,[r13,0x10]
L_8db21c:
	breq_s r0,0,L_8db226
L_8db21e:
	bl L_8c7794
L_8db222:
	mov_s r0,0x0
L_8db224:
	st_s r0,[r13,0x10]
	.global L_8db226
L_8db226:
	mov_s r2,0x1015698
L_8db22c:
	mov_s r0,0x7
L_8db22e:
	mov_s r1,0x2
L_8db230:
	bl.d L_8edfcc
L_8db234:
	ld_s r3,[r13,0x14]
L_8db236:
	bl.d L_8c95e8
L_8db23a:
	mov_s r0,r14
L_8db23c:
	b L_8c0334
