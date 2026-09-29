/* frame_builder__assoc_resp_fix_fields @ 0x8ec754, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ASSOC RESP fix fields are built
 *   frame_builder.cpp
 * Зовут его: mgmt_tx__build_assoc_resp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit0, fw_sysassert_fatal, memcpy_fw, push_cap_info
 */
	.section .text.frame_builder__assoc_resp_fix_fields,"ax",@progbits
	.global frame_builder__assoc_resp_fix_fields
frame_builder__assoc_resp_fix_fields:
	.global L_8ec754
L_8ec754:
	push_s blink
L_8ec756:
	bl L_8c02bc
L_8ec75a:
	sub_s sp,sp,0x4
L_8ec75c:
	mov_s r14,r0
L_8ec75e:
	mov_s r13,r1
L_8ec760:
	mov_s r15,r2
L_8ec762:
	mov_s r2,0x100c0d0
L_8ec768:
	mov_s r0,0xd
L_8ec76a:
	bl.d L_8edfb0
L_8ec76e:
	mov_s r1,0x2
L_8ec770:
	add2 r1,r13,0x17
L_8ec774:
	bl.d L_8ef784
L_8ec778:
	mov_s r0,r14
L_8ec77a:
	extw r16,r0
L_8ec77e:
	ldw r0,[r15, 0xf4]
L_8ec782:
	add r13,r16,r14
L_8ec786:
	stw r0,[sp]
L_8ec78a:
	mov_s r0,r13
L_8ec78c:
	mov_s r1,sp
L_8ec78e:
	bl.d L_8c0460
L_8ec792:
	mov_s r2,0x2
L_8ec794:
	add_s r0,r13,0x2
L_8ec796:
	add r16,r16,0x2
L_8ec79a:
	ldb_s r1,[r15,0x8]
L_8ec79c:
	extw r16,r16
L_8ec7a0:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8ec7a2:
	stw r1,[sp, 0x2]
L_8ec7a6:
	add r1,sp,0x2
L_8ec7aa:
	bl.d L_8c0460
L_8ec7ae:
	mov_s r2,0x2
L_8ec7b0:
	/* add_s r13,0x4 */
	.byte 0x04,0xe5
L_8ec7b2:
	add r15,r16,0x2
L_8ec7b6:
	extw_s r15,r15
L_8ec7b8:
	sub_s r13,r13,r14
L_8ec7ba:
	brne r15,r13,L_8ec7c6
	.global L_8ec7be
L_8ec7be:
	mov_s r0,r15
L_8ec7c0:
	b.d L_8c0324
L_8ec7c4:
	add_s sp,sp,0x4
	.global L_8ec7c6
L_8ec7c6:
	mov_s r0,blink
L_8ec7c8:
	mov_s r2,0x100baf4
L_8ec7ce:
	mov_s r1,0x11d3
L_8ec7d4:
	bl.d L_8c82c0
L_8ec7d8:
	mov r3,0x1dc
L_8ec7dc:
	b_s L_8ec7be
L_8ec7de:
	nop_s
