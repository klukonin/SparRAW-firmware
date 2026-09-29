/* maintain_sm__action_8e0004 @ 0x8e0004, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__action_8e0004
maintain_sm__action_8e0004:
	.global L_8e0004
L_8e0004:
	push_s blink
L_8e0006:
	bl L_8c01e0
L_8e000a:
	mov_s r14,r0
L_8e000c:
	ld_s r0,[gp,-0x80]
L_8e000e:
	brne_s r0,0,L_8e0044
L_8e0010:
	mov_s r15,0x1
L_8e0012:
	st.as r15,[gp,-0x20]
L_8e0016:
	ld_s r0,[r14,0x1c]
L_8e0018:
	mov_s r13,0x0
L_8e001a:
	st r13,[r14, 0x80]
L_8e001e:
	breq_s r0,0,L_8e002a
L_8e0020:
	bl L_8c8de0
L_8e0024:
	st_s r13,[r14,0x1c]
L_8e0026:
	st r15,[r14, 0x80]
	.global L_8e002a
L_8e002a:
	ld_s r0,[r14,0x20]
L_8e002c:
	breq_s r0,0,L_8e0034
L_8e002e:
	bl L_8c8de0
L_8e0032:
	st_s r13,[r14,0x20]
	.global L_8e0034
L_8e0034:
	add r0,r14,0x2c
L_8e0038:
	mov_s r1,0x4
L_8e003a:
	mov_s r2,0x0
L_8e003c:
	mov_s r3,r2
L_8e003e:
	bl.d L_8d9b6c
L_8e0042:
	mov_s r4,r2
	.global L_8e0044
L_8e0044:
	b L_8c024c
