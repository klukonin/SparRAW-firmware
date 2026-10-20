/* mac_mode__enter_idle_seq @ 0x932644, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_pm__enter_idle
 * Зовёт сам: __ld_r13_ret_uc, hw_modes_mac__switch_core, rfc__issue_cmd_10
 */
	.section .text.mac_mode__enter_idle_seq,"ax",@progbits
	.global mac_mode__enter_idle_seq
mac_mode__enter_idle_seq:
	.global L_932644
L_932644:
	push_s blink
L_932646:
	push_s r13
L_932648:
	bl.d L_927944
L_93264c:
	mov_s r13,r0
L_93264e:
	mov_s r0,0x8009cc
L_932654:
	ld_s r0,[r0,0x18]
L_932656:
	bbit0 r0,0x0,L_932674
L_93265a:
	mov_s r0,0x83
L_93265c:
	asl_s r0,r0,0x19
L_93265e:
	mov_s r32,r0
L_932660:
	st.ab r0,[r25,0x4]
L_932664:
	bclr r25,r25,0xa
L_932668:
	nop_s
L_93266a:
	nop_s
L_93266c:
	nop_s
L_93266e:
	bl.d L_92bbe0
L_932672:
	ld_s r0,[gp,-0x10]
	.global L_932674
L_932674:
	mov_s r0,0x3d000001
L_93267a:
	mov_s r32,r0
L_93267c:
	st.ab r0,[r25,0x4]
L_932680:
	bclr r25,r25,0xa
L_932684:
	nop_s
L_932686:
	nop_s
L_932688:
	nop_s
L_93268a:
	mov_s r0,0x3d000002
L_932690:
	mov_s r32,r0
L_932692:
	st.ab r0,[r25,0x4]
L_932696:
	bclr r25,r25,0xa
L_93269a:
	nop_s
L_93269c:
	nop_s
L_93269e:
	nop_s
L_9326a0:
	breq r13,0x0,L_932700
L_9326a4:
	mov_s r0,0x8009cc
L_9326aa:
	ld_s r0,[r0,0x1c]
L_9326ac:
	brne_s r0,0,L_9326da
L_9326ae:
	mov_s r0,0x800fcc
L_9326b4:
	ldb r0,[r0, 0x68]
L_9326b8:
	brne_s r0,0,L_9326da
L_9326ba:
	mov_s r0,0x0
L_9326bc:
	bset_s r0,r0,0x18
L_9326be:
	mov_s r32,r0
L_9326c0:
	st.ab r0,[r25,0x4]
L_9326c4:
	bclr r25,r25,0xa
L_9326c8:
	mov_s r0,0x20c0010
L_9326ce:
	mov_s r32,r0
L_9326d0:
	st.ab r0,[r25,0x4]
L_9326d4:
	bclr r25,r25,0xa
L_9326d8:
	b_s L_932700
	.global L_9326da
L_9326da:
	mov_s r0,0x10
L_9326dc:
	bset_s r0,r0,0x18
L_9326de:
	mov_s r32,r0
L_9326e0:
	st.ab r0,[r25,0x4]
L_9326e4:
	bclr r25,r25,0xa
L_9326e8:
	mov_s r0,0x83
L_9326ea:
	asl_s r0,r0,0x12
L_9326ec:
	mov_s r32,r0
L_9326ee:
	st.ab r0,[r25,0x4]
L_9326f2:
	bclr r25,r25,0xa
L_9326f6:
	mov_s r1,0x0
L_9326f8:
	mov_s r0,0x886d00
L_9326fe:
	st_s r1,[r0,0x38]
	.global L_932700
L_932700:
	b L_92028c
