/* dashboard__add_connection @ 0x8eabfc, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm__association_done
 * Зовёт сам: __ld_r13_to_r13_ret, bits__set32_s29_w3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dashboard__add_connection
dashboard__add_connection:
	.global L_8eabfc
L_8eabfc:
	push_s blink
L_8eabfe:
	push_s r13
L_8eac00:
	mov.f r13,r0
L_8eac04:
	beq_s L_8eac3c
	.global L_8eac06
L_8eac06:
	ldb_s r13,[r13,0x8]
L_8eac08:
	brge r13,0x8,L_8eac4a
	.global L_8eac0c
L_8eac0c:
	mov_s r2,0x853900
L_8eac12:
	ld_s r0,[r2,0x18]
L_8eac14:
	mov_s r3,0x853920
L_8eac1a:
	lsr_s r0,r0,0x1d
L_8eac1c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8eac1e:
	bmsk r1,r0,0x2
L_8eac22:
	add r0,r2,0x18
L_8eac26:
	bl L_8ed4c0
L_8eac2a:
	ldb_s r0,[r3]
L_8eac2c:
	brne_s r0,0,L_8eac32
L_8eac2e:
	mov_s r1,0x0
L_8eac30:
	st_s r1,[r2,0x10]
	.global L_8eac32
L_8eac32:
	bset r0,r0,r13
L_8eac36:
	b.d L_8c025c
L_8eac3a:
	stb_s r0,[r3]
	.global L_8eac3c
L_8eac3c:
	mov_s r0,blink
L_8eac3e:
	mov_s r1,0x1119
L_8eac44:
	bl L_8c9b28
L_8eac48:
	b_s L_8eac06
	.global L_8eac4a
L_8eac4a:
	mov_s r0,blink
L_8eac4c:
	mov_s r1,0x111a
L_8eac52:
	bl L_8c9b28
L_8eac56:
	b_s L_8eac0c
