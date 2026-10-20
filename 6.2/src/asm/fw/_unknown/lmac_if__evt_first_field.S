/* lmac_if__evt_first_field @ 0x8c65fc, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__evt_walk
 * Зовёт сам: __ld_r13_to_r13_ret, fw_divmod_signed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__evt_first_field
lmac_if__evt_first_field:
	.global L_8c65fc
L_8c65fc:
	push_s blink
L_8c65fe:
	push_s r13
L_8c6600:
	mov_s r13,r0
L_8c6602:
	ldb_s r0,[r0]
L_8c6604:
	ld_s r1,[r13,0x4]
L_8c6606:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c6608:
	bl.d L_8c02dc
L_8c660c:
	ldb_s r1,[r1,0x1]
L_8c660e:
	extb_s r0,r1
L_8c6610:
	cmp_s r0,0x0
L_8c6612:
	stb_s r1,[r13]
L_8c6614:
	mov_s r0,0x1
L_8c6616:
	b.d L_8c025c
L_8c661a:
	sub_s.ne r0,r0,r0
