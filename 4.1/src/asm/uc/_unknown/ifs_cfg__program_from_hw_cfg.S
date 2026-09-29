/* ifs_cfg__program_from_hw_cfg @ 0x931bd0, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x00_handler
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, us_from_ticks165
 */
	.section .text.ifs_cfg__program_from_hw_cfg,"ax",@progbits
	.global ifs_cfg__program_from_hw_cfg
ifs_cfg__program_from_hw_cfg:
	.global L_931bd0
L_931bd0:
	push_s blink
L_931bd2:
	bl L_920210
L_931bd6:
	mov_s r13,r0
L_931bd8:
	ldw_s r0,[r0]
L_931bda:
	mov_s r14,0x801a08
L_931be0:
	bl.d L_931c98
L_931be4:
	mov_s r1,r14
L_931be6:
	ldw_s r0,[r13]
L_931be8:
	mov_s r15,0x886d00
L_931bee:
	add1_s r0,r0,r0
L_931bf0:
	bl.d L_931c98
L_931bf4:
	add r1,r14,0xc
L_931bf8:
	ldw_s r0,[r13,0x4]
L_931bfa:
	bl.d L_931c98
L_931bfe:
	add_s r1,r14,0x2
L_931c00:
	ldw_s r0,[r14]
L_931c02:
	or r0,r0,0x1730000
L_931c0a:
	st_s r0,[r15]
L_931c0c:
	ldw_s r0,[r14,0x2]
L_931c0e:
	bset_s r0,r0,0x16
L_931c10:
	bset_s r0,r0,0x18
L_931c12:
	bset_s r0,r0,0x19
L_931c14:
	st_s r0,[r15,0x4]
L_931c16:
	mov r0,0x452
L_931c1a:
	st_s r0,[r15,0x14]
L_931c1c:
	ldw_s r1,[r13]
L_931c1e:
	ldw_s r0,[r13,0x4]
L_931c20:
	add_s r0,r0,r1
L_931c22:
	bl.d L_931c98
L_931c26:
	add_s r1,r14,0x4
L_931c28:
	ldw_s r0,[r13,0x4]
L_931c2a:
	asl_s r0,r0
L_931c2c:
	bl.d L_931c98
L_931c30:
	add_s r1,r14,0x6
L_931c32:
	ldw_s r1,[r14,0x6]
L_931c34:
	ldw_s r0,[r14,0x4]
L_931c36:
	asl_s r1,r1,0x10
L_931c38:
	or_s r0,r0,r1
L_931c3a:
	st_s r0,[r15,0x8]
L_931c3c:
	ldw_s r0,[r13,0x6]
L_931c3e:
	bl.d L_931c98
L_931c42:
	add r1,r14,0x8
L_931c46:
	ldw_s r0,[r13,0x8]
L_931c48:
	bl.d L_931c98
L_931c4c:
	add r1,r14,0xa
L_931c50:
	ldw_s r1,[r14,0xa]
L_931c52:
	ldw_s r0,[r14,0x8]
L_931c54:
	asl_s r1,r1,0x10
L_931c56:
	or_s r0,r0,r1
L_931c58:
	st_s r0,[r15,0xc]
L_931c5a:
	mov r0,0x100
L_931c5e:
	st_s r0,[r15,0x10]
L_931c60:
	b L_92027c
