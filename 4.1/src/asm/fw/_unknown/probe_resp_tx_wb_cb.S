/* probe_resp_tx_wb_cb @ 0x8ef700, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   probe_resp_tx_wb_cb() status %d
 * Зовёт сам: TX_API__free_memory, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1
 */
	.section .text.probe_resp_tx_wb_cb,"ax",@progbits
	.global probe_resp_tx_wb_cb
probe_resp_tx_wb_cb:
	.byte 0x4f
	.byte 0xe8
	.global fwlog_probe_resp_tx_wb_cb_status_d
fwlog_probe_resp_tx_wb_cb_status_d:
L_8ef702:
	nop_s
L_8ef704:
	push_s blink
L_8ef706:
	bl L_8c02c0
L_8ef70a:
	mov_s r15,r0
L_8ef70c:
	mov_s r14,r1
L_8ef70e:
	mov_s r13,r2
L_8ef710:
	mov_s r2,0x1012774
L_8ef716:
	mov_s r0,0xd
L_8ef718:
	mov_s r1,0x2
L_8ef71a:
	bl.d L_8edfcc
L_8ef71e:
	mov_s r3,r14
L_8ef720:
	cmp_s r14,0x0
L_8ef722:
	cmp.ne r13,0x0
L_8ef726:
	beq_s L_8ef734
L_8ef728:
	mov_s r1,0x843104
L_8ef72e:
	ld_s r0,[r1,0x18]
L_8ef730:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ef732:
	st_s r0,[r1,0x18]
	.global L_8ef734
L_8ef734:
	bl.d L_8c94c4
L_8ef738:
	mov_s r0,r15
L_8ef73a:
	b L_8c032c
L_8ef73e:
	nop_s
