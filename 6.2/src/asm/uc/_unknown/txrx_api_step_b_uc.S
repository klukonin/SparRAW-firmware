/* txrx_api_step_b_uc @ 0x936acc, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x00_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mac_clk__div165
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txrx_api_step_b_uc
txrx_api_step_b_uc:
	.global L_936acc
L_936acc:
	push_s blink
L_936ace:
	bl L_920230
L_936ad2:
	mov_s r13,r0
L_936ad4:
	ldw_s r0,[r0]
L_936ad6:
	mov_s r14,0x802968
L_936adc:
	bl.d L_936b94
L_936ae0:
	mov_s r1,r14
L_936ae2:
	ldw_s r0,[r13]
L_936ae4:
	mov_s r15,0x886d00
L_936aea:
	add1_s r0,r0,r0
L_936aec:
	bl.d L_936b94
L_936af0:
	add r1,r14,0xc
L_936af4:
	ldw_s r0,[r13,0x4]
L_936af6:
	bl.d L_936b94
L_936afa:
	add_s r1,r14,0x2
L_936afc:
	ldw_s r0,[r14]
L_936afe:
	or r0,r0,0x1730000
L_936b06:
	st_s r0,[r15]
L_936b08:
	ldw_s r0,[r14,0x2]
L_936b0a:
	bset_s r0,r0,0x16
L_936b0c:
	bset_s r0,r0,0x18
L_936b0e:
	bset_s r0,r0,0x19
L_936b10:
	st_s r0,[r15,0x4]
L_936b12:
	mov r0,0x452
L_936b16:
	st_s r0,[r15,0x14]
L_936b18:
	ldw_s r1,[r13]
L_936b1a:
	ldw_s r0,[r13,0x4]
L_936b1c:
	add_s r0,r0,r1
L_936b1e:
	bl.d L_936b94
L_936b22:
	add_s r1,r14,0x4
L_936b24:
	ldw_s r0,[r13,0x4]
L_936b26:
	asl_s r0,r0
L_936b28:
	bl.d L_936b94
L_936b2c:
	add_s r1,r14,0x6
L_936b2e:
	ldw_s r1,[r14,0x6]
L_936b30:
	ldw_s r0,[r14,0x4]
L_936b32:
	asl_s r1,r1,0x10
L_936b34:
	or_s r0,r0,r1
L_936b36:
	st_s r0,[r15,0x8]
L_936b38:
	ldw_s r0,[r13,0x6]
L_936b3a:
	bl.d L_936b94
L_936b3e:
	add r1,r14,0x8
L_936b42:
	ldw_s r0,[r13,0x8]
L_936b44:
	bl.d L_936b94
L_936b48:
	add r1,r14,0xa
L_936b4c:
	ldw_s r1,[r14,0xa]
L_936b4e:
	ldw_s r0,[r14,0x8]
L_936b50:
	asl_s r1,r1,0x10
L_936b52:
	or_s r0,r0,r1
L_936b54:
	st_s r0,[r15,0xc]
L_936b56:
	mov r0,0x100
L_936b5a:
	st_s r0,[r15,0x10]
L_936b5c:
	b L_92029c
