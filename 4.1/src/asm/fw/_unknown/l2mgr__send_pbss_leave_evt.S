/* l2mgr__send_pbss_leave_evt @ 0x8f0720, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_PBSS_LEAVE_EVENTID pbss leave event done. CID: %d
 * Зовут его: l2mgr__disconnect_done
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, memcpy_fw, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_pbss_leave_evt,"ax",@progbits
	.global l2mgr__send_pbss_leave_evt
l2mgr__send_pbss_leave_evt:
	.global L_8f0720
L_8f0720:
	push_s blink
L_8f0722:
	bl L_8c02c0
L_8f0726:
	bl.d L_8c2b68
L_8f072a:
	mov_s r13,r0
L_8f072c:
	mov_s r14,r0
L_8f072e:
	ld_s r0,[r13,0xc]
L_8f0730:
	add r1,r13,0x10
L_8f0734:
	ld_s r0,[r0,0x14]
L_8f0736:
	stb_s r0,[r14,0x6]
L_8f0738:
	ldb_s r15,[r13,0x8]
L_8f073a:
	mov_s r0,r14
L_8f073c:
	stb_s r15,[r14,0x7]
L_8f073e:
	bl.d L_8c0460
L_8f0742:
	mov_s r2,0x6
L_8f0744:
	mov_s r2,0x100c2ec
L_8f074a:
	mov_s r0,0xb
L_8f074c:
	mov_s r1,0x2
L_8f074e:
	bl.d L_8edfcc
L_8f0752:
	mov_s r3,r15
L_8f0754:
	ld_s r3,[r13,0xc]
L_8f0756:
	mov_s r0,r14
L_8f0758:
	mov_s r1,0x16
L_8f075a:
	mov_s r2,0xa
L_8f075c:
	ldb_s r3,[r3,0x10]
L_8f075e:
	mov r4,0x0
L_8f0762:
	bl.d L_8e0874
L_8f0766:
	mov r5,r4
L_8f076a:
	b L_8c032c
L_8f076e:
	nop_s
