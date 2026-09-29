/* rx_flow__check_ppdu_and_ctx @ 0x92f0ec, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__bump_stat_and_kick, rx_flow__check_status, rx_flow__decide_imm_ack, rx_flow__lookup_mcs_ctx
 */
	.section .text.rx_flow__check_ppdu_and_ctx,"ax",@progbits
	.global rx_flow__check_ppdu_and_ctx
rx_flow__check_ppdu_and_ctx:
L_92f0ec:
	mov r4,r36
L_92f0f0:
	mov_s r2,r38
L_92f0f2:
	bbit1 r2,0xf,L_92f11c
L_92f0f6:
	ld r3,[0x801a78]
L_92f0fe:
	ld r1,[0x801418]
L_92f106:
	ld_s r2,[r3]
L_92f108:
	brne r1,r2,L_92f11c
	.global L_92f10c
L_92f10c:
	mov_s r0,0x1
L_92f10e:
	ld blink,[sp, 0x4]
L_92f112:
	ld_s r14,[sp,0x8]
L_92f114:
	j.d [blink]
L_92f118:
	ld.ab r13,[sp,0xc]
	.global L_92f11c
L_92f11c:
	ld blink,[sp, 0x4]
L_92f120:
	mov_s r0,r13
L_92f122:
	ld_s r14,[sp,0x8]
L_92f124:
	j.d [blink]
L_92f128:
	ld.ab r13,[sp,0xc]
