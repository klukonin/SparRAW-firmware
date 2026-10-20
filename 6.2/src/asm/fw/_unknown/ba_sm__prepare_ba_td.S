/* ba_sm__prepare_ba_td @ 0x8e0d6c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ring__init_desc
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mem_pool__allocate
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__prepare_ba_td
ba_sm__prepare_ba_td:
	.global L_8e0d6c
L_8e0d6c:
	push_s blink
L_8e0d6e:
	bl L_8c01e0
L_8e0d72:
	mov_s r13,r0
L_8e0d74:
	mov_s r15,r1
L_8e0d76:
	ld_s r14,[r0,0x4]
L_8e0d78:
	b_s L_8e0d84
	.global L_8e0d7a
L_8e0d7a:
	mov_s r0,0x0
	.global L_8e0d7c
L_8e0d7c:
	st_s r0,[r14,0x4]
L_8e0d7e:
	mov_s r0,0x0
L_8e0d80:
	st.ab r0,[r14,0x8]
	.global L_8e0d84
L_8e0d84:
	ld_s r0,[r13,0x8]
L_8e0d86:
	brhs r14,r0,L_8e0d96
L_8e0d8a:
	brne r15,0x1,L_8e0d7a
L_8e0d8e:
	bl.d L_8c354c
L_8e0d92:
	ld_s r0,[r13,0x10]
L_8e0d94:
	b_s L_8e0d7c
	.global L_8e0d96
L_8e0d96:
	b L_8c024c
L_8e0d9a:
	nop_s
