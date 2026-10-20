/* bi__decide_beacon_kind @ 0x9311a4, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__kind_switch
 * Зовёт сам: bti_transmitter_bi2_flow, bti_worker__bti_transmitter_beacon_sweep_flow, perform_bti_pm_cfg, uc_tx__is_idle
 * Глобалы (через gp): 0x8005a0
 */
	.section .text.bi__decide_beacon_kind,"ax",@progbits
	.global bi__decide_beacon_kind
bi__decide_beacon_kind:
	.global L_9311a4
L_9311a4:
	st.a r13,[sp,-0x8]
L_9311a8:
	st_s r14,[sp,0x4]
L_9311aa:
	mov_s r14,blink
L_9311ac:
	mov_s r13,r0
L_9311ae:
	st_s r1,[r0]
L_9311b0:
	mov r2,0x5
L_9311b4:
	brne.d r1,0x0,L_9311c8
L_9311b8:
	stb_s r2,[r0,0x4]
L_9311ba:
	mov_s r3,0x1
L_9311bc:
	stb r3,[0x801e68]
L_9311c4:
	ld r1,[r13]
	.global L_9311c8
L_9311c8:
	brne r1,0x0,L_9311ec
L_9311cc:
	bl L_936b2c
L_9311d0:
	mov r0,0x801ed0
L_9311d8:
	bl.d L_92ac60
L_9311dc:
	ld.as r1,[gp,0x1e]
L_9311e0:
	mov r4,0x0
L_9311e4:
	b.d L_9311f4
L_9311e8:
	st.as r4,[gp,0x1e]
	.global L_9311ec
L_9311ec:
	mov r5,0x1
L_9311f0:
	st.as r5,[gp,0x1e]
	.global L_9311f4
L_9311f4:
	ld r1,[0x801438]
L_9311fc:
	breq_s r1,0,L_931250
L_9311fe:
	mov_s r3,0xf000001
L_931204:
	mov r32,r3
L_931208:
	st.ab r3,[r25,0x4]
L_93120c:
	bclr r25,r25,0xa
L_931210:
	ld.as r2,[gp,-0x11]
L_931214:
	and r2,r2,0xfffff0ff
L_93121c:
	or r3,r2,0x300
L_931224:
	or r2,r2,0x1d000300
L_93122c:
	st.as r3,[gp,-0x11]
L_931230:
	mov r32,r2
L_931234:
	st.ab r2,[r25,0x4]
L_931238:
	bclr r25,r25,0xa
L_93123c:
	nop_s
L_93123e:
	nop_s
L_931240:
	nop_s
L_931242:
	mov r4,r41
L_931246:
	bbit0 r4,0x1e,L_931250
L_93124a:
	ld_s r0,[r13]
L_93124c:
	brne r0,0x1,L_93125c
	.global L_931250
L_931250:
	bl.d L_923c74
L_931254:
	mov r0,r13
L_931258:
	b L_931264
	.global L_93125c
L_93125c:
	bl.d L_923de0
L_931260:
	mov r0,r13
	.global L_931264
L_931264:
	ldb_s r0,[r13,0x4]
L_931266:
	mov_s blink,r14
L_931268:
	ld_s r14,[sp,0x4]
L_93126a:
	j_s.d [blink]
L_93126c:
	ld.ab r13,[sp,0x8]
