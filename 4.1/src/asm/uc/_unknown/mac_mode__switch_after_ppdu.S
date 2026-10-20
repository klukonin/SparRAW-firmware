/* mac_mode__switch_after_ppdu @ 0x92b848, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__handle_ppdu_report
 * Зовёт сам: __ld_r13_ret_uc, hw_modes_mac__switch_core
 */
	.section .text.mac_mode__switch_after_ppdu,"ax",@progbits
	.global mac_mode__switch_after_ppdu
mac_mode__switch_after_ppdu:
	.global L_92b848
L_92b848:
	push_s blink
L_92b84a:
	push_s r13
L_92b84c:
	mov_s r13,r0
L_92b84e:
	mov_s r0,0x83
L_92b850:
	asl_s r0,r0,0x19
L_92b852:
	mov_s r32,r0
L_92b854:
	st.ab r0,[r25,0x4]
L_92b858:
	bclr r25,r25,0xa
L_92b85c:
	mov_s r0,0x3d000002
L_92b862:
	mov_s r32,r0
L_92b864:
	st.ab r0,[r25,0x4]
L_92b868:
	bclr r25,r25,0xa
L_92b86c:
	mov_s r0,0x2
L_92b86e:
	mov lp_count,r0
L_92b872:
	nop_s
L_92b874:
	lp L_92b87c
L_92b878:
	nop_s
L_92b87a:
	nop_s
	.global L_92b87c
L_92b87c:
	mov_s r0,0x3d000100
L_92b882:
	mov_s r32,r0
L_92b884:
	st.ab r0,[r25,0x4]
L_92b888:
	bclr r25,r25,0xa
L_92b88c:
	mov_s r0,0x1f006000
L_92b892:
	mov_s r32,r0
L_92b894:
	st.ab r0,[r25,0x4]
L_92b898:
	bclr r25,r25,0xa
L_92b89c:
	bl L_927944
L_92b8a0:
	mov_s r0,0x1f000601
L_92b8a6:
	mov_s r32,r0
L_92b8a8:
	st.ab r0,[r25,0x4]
L_92b8ac:
	bclr r25,r25,0xa
L_92b8b0:
	mov_s r0,0x3c000200
L_92b8b6:
	mov_s r32,r0
L_92b8b8:
	st.ab r0,[r25,0x4]
L_92b8bc:
	bclr r25,r25,0xa
L_92b8c0:
	mov_s r0,0x38000300
L_92b8c6:
	mov_s r32,r0
L_92b8c8:
	st.ab r0,[r25,0x4]
L_92b8cc:
	bclr r25,r25,0xa
L_92b8d0:
	mov_s r0,0x3600003f
L_92b8d6:
	mov_s r32,r0
L_92b8d8:
	st.ab r0,[r25,0x4]
L_92b8dc:
	bclr r25,r25,0xa
L_92b8e0:
	mov_s r0,0x6000103
L_92b8e6:
	mov_s r32,r0
L_92b8e8:
	st.ab r0,[r25,0x4]
L_92b8ec:
	bclr r25,r25,0xa
L_92b8f0:
	or r13,r13,0x3f000000
L_92b8f8:
	mov_s r32,r13
L_92b8fa:
	st.ab r13,[r25,0x4]
L_92b8fe:
	bclr r25,r25,0xa
L_92b902:
	b L_92028c
L_92b906:
	nop_s
