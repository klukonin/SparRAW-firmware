/* mac__program_rf_mode @ 0x9296c8, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: grant_detect_step, mac_mode__switch_core_and_rf, mac_mode_program_a, mac_mode_program_b, pm__event_mask_restore, pm__event_mask_save_all_on, shallow_sleep_rfc_step, ucode_cmd__rx_on
 */
	.section .text.mac__program_rf_mode,"ax",@progbits
	.global mac__program_rf_mode
mac__program_rf_mode:
	.global L_9296c8
L_9296c8:
	st.a r13,[sp,-0x8]
L_9296cc:
	st_s r14,[sp,0x4]
L_9296ce:
	mov_s r14,blink
L_9296d0:
	mov_s r13,r0
L_9296d2:
	mov_s r3,0x1f000601
L_9296d8:
	mov r32,r3
L_9296dc:
	st.ab r3,[r25,0x4]
L_9296e0:
	bclr r25,r25,0xa
L_9296e4:
	ld.as r1,[gp,-0x11]
L_9296e8:
	and r1,r1,0xffff0fff
L_9296f0:
	st.as r1,[gp,-0x11]
L_9296f4:
	or r1,r1,0x1d000000
L_9296fc:
	mov r32,r1
L_929700:
	st.ab r1,[r25,0x4]
L_929704:
	bclr r25,r25,0xa
L_929708:
	nop_s
L_92970a:
	nop_s
L_92970c:
	mov 0x0,0x0
	.global L_929710
L_929710:
	bmsk r0,r40,0x2
L_929714:
	brne r0,0x5,L_929710
L_929718:
	brne r13,0x1,L_92972c
L_92971c:
	mov_s r2,0x1f003000
L_929722:
	mov_s r32,r2
L_929724:
	st.ab r2,[r25,0x4]
L_929728:
	bclr r25,r25,0xa
	.global L_92972c
L_92972c:
	mov_s blink,r14
L_92972e:
	ld_s r14,[sp,0x4]
L_929730:
	j.d [blink]
L_929734:
	ld.ab r13,[sp,0x8]
