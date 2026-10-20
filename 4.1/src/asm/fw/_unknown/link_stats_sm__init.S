/* link_stats_sm__init @ 0x8d5bcc, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: maintain_sm__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__setup
 */
	.section .text.link_stats_sm__init,"ax",@progbits
	.global link_stats_sm__init
link_stats_sm__init:
	.global L_8d5bcc
L_8d5bcc:
	push_s blink
L_8d5bce:
	bl.d L_8c02c0
L_8d5bd2:
	mov r6,0x6
L_8d5bd6:
	mov_s r14,r0
L_8d5bd8:
	mov_s r15,r1
L_8d5bda:
	mov r4,0x80133c
L_8d5be2:
	ld.as r1,[gp,-0x6]
L_8d5be6:
	mov_s r13,0x0
L_8d5be8:
	mov_s r2,r13
L_8d5bea:
	mov_s r3,0x802834
L_8d5bf0:
	mov r5,0x8004bc
L_8d5bf8:
	bl.d L_8d6478
L_8d5bfc:
	mov r7,0x2
L_8d5c00:
	st_s r13,[r14,0x2c]
L_8d5c02:
	st_s r13,[r14,0x30]
L_8d5c04:
	b.d L_8c032c
L_8d5c08:
	st_s r15,[r14,0x34]
L_8d5c0a:
	nop_s
