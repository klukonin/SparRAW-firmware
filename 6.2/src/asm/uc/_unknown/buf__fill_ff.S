/* buf__fill_ff @ 0x92ecc8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot_uc__init_more, ucode_cmd_28__apply
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memset_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global buf__fill_ff
buf__fill_ff:
	.global L_92ecc8
L_92ecc8:
	push_s blink
L_92ecca:
	bl.d L_920234
L_92ecce:
	mov_s r1,0xff
L_92ecd0:
	mov_s r13,r0
L_92ecd2:
	mov_s r14,0x0
L_92ecd4:
	st.ab r14,[r0,0x24]
L_92ecd8:
	bl.d L_92d834
L_92ecdc:
	mov_s r2,0x5
L_92ecde:
	add r0,r13,0x29
L_92ece2:
	mov_s r1,0xff
L_92ece4:
	bl.d L_92d834
L_92ece8:
	mov_s r2,0x5
L_92ecea:
	st_s r14,[r13,0x4]
L_92ecec:
	st_s r14,[r13,0x8]
L_92ecee:
	st_s r14,[r13,0xc]
L_92ecf0:
	st_s r14,[r13,0x10]
L_92ecf2:
	st_s r14,[r13,0x14]
L_92ecf4:
	st_s r14,[r13,0x18]
L_92ecf6:
	st_s r14,[r13,0x1c]
L_92ecf8:
	b.d L_9202a4
L_92ecfc:
	st_s r14,[r13,0x20]
L_92ecfe:
	nop_s
