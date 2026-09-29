/* bi_manager__run_rx_flow_by_kind @ 0x928730, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bi_manager.cpp
 * Зовут его: l1_task__entry
 * Зовёт сам: bi_ap_mon_if__trigger, bi_manager__rx_flow_kind0, bi_manager__rx_flow_kind1, bi_manager__rx_flow_kind2, uc_sysassert
 */
	.section .text.bi_manager__run_rx_flow_by_kind,"ax",@progbits
	.global bi_manager__run_rx_flow_by_kind
bi_manager__run_rx_flow_by_kind:
	.global L_928730
L_928730:
	st.a r13,[sp,-0x8]
L_928734:
	ld r1,[r0, 0x38]
L_928738:
	st blink,[sp, 0x4]
L_92873c:
	breq.d r1,0x0,L_928760
L_928740:
	mov_s r13,0x0
L_928742:
	breq r1,0x1,L_928768
L_928746:
	breq r1,0x2,L_928774
L_92874a:
	mov_s r0,blink
L_92874c:
	mov_s r2,0x1002b80
L_928752:
	mov_s r1,0x65
L_928754:
	bl.d L_925548
L_928758:
	mov r3,0x69
L_92875c:
	b L_928780
	.global L_928760
L_928760:
	bl L_928798
L_928764:
	b L_92877c
	.global L_928768
L_928768:
	bl.d L_92879c
L_92876c:
	add r0,r0,0x20
L_928770:
	b L_92877c
	.global L_928774
L_928774:
	bl.d L_9287e8
L_928778:
	add r0,r0,0x24
	.global L_92877c
L_92877c:
	mov r13,r0
	.global L_928780
L_928780:
	mov r0,0x5
L_928784:
	bl.d L_9304c8
L_928788:
	mov r1,r13
L_92878c:
	ld blink,[sp, 0x4]
L_928790:
	j.d [blink]
L_928794:
	ld.ab r13,[sp,0x8]
