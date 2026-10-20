/* scan_mngr__connect @ 0x8ea86c, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::connect()
 *   scan_mngr::connect() Link UP request to: ADDR-%04X%08X
 *   scan_mngr::connect() in active scan mode
 * Зовут его: scan_mngr__start_connection_cb
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, fw_log__emit2, mid__acquire_link, scan_mngr__prob_done
 */
	.section .text.scan_mngr__connect,"ax",@progbits
	.global scan_mngr__connect
scan_mngr__connect:
	.global L_8ea86c
L_8ea86c:
	push_s blink
L_8ea86e:
	bl L_8c02c0
L_8ea872:
	sub_s sp,sp,0x20
L_8ea874:
	mov_s r14,r0
L_8ea876:
	mov_s r13,r1
L_8ea878:
	mov_s r2,0x1013db0
L_8ea87e:
	mov_s r0,0x9
L_8ea880:
	bl.d L_8edfb0
L_8ea884:
	mov_s r1,0x2
L_8ea886:
	mov_s r2,0x1013dc8
L_8ea88c:
	ld r4,[r13, 0x8]
L_8ea890:
	mov_s r0,0x9
L_8ea892:
	mov_s r1,0x2
L_8ea894:
	bl.d L_8edff8
L_8ea898:
	ldw_s r3,[r13,0xc]
L_8ea89a:
	ldb r0,[r13, 0x38]
L_8ea89e:
	mov_s r15,0x0
L_8ea8a0:
	cmp_s r0,0x2
L_8ea8a2:
	mov.ne r3,r15
L_8ea8a6:
	mov.ne r2,r15
L_8ea8aa:
	bne_s L_8ea8ca
L_8ea8ac:
	mov_s r2,0x1013e00
L_8ea8b2:
	mov_s r0,0x9
L_8ea8b4:
	bl.d L_8edfb0
L_8ea8b8:
	mov_s r1,0x2
L_8ea8ba:
	ldb r0,[r13, 0x31]
L_8ea8be:
	mov_s r3,0x1
L_8ea8c0:
	stb r0,[sp, 0x6]
L_8ea8c4:
	ld_s r0,[r13,0x34]
L_8ea8c6:
	mov_s r2,sp
L_8ea8c8:
	st_s r0,[sp,0x0]
	.global L_8ea8ca
L_8ea8ca:
	add r1,r13,0x8
L_8ea8ce:
	bl.d L_8d7814
L_8ea8d2:
	ld_s r0,[r14,0x7c]
L_8ea8d4:
	st_s r0,[r13,0x3c]
L_8ea8d6:
	cmp_s r0,0x0
L_8ea8d8:
	mov.eq r0,r14
L_8ea8dc:
	mov.eq r1,0x1
L_8ea8e0:
	bl.eq.d L_8ef034
L_8ea8e4:
	mov.eq r2,r13
L_8ea8e8:
	b.d L_8c032c
