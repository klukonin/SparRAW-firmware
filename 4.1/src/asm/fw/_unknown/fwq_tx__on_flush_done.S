/* fwq_tx__on_flush_done @ 0x8e4778, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fwq_tx__find_packet, fwq_tx__flush_by_prio, notify_conn_flush_done
 */
	.section .text.fwq_tx__on_flush_done,"ax",@progbits
	.global fwq_tx__on_flush_done
fwq_tx__on_flush_done:
	.global L_8e4778
L_8e4778:
	push_s blink
L_8e477a:
	bl L_8c02c0
L_8e477e:
	mov_s r13,r0
L_8e4780:
	mov_s r14,r1
L_8e4782:
	mov_s r15,r2
L_8e4784:
	add r1,r0,0x34
L_8e4788:
	bl.d L_8ca508
L_8e478c:
	mov_s r2,r14
L_8e478e:
	brne_s r0,0,L_8e47a2
L_8e4790:
	mov_s r0,r13
L_8e4792:
	mov_s r1,r14
L_8e4794:
	bl.d L_8c900c
L_8e4798:
	mov_s r2,r15
L_8e479a:
	mov_s r0,r13
L_8e479c:
	bl.d L_8db1fc
L_8e47a0:
	mov_s r1,r14
	.global L_8e47a2
L_8e47a2:
	b L_8c032c
L_8e47a6:
	nop_s
