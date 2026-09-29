/* radio_mgr__reset_and_lock_secondary @ 0x8e9570, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: RADIO_MGR__lock_secondary, __ld_r13_ret
 */
	.section .text.radio_mgr__reset_and_lock_secondary,"ax",@progbits
	.global radio_mgr__reset_and_lock_secondary
radio_mgr__reset_and_lock_secondary:
	.byte 0x4f
	.byte 0xeb
	.global sub_8e9572
sub_8e9572:
L_8e9572:
	nop_s
L_8e9574:
	push_s blink
L_8e9576:
	push_s r13
L_8e9578:
	mov_s r13,r0
L_8e957a:
	mov lp_count,0x8
L_8e957e:
	mov_s r1,0x0
L_8e9580:
	lp L_8e9590
L_8e9584:
	mov_s r2,0x8
L_8e9586:
	add r0,r13,0x2c
L_8e958a:
	add_s r0,r0,r1
L_8e958c:
	stb_s r2,[r0]
L_8e958e:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8e9590
L_8e9590:
	ld_s r0,[r13,0x34]
L_8e9592:
	mov_s r1,r13
L_8e9594:
	ld_s r0,[r0,0x6c]
L_8e9596:
	mov_s r3,0xffff
L_8e959c:
	ldb r4,[r0, 0x10]
L_8e95a0:
	mov_s r0,0x2fbf4
L_8e95a6:
	bl.d L_8d938c
L_8e95aa:
	mov_s r2,0x0
L_8e95ac:
	b.d L_8c033c
L_8e95b0:
	st_s r0,[r13,0x38]
L_8e95b2:
	nop_s
