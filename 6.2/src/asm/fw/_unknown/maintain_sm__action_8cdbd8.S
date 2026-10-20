/* maintain_sm__action_8cdbd8 @ 0x8cdbd8, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, process_expected_bf_results, schedule_long_term_trigger
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__action_8cdbd8
maintain_sm__action_8cdbd8:
	.global L_8cdbd8
L_8cdbd8:
	push_s blink
L_8cdbda:
	push_s r13
L_8cdbdc:
	mov_s r13,r0
L_8cdbde:
	ld_s r0,[r1,0x8]
L_8cdbe0:
	brne_s r0,0,L_8cdc04
L_8cdbe2:
	ldb_s r1,[r1,0xd]
L_8cdbe4:
	stb_s r1,[r13,0x19]
L_8cdbe6:
	bl.d L_8e11f8
L_8cdbea:
	mov_s r0,r13
L_8cdbec:
	ldb_s r1,[r13,0x19]
L_8cdbee:
	mov_s r2,0x0
L_8cdbf0:
	ld_s r0,[r13,0x6c]
L_8cdbf2:
	st_s r2,[r13,0x78]
L_8cdbf4:
	cmp_s r0,r1
L_8cdbf6:
	mov.ls r0,r1
L_8cdbfa:
	st_s r0,[r13,0x6c]
L_8cdbfc:
	bl.d L_8e476c
L_8cdc00:
	mov_s r0,r13
L_8cdc02:
	b_s L_8cdc14
	.global L_8cdc04
L_8cdc04:
	mov_s r0,0x1
L_8cdc06:
	stb_s r0,[r13,0x19]
L_8cdc08:
	ld_s r0,[r13,0x74]
L_8cdc0a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cdc0c:
	st_s r0,[r13,0x74]
L_8cdc0e:
	ld_s r0,[r13,0x78]
L_8cdc10:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cdc12:
	st_s r0,[r13,0x78]
	.global L_8cdc14
L_8cdc14:
	b L_8c025c
