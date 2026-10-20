/* ps__notify_awake_peers @ 0x930098, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_dti__wake_and_evaluate_sleep
 * Зовёт сам: ps__program_awake_peers_mask, uc_send_evt__ps_awake_peer
 */
	.section .text.ps__notify_awake_peers,"ax",@progbits
	.global ps__notify_awake_peers
ps__notify_awake_peers:
	.global L_930098
L_930098:
	st.a r13,[sp,-0xc]
L_93009c:
	st blink,[sp, 0x4]
L_9300a0:
	st_s r14,[sp,0x8]
L_9300a2:
	ldb r2,[0x85726c]
L_9300aa:
	mov_s r13,r0
L_9300ac:
	sub sp,sp,0x4
L_9300b0:
	brne.d r2,0x0,L_9300d0
L_9300b4:
	mov r14,0x0
L_9300b8:
	mov r4,0x5a000000
L_9300c0:
	mov r32,r4
L_9300c4:
	st.ab r4,[r25,0x4]
L_9300c8:
	bclr r25,r25,0xa
L_9300cc:
	b L_930104
	.global L_9300d0
L_9300d0:
	mov_s r3,0x5a001000
L_9300d6:
	mov_s r32,r3
L_9300d8:
	st.ab r3,[r25,0x4]
L_9300dc:
	bclr r25,r25,0xa
L_9300e0:
	mov_s r0,0x0
L_9300e2:
	stb r0,[sp, 0x1]
L_9300e6:
	stb r0,[sp, 0x2]
L_9300ea:
	stb_s r14,[sp,0x0]
L_9300ec:
	mov r1,0x2
L_9300f0:
	stb r1,[sp, 0x3]
L_9300f4:
	bl.d L_925ba4
L_9300f8:
	mov r0,sp
L_9300fc:
	bl.d L_92fff0
L_930100:
	mov r0,r13
	.global L_930104
L_930104:
	add_s sp,sp,0x4
L_930106:
	ld blink,[sp, 0x4]
L_93010a:
	ld_s r14,[sp,0x8]
L_93010c:
	j.d [blink]
L_930110:
	ld.ab r13,[sp,0xc]
