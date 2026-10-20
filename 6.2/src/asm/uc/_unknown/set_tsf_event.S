/* set_tsf_event @ 0x935680, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   set_tsf_event()
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow
 * Зовёт сам: uc_log__emit_snapshot
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global set_tsf_event
set_tsf_event:
	.global L_935680
L_935680:
	st.a r13,[sp,-0x8]
L_935684:
	st_s r14,[sp,0x4]
L_935686:
	mov_s r14,blink
L_935688:
	mov_s r13,r0
L_93568a:
	mov_s r1,0x1000f80
L_935690:
	bl.d L_92d13c
L_935694:
	mov r0,0x20
L_935698:
	mov_s r2,0x40
L_93569a:
	bset_s r2,r2,0x19
L_93569c:
	mov r32,r2
L_9356a0:
	st.ab r2,[r25,0x4]
L_9356a4:
	bclr r25,r25,0xa
L_9356a8:
	ld_s r3,[r13]
L_9356aa:
	mov_s r1,0x887000
L_9356b0:
	st.as r3,[r1,-0xb4]
L_9356b4:
	ld_s r0,[r13,0x4]
L_9356b6:
	mov_s blink,r14
L_9356b8:
	st.as r0,[r1,-0xb3]
L_9356bc:
	st.as 0xc0050,[r1,-0xb2]
L_9356c4:
	ld_s r14,[sp,0x4]
L_9356c6:
	j_s.d [blink]
L_9356c8:
	ld.ab r13,[sp,0x8]
