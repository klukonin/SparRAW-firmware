/* mailbox_debug_dump_uc @ 0x92d608, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mailbox_debug_dump: m_ctrl->ring_tail_ptr - 0x%x, m_ctrl->ring_head_ptr - 0x%x
 *   mailbox_debug_dump: m_work_ptr - 0x%x, m_ring_base - 0x%x
 *   mailbox_debug_dump: sync entry
 *                      [0x%x]       [0x%x]
 * Зовут его: uc_evt__queue_put
 * Зовёт сам: uc_log__emit2, uc_log__emit_snapshot
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mailbox_debug_dump_uc
mailbox_debug_dump_uc:
	.global L_92d608
L_92d608:
	st.a r13,[sp,-0x10]
L_92d60c:
	st blink,[sp, 0x4]
L_92d610:
	st_s r14,[sp,0x8]
L_92d612:
	mov_s r14,r0
L_92d614:
	ld r4,[r0, 0xc]
L_92d618:
	mov_s r1,0x10011e0
L_92d61e:
	ld r2,[r4, 0x8]
L_92d622:
	mov_s r0,0x0
L_92d624:
	bl.d L_92d27c
L_92d628:
	ld r3,[r4, 0xc]
L_92d62c:
	mov_s r1,0x1001230
L_92d632:
	ld_s r2,[r14]
L_92d634:
	mov r0,0x0
L_92d638:
	bl.d L_92d27c
L_92d63c:
	ld r3,[r14, 0x4]
L_92d640:
	mov r1,0x100126c
L_92d648:
	bl.d L_92d13c
L_92d64c:
	mov r0,0x0
L_92d650:
	ld_s r13,[r14,0x4]
L_92d652:
	ld_s r2,[r14,0x8]
L_92d654:
	brhs.d r13,r2,L_92d678
L_92d658:
	st_s r15,[sp,0xc]
L_92d65a:
	mov_s r15,0x100128c
	.global L_92d660
L_92d660:
	ld_s r2,[r13]
L_92d662:
	mov_s r0,0x0
L_92d664:
	mov r1,r15
L_92d668:
	bl.d L_92d27c
L_92d66c:
	ld r3,[r13, 0x4]
L_92d670:
	ld_s r3,[r14,0x8]
L_92d672:
	add_s r13,r13,0x8
L_92d674:
	brlo r13,r3,L_92d660
	.global L_92d678
L_92d678:
	ld blink,[sp, 0x4]
L_92d67c:
	ld_s r14,[sp,0x8]
L_92d67e:
	ld_s r15,[sp,0xc]
L_92d680:
	j.d [blink]
L_92d684:
	ld.ab r13,[sp,0x10]
