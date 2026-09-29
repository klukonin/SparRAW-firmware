/* tx_api__mask_from_queue @ 0x8e97e8, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__flush_pending_peer_pm_connection, mem_pool__put_block
 * Зовёт сам: host_irq__raise_fw_int2, host_irq__raise_mbox_evt, hwd_dma__uses_rgf_881c00_8d0b14, lmac_if_send_cmd_0x08, pcie__set_event_bit_1a_txq, pcie__set_event_bit_1b_txq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__mask_from_queue
tx_api__mask_from_queue:
	.global L_8e97e8
L_8e97e8:
	ld_s r0,[r0,0x10]
L_8e97ea:
	mov_s r12,0x1
L_8e97ec:
	asl r0,r12,r0
L_8e97f0:
	b.d L_8d0b14
L_8e97f4:
	mov_s r1,0x0
L_8e97f6:
	nop_s
	.global L_8e97f8
L_8e97f8:
	ld r0,[r0, 0x8c]
L_8e97fc:
	ld_s r1,[r0]
L_8e97fe:
	ld_s r1,[r1,0x10]
L_8e9800:
	j_s [r1]
L_8e9802:
	nop_s
L_8e9804:
	ldb_s r3,[r0,0x14]
L_8e9806:
	mov_s r0,0x0
L_8e9808:
	mov_s r1,0x3
L_8e980a:
	mov_s r2,r0
L_8e980c:
	mov_s r4,r0
L_8e980e:
	mov r5,0x1
L_8e9812:
	b.d L_8dbb60
L_8e9816:
	mov_s r6,r0
L_8e9818:
	push_s blink
L_8e981a:
	bl L_8d0d04
L_8e981e:
	bl L_8d1b08
L_8e9822:
	pop_s blink
L_8e9824:
	j_s [blink]
L_8e9826:
	nop_s
L_8e9828:
	push_s blink
L_8e982a:
	bl L_8d1af0
L_8e982e:
	bl L_8d0cec
L_8e9832:
	pop_s blink
L_8e9834:
	j_s [blink]
L_8e9836:
	nop_s
