/* rx_pkt_srvs__distribute_data @ 0x8def44, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RX PKT SRVS: CID %d stype %x pkt len %d
 *   rx_pkt_srvs.cpp
 *   RX PKT SRVS: Distribute data RX failed stype %x
 * Зовут его: rx_pkt_srvs__dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, fw_log__emit3, fw_sysassert_fatal, mgmt_buf__free
 */
	.section .text.rx_pkt_srvs__distribute_data,"ax",@progbits
	.global rx_pkt_srvs__distribute_data
rx_pkt_srvs__distribute_data:
	.global L_8def44
L_8def44:
	push_s blink
L_8def46:
	bl L_8c02c0
L_8def4a:
	mov.f r14,r1
L_8def4e:
	beq_s L_8defbe
	.global L_8def50
L_8def50:
	ld_s r0,[r14,0x14]
L_8def52:
	breq r0,0x0,L_8defd4
	.global L_8def56
L_8def56:
	ld_s r13,[r14,0x14]
L_8def58:
	ld r5,[r14, 0x30]
L_8def5c:
	ldw_s r15,[r13]
L_8def5e:
	mov_s r2,0x1010ac0
L_8def64:
	ldb r3,[r14, 0x36]
L_8def68:
	mov_s r0,0xd
L_8def6a:
	mov_s r1,0x1
L_8def6c:
	lsr_s r15,r15,0x4
L_8def6e:
	bl.d L_8ee034
L_8def72:
	bmsk r4,r15,0x3
L_8def76:
	ldw_s r3,[r13]
L_8def78:
	lsr r0,r3,0x2
L_8def7c:
	bmsk_s r0,r0,0x1
L_8def7e:
	breq r0,0x2,L_8def96
L_8def82:
	mov_s r0,blink
L_8def84:
	mov_s r2,0x1010aec
L_8def8a:
	mov_s r1,0x23
L_8def8c:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_8def8e:
	bl.d L_8c82c0
L_8def92:
	mov_s r3,0xee
L_8def94:
	ldw_s r3,[r13]
	.global L_8def96
L_8def96:
	mov_s r2,0x1010afc
L_8def9c:
	lsr_s r3,r3,0x4
L_8def9e:
	mov_s r0,0xd
L_8defa0:
	mov_s r1,0x1
L_8defa2:
	bl.d L_8edfcc
L_8defa6:
	bmsk_s r3,r3,0x3
L_8defa8:
	mov_s r1,0x842ea0
L_8defae:
	ld_s r0,[r1,0x30]
L_8defb0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8defb2:
	st_s r0,[r1,0x30]
L_8defb4:
	bl.d L_8c9538
L_8defb8:
	mov_s r0,r14
L_8defba:
	b L_8c032c
	.global L_8defbe
L_8defbe:
	mov_s r0,blink
L_8defc0:
	mov_s r2,0x1010aec
L_8defc6:
	mov_s r1,0x117e
L_8defcc:
	bl.d L_8c82c0
L_8defd0:
	mov_s r3,0xe0
L_8defd2:
	b_s L_8def50
	.global L_8defd4
L_8defd4:
	mov_s r0,blink
L_8defd6:
	mov_s r2,0x1010aec
L_8defdc:
	mov_s r1,0x117f
L_8defe2:
	bl.d L_8c82c0
L_8defe6:
	mov_s r3,0xe1
L_8defe8:
	b_s L_8def56
L_8defea:
	nop_s
