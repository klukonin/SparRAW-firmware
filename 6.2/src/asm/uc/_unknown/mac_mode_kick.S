/* mac_mode_kick @ 0x92c018, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_ctx__dispatch_by_role
 * Зовёт сам: mac_ifs__restore_sifs, mac_mode_program_c, uc_spin_until_event4
 * Глобалы (через gp): 0x8005be
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_mode_kick
mac_mode_kick:
	.global L_92c018
L_92c018:
	st.a r13,[sp,-0x8]
L_92c01c:
	ldw.as r3,[gp,0x4b]
L_92c020:
	ldw r1,[0x802974]
L_92c028:
	st blink,[sp, 0x4]
L_92c02c:
	breq.d r3,r1,L_92c05c
L_92c030:
	mov r13,r0
L_92c034:
	stw.as r1,[gp,0x4b]
L_92c038:
	or r1,r1,0x1730000
L_92c040:
	st r1,[0x886d00]
L_92c048:
	sync
L_92c04c:
	mov_s r2,0x38000200
L_92c052:
	mov_s r32,r2
L_92c054:
	st.ab r2,[r25,0x4]
L_92c058:
	bclr r25,r25,0xa
	.global L_92c05c
L_92c05c:
	bl.d L_9366d0
L_92c060:
	mov r0,0x140
L_92c064:
	mov r2,r54
L_92c068:
	bbit0 r2,0x6,L_92c080
L_92c06c:
	bl.d L_92bfc0
L_92c070:
	mov r0,r13
L_92c074:
	ld blink,[sp, 0x4]
L_92c078:
	j.d [blink]
L_92c07c:
	ld.ab r13,[sp,0x8]
	.global L_92c080
L_92c080:
	mov_s r0,0x49000100
L_92c086:
	mov_s r32,r0
L_92c088:
	st.ab r0,[r25,0x4]
L_92c08c:
	bclr r25,r25,0xa
L_92c090:
	bl.d L_92c09c
L_92c094:
	mov r0,r13
L_92c098:
	b_s L_92c05c
L_92c09a:
	nop_s
