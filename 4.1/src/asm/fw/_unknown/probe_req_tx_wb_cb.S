/* probe_req_tx_wb_cb @ 0x8ef654, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   probe_req_tx_wb_cb() status %d
 * Зовёт сам: TX_API__free_memory, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1
 */
	.section .text.probe_req_tx_wb_cb,"ax",@progbits
	.global probe_req_tx_wb_cb
probe_req_tx_wb_cb:
L_8ef654:
	push_s blink
L_8ef656:
	bl L_8c02c0
L_8ef65a:
	mov_s r13,r0
L_8ef65c:
	mov_s r14,r1
L_8ef65e:
	mov_s r15,r2
L_8ef660:
	mov_s r2,0x1012754
L_8ef666:
	mov_s r0,0xc
L_8ef668:
	mov_s r1,0x2
L_8ef66a:
	bl.d L_8edfcc
L_8ef66e:
	mov_s r3,r14
L_8ef670:
	cmp_s r14,0x0
L_8ef672:
	cmp.ne r15,0x0
L_8ef676:
	beq_s L_8ef684
L_8ef678:
	mov_s r1,0x843104
L_8ef67e:
	ld_s r0,[r1,0x8]
L_8ef680:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ef682:
	st_s r0,[r1,0x8]
	.global L_8ef684
L_8ef684:
	cmp_s r13,0x0
L_8ef686:
	bl.ne.d L_8c94c4
L_8ef68a:
	mov.ne r0,r13
L_8ef68e:
	.byte 0xa1,0x04
