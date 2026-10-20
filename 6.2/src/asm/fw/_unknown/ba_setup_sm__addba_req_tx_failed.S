/* ba_setup_sm__addba_req_tx_failed @ 0x8f0b40, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm::addba_req_tx_failed() , current state = %d.
 *   receiving addba response without reciving ack before that for the addba request(addba req transmmitted but ack is not received- i.e. tx failed with status TX_STATUS_MAX_RETRY and EVT_ADDBAREQ_TX_FAILED event was injected), continuing as usual.
 * Зовёт сам: fw_log_emit0, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__addba_req_tx_failed
ba_setup_sm__addba_req_tx_failed:
	.global L_8f0b40
L_8f0b40:
	push_s blink
L_8f0b42:
	ldb_s r2,[r0]
L_8f0b44:
	mov_s r1,0x1013888
L_8f0b4a:
	bl.d L_8dcc10
L_8f0b4e:
	mov_s r0,0x17
L_8f0b50:
	mov_s r1,0x10138c4
L_8f0b56:
	bl.d L_8dcba8
L_8f0b5a:
	mov_s r0,0x17
L_8f0b5c:
	pop_s blink
L_8f0b5e:
	j_s [blink]
