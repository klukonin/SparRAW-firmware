/* maintain_sm__on_pause @ 0x8eea24, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__inject_event, u_schd__cancel
 */
	.section .text.maintain_sm__on_pause,"ax",@progbits
	.global maintain_sm__on_pause
maintain_sm__on_pause:
L_8eea24:
	push_s blink
L_8eea26:
	bl L_8c02c0
L_8eea2a:
	mov_s r14,r0
L_8eea2c:
	ld_s r0,[gp,-0x6c]
L_8eea2e:
	brne_s r0,0,L_8eea64
L_8eea30:
	mov_s r15,0x1
L_8eea32:
	ld_s r0,[r14,0x40]
L_8eea34:
	mov_s r13,0x0
L_8eea36:
	st.as r15,[gp,-0x1b]
L_8eea3a:
	st r13,[r14, 0xc8]
L_8eea3e:
	breq_s r0,0,L_8eea4a
L_8eea40:
	bl L_8c7794
L_8eea44:
	st_s r13,[r14,0x40]
L_8eea46:
	st r15,[r14, 0xc8]
	.global L_8eea4a
L_8eea4a:
	ld_s r0,[r14,0x44]
L_8eea4c:
	breq_s r0,0,L_8eea54
L_8eea4e:
	bl L_8c7794
L_8eea52:
	st_s r13,[r14,0x44]
	.global L_8eea54
L_8eea54:
	add3 r0,r14,0xa
L_8eea58:
	mov_s r1,0x4
L_8eea5a:
	mov_s r2,0x0
L_8eea5c:
	mov_s r3,r2
L_8eea5e:
	bl.d L_8d6a1c
L_8eea62:
	mov_s r4,r2
	.global L_8eea64
L_8eea64:
	b L_8c032c
