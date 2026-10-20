/* ie__push_raw @ 0x8ef898, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   frame_builder.cpp
 * Зовут его: mgmt_tx__append_probe_resp_ies, mgmt_tx__assoc_req_ies, mgmt_tx__probe_req_ies
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, memcpy_fw
 */
	.section .text.ie__push_raw,"ax",@progbits
	.global ie__push_raw
ie__push_raw:
	.global L_8ef898
L_8ef898:
	push_s blink
L_8ef89a:
	bl L_8c02bc
L_8ef89e:
	mov.f r13,r1
L_8ef8a2:
	mov_s r16,r0
L_8ef8a4:
	beq_s L_8ef8bc
	.global L_8ef8a6
L_8ef8a6:
	ldb_s r2,[r13,0x1]
L_8ef8a8:
	brlt r2,0x1,L_8ef8d4
L_8ef8ac:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8ef8ae:
	mov_s r0,r16
L_8ef8b0:
	bl.d L_8c0460
L_8ef8b4:
	mov_s r1,r13
L_8ef8b6:
	ldb_s r0,[r13,0x1]
L_8ef8b8:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8ef8ba:
	b_s L_8ef8d6
	.global L_8ef8bc
L_8ef8bc:
	mov_s r0,blink
L_8ef8be:
	mov_s r2,0x100baf4
L_8ef8c4:
	mov_s r1,0x11d4
L_8ef8ca:
	bl.d L_8c82c0
L_8ef8ce:
	mov r3,0x5c2
L_8ef8d2:
	b_s L_8ef8a6
	.global L_8ef8d4
L_8ef8d4:
	mov_s r0,0x0
	.global L_8ef8d6
L_8ef8d6:
	b L_8c0324
L_8ef8da:
	nop_s
