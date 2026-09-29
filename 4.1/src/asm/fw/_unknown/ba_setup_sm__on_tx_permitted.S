/* ba_setup_sm__on_tx_permitted @ 0x8f031c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: ba_sm__send_addba_req
 */
	.section .text.ba_setup_sm__on_tx_permitted,"ax",@progbits
	.global ba_setup_sm__on_tx_permitted
ba_setup_sm__on_tx_permitted:
L_8f031c:
	add r2,r0,0x20
L_8f0320:
	ldb_s r1,[r2,0xd]
L_8f0322:
	mov_s r3,r0
L_8f0324:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8f0326:
	extb_s r1,r1
L_8f0328:
	ldb r4,[r2, 0x1e]
L_8f032c:
	stb_s r1,[r2,0xd]
L_8f032e:
	ld_s r0,[r0,0x44]
L_8f0330:
	ldb_s r2,[r2,0x1c]
L_8f0332:
	b.d L_8e0564
L_8f0336:
	ldw r3,[r3, 0x40]
L_8f033a:
	nop_s
