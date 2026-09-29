/* bi_tx_initiator_wrap @ 0x932844, 432 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__start_tx_or_initiator
 * Зовёт сам: __ld_r13_ret_uc, bi_tx__program_initiator, rfc_ctrl__switch, sxd_hal__read_backoff_status, tx_initiator_flow, uc_spin_until_event, uc_tx__is_idle
 * Глобалы (через gp): 0x800570, 0x80058c, 0x800604, 0x800608
 */
	.section .text.bi_tx_initiator_wrap,"ax",@progbits
	.global bi_tx_initiator_wrap
bi_tx_initiator_wrap:
	.global L_932844
L_932844:
	push_s blink
L_932846:
	push_s r13
L_932848:
	mov_s r1,0x80090c
L_93284e:
	ldw_s r0,[r1,0x24]
L_932850:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_932852:
	extw_s r0,r0
L_932854:
	stw_s r0,[r1,0x24]
L_932856:
	ld_s r0,[gp,0x64]
L_932858:
	cmp_s r0,0x1
L_93285a:
	mov_s r0,0x1
L_93285c:
	sub_s.ne r0,r0,r0
L_93285e:
	extb.f 0x0,r0
L_932862:
	bne_s L_93288a
L_932864:
	bl.d L_931aec
L_932868:
	mov_s r0,0x2
L_93286a:
	mov_s r0,0x81
L_93286c:
	asl_s r0,r0,0x12
L_93286e:
	mov_s r32,r0
L_932870:
	st.ab r0,[r25,0x4]
L_932874:
	bclr r25,r25,0xa
L_932878:
	bl L_936b2c
L_93287c:
	mov_s r1,0x8009ec
L_932882:
	ld_s r0,[r1,0xc]
L_932884:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_932886:
	st_s r0,[r1,0xc]
L_932888:
	b_s L_9329ee
	.global L_93288a
L_93288a:
	mov_s r1,0x801458
L_932890:
	ld_s r0,[r1]
L_932892:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_932894:
	st_s r0,[r1]
L_932896:
	mov_s r1,0x0
L_932898:
	mov_s r0,0x800664
L_93289e:
	st_s r1,[r0]
L_9328a0:
	st_s r1,[r0,0x4]
L_9328a2:
	st.as r1,[gp,0x12]
L_9328a6:
	mov_s r0,0x14000100
L_9328ac:
	mov_s r32,r0
L_9328ae:
	st.ab r0,[r25,0x4]
L_9328b2:
	bclr r25,r25,0xa
L_9328b6:
	bl L_9337c8
L_9328ba:
	mov_s r0,0x800664
L_9328c0:
	ld_s r2,[r0]
L_9328c2:
	mov_s r0,0x801a18
L_9328c8:
	mov_s r1,0x854980
L_9328ce:
	breq_s r2,0,L_932900
L_9328d0:
	ld_s r0,[r0,0x60]
L_9328d2:
	ld_s r0,[r0]
L_9328d4:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9328d6:
	add3_s r0,r0,r0
L_9328d8:
	add_s r1,r1,r0
L_9328da:
	ld_s r0,[r1,0x4]
L_9328dc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9328de:
	st_s r0,[r1,0x4]
L_9328e0:
	bl.d L_9317fc
L_9328e4:
	mov_s r0,0x80
L_9328e6:
	ld_s r0,[gp,-0x3c]
L_9328e8:
	brne r0,0x1,L_932900
L_9328ec:
	ld_s r0,[gp,-0x38]
L_9328ee:
	brne_s r0,0,L_932900
L_9328f0:
	mov_s r0,0x1f000601
L_9328f6:
	mov_s r32,r0
L_9328f8:
	st.ab r0,[r25,0x4]
L_9328fc:
	bclr r25,r25,0xa
	.global L_932900
L_932900:
	mov_s r0,0x801a18
L_932906:
	ld_s r1,[r0,0x60]
L_932908:
	mov_s r2,0x8015f8
L_93290e:
	ld_s r0,[r1]
L_932910:
	ld.as r3,[r2,r0]
L_932914:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_932916:
	add3_s r0,r0,r0
L_932918:
	add r2,r0,0x854988
L_932920:
	mov_s r0,0x0
L_932922:
	st.as r0,[gp,-0xe]
L_932926:
	mov_s r0,0x800664
L_93292c:
	ld_s r0,[r0,0x4]
L_93292e:
	st_s r3,[r2]
L_932930:
	breq_s r0,0,L_932942
L_932932:
	ld_s r1,[r1]
L_932934:
	brhs r1,0x8,L_932942
L_932938:
	ldb_s r0,[gp,-0xe6]
L_93293a:
	bset r0,r0,r1
L_93293e:
	stb r0,[gp, -0xe6]
	.global L_932942
L_932942:
	ld_s r0,[gp,0xe0]
L_932944:
	bbit1 r0,0x9,L_932958
L_932948:
	mov_s r0,0x14000100
L_93294e:
	mov_s r32,r0
L_932950:
	st.ab r0,[r25,0x4]
L_932954:
	bclr r25,r25,0xa
	.global L_932958
L_932958:
	ldw_s r0,[gp,0xdc]
L_93295a:
	or r0,r0,0xdb0000
L_932962:
	mov_s r32,r0
L_932964:
	st.ab r0,[r25,0x4]
L_932968:
	bclr r25,r25,0xa
L_93296c:
	ld_s r0,[gp,0xdc]
L_93296e:
	lsr_s r0,r0,0x10
L_932970:
	or r0,r0,0xdb0000
L_932978:
	mov_s r32,r0
L_93297a:
	st.ab r0,[r25,0x4]
L_93297e:
	bclr r25,r25,0xa
L_932982:
	ldw_s r0,[gp,0xe0]
L_932984:
	or r0,r0,0xdb0000
L_93298c:
	mov_s r32,r0
L_93298e:
	st.ab r0,[r25,0x4]
L_932992:
	bclr r25,r25,0xa
L_932996:
	ld_s r0,[gp,0xe0]
L_932998:
	lsr_s r0,r0,0x10
L_93299a:
	or r0,r0,0xdb0000
L_9329a2:
	mov_s r32,r0
L_9329a4:
	st.ab r0,[r25,0x4]
L_9329a8:
	bclr r25,r25,0xa
L_9329ac:
	mov_s r0,0x81
L_9329ae:
	asl_s r0,r0,0x12
L_9329b0:
	mov_s r32,r0
L_9329b2:
	st.ab r0,[r25,0x4]
L_9329b6:
	bclr r25,r25,0xa
L_9329ba:
	bl L_9377bc
L_9329be:
	mov_s r13,0x8014dc
L_9329c4:
	ld_s r0,[r13,0x8]
L_9329c6:
	cmp_s r0,0x0
L_9329c8:
	mov.eq r1,0xff
L_9329d0:
	bl.eq.d L_92b9d0
L_9329d4:
	mov.eq r0,0x2
L_9329d8:
	mov_s r0,0x0
L_9329da:
	st_s r0,[r13,0x8]
L_9329dc:
	st.as r0,[gp,0x37]
L_9329e0:
	st.as r0,[gp,0x38]
L_9329e4:
	mov_s r1,0x801a18
L_9329ea:
	st_s r0,[r1,0xc]
L_9329ec:
	st_s r0,[r1,0x3c]
	.global L_9329ee
L_9329ee:
	b L_92028c
L_9329f2:
	nop_s
