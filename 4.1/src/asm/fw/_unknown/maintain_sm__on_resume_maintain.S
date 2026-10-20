/* maintain_sm__on_resume_maintain @ 0x8efc78, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__inject_event, maintain_sm__reschedule_task, schedule_long_term_trigger
 * Глобалы (через gp): 0x80020f
 */
	.section .text.maintain_sm__on_resume_maintain,"ax",@progbits
	.global maintain_sm__on_resume_maintain
maintain_sm__on_resume_maintain:
L_8efc78:
	push_s blink
L_8efc7a:
	bl L_8c02c0
L_8efc7e:
	mov_s r13,r0
L_8efc80:
	ld_s r0,[gp,-0x6c]
L_8efc82:
	breq_s r0,0,L_8efcbc
L_8efc84:
	mov_s r14,0x0
L_8efc86:
	st.as r14,[gp,-0x1b]
L_8efc8a:
	add3 r0,r13,0xa
L_8efc8e:
	mov_s r1,0x5
L_8efc90:
	mov_s r2,r14
L_8efc92:
	mov_s r3,r14
L_8efc94:
	bl.d L_8d6a1c
L_8efc98:
	mov_s r4,r14
L_8efc9a:
	add3 r15,r13,0x10
L_8efc9e:
	ld_s r0,[r15,0x48]
L_8efca0:
	breq_s r0,0,L_8efcb0
L_8efca2:
	ldb r1,[r13, 0x3d]
L_8efca6:
	mov_s r0,r13
L_8efca8:
	bl.d L_8dfa80
L_8efcac:
	ld_s r2,[r15,0x40]
L_8efcae:
	st_s r14,[r15,0x48]
	.global L_8efcb0
L_8efcb0:
	ldb_s r0,[gp,0x9f]
L_8efcb2:
	cmp_s r0,0x0
L_8efcb4:
	bl.ne.d L_8df9fc
L_8efcb8:
	mov.ne r0,r13
	.global L_8efcbc
L_8efcbc:
	b L_8c032c
