/* tx_probe__send_probe_req @ 0x8f09c4, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending probe req len %d
 *   tx_probe.cpp
 * Зовут его: scan_mngr__send_prob_req
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit1, fw_sysassert_fatal, log_hexdump, tx_api__send_mgmt, tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req
 */
	.section .text.tx_probe__send_probe_req,"ax",@progbits
	.global tx_probe__send_probe_req
tx_probe__send_probe_req:
	.global L_8f09c4
L_8f09c4:
	push_s blink
L_8f09c6:
	bl.d L_8c02b0
L_8f09ca:
	mov_s r5,r1
L_8f09cc:
	mov_s r16,r0
L_8f09ce:
	mov_s r18,r2
L_8f09d0:
	mov_s r17,r3
L_8f09d2:
	mov r19,r4
L_8f09d6:
	mov_s r0,0x0
L_8f09d8:
	push_s r0
L_8f09da:
	mov_s r1,sp
L_8f09dc:
	mov_s r0,r16
L_8f09de:
	mov_s r2,r5
L_8f09e0:
	mov_s r3,r18
L_8f09e2:
	bl.d L_8e4cbc
L_8f09e6:
	mov r4,r17
L_8f09ea:
	ld_s r0,[sp,0x0]
L_8f09ec:
	breq_s r0,0,L_8f0a34
	.global L_8f09ee
L_8f09ee:
	mov_s r2,0x1014100
L_8f09f4:
	mov_s r0,0xd
L_8f09f6:
	mov_s r1,0x2
L_8f09f8:
	bl.d L_8edfcc
L_8f09fc:
	ld_s r3,[sp,0x0]
L_8f09fe:
	mov_s r0,r16
L_8f0a00:
	bl.d L_8c7f90
L_8f0a04:
	ld_s r1,[sp,0x0]
L_8f0a06:
	mov_s r0,r18
L_8f0a08:
	ldw r4,[sp]
L_8f0a0c:
	mov_s r2,0x1
L_8f0a0e:
	ld r1,[r17, 0x10]
L_8f0a12:
	mov_s r3,r16
L_8f0a14:
	mov r5,r19
L_8f0a18:
	bl.d L_8e0c44
L_8f0a1c:
	mov r6,0x0
L_8f0a20:
	mov_s r1,0x843104
L_8f0a26:
	ld_s r0,[r1,0x4]
L_8f0a28:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f0a2a:
	st_s r0,[r1,0x4]
L_8f0a2c:
	mov_s r0,0x0
L_8f0a2e:
	b.d L_8c030c
L_8f0a32:
	add_s sp,sp,0x4
	.global L_8f0a34
L_8f0a34:
	mov_s r0,blink
L_8f0a36:
	mov_s r2,0x101411c
L_8f0a3c:
	mov_s r1,0x1251
L_8f0a42:
	bl.d L_8c82c0
L_8f0a46:
	mov_s r3,0x2b
L_8f0a48:
	b_s L_8f09ee
L_8f0a4a:
	nop_s
