/* lmac_if__send_init_cfg_cmd @ 0x8d8550, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__send_init_cfg
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_if__alloc_mbox_slot, memcpy_fw, send_cmd2_lmac
 */
	.section .text.lmac_if__send_init_cfg_cmd,"ax",@progbits
	.global lmac_if__send_init_cfg_cmd
lmac_if__send_init_cfg_cmd:
	.global L_8d8550
L_8d8550:
	push_s blink
L_8d8552:
	bl L_8c02bc
L_8d8556:
	mov_s r14,r0
L_8d8558:
	mov_s r15,r1
L_8d855a:
	mov_s r0,0x803e3c
L_8d8560:
	bl.d L_8c2c38
L_8d8564:
	mov_s r16,r2
L_8d8566:
	mov.f r13,r0
L_8d856a:
	beq_s L_8d85c8
L_8d856c:
	mov_s r0,0x803e84
L_8d8572:
	ldb_s r0,[r0]
L_8d8574:
	stw_s r15,[r13,0x30]
L_8d8576:
	st_s r0,[r13,0x40]
L_8d8578:
	mov_s r0,0xa5
L_8d857a:
	stw_s r0,[r13,0x36]
L_8d857c:
	stw_s r0,[r13,0x38]
L_8d857e:
	mov r0,0x339
L_8d8582:
	stw_s r0,[r13,0x34]
L_8d8584:
	stw r16,[r13, 0x32]
L_8d8588:
	mov_s r0,r13
L_8d858a:
	mov_s r1,r14
L_8d858c:
	bl.d L_8c0460
L_8d8590:
	mov_s r2,0xc
L_8d8592:
	ld_s r0,[r14,0x10]
L_8d8594:
	ld_s r1,[r14,0xc]
L_8d8596:
	st_s r0,[r13,0x10]
L_8d8598:
	st_s r1,[r13,0xc]
L_8d859a:
	ld_s r0,[r14,0x18]
L_8d859c:
	ld_s r1,[r14,0x14]
L_8d859e:
	st_s r0,[r13,0x20]
L_8d85a0:
	st_s r1,[r13,0x1c]
L_8d85a2:
	ld_s r0,[r14,0x20]
L_8d85a4:
	ld_s r1,[r14,0x1c]
L_8d85a6:
	st_s r0,[r13,0x28]
L_8d85a8:
	ld_s r0,[r13,0x2c]
L_8d85aa:
	st_s r1,[r13,0x24]
L_8d85ac:
	bic r0,r0,0xf
L_8d85b0:
	bset_s r0,r0,0x3
L_8d85b2:
	st_s r0,[r13,0x2c]
L_8d85b4:
	mov_s r0,0x4
L_8d85b6:
	stw_s r0,[r13,0x3c]
L_8d85b8:
	mov_s r0,0x2
L_8d85ba:
	stw_s r0,[r13,0x3e]
L_8d85bc:
	mov_s r0,r13
L_8d85be:
	mov_s r1,0x0
L_8d85c0:
	mov_s r2,0x44
L_8d85c2:
	bl.d L_8e0694
L_8d85c6:
	mov_s r3,r1
	.global L_8d85c8
L_8d85c8:
	b L_8c0324
