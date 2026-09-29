/* get_rx_pkt_phy_data_cmd_complete @ 0x8f38cc, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   get_rx_pkt_phy_data_cmd_complete: FAILED - NULL argument
 * Зовут его: get_rx_pkt_phy_data_cmd_start
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, fw_sysapi_mgr__send_evt2host, fw_sysapi_mgr__stop_sysapi_cmd, fw_sysassert_fatal, memset0_words, sysapi_mgr__stats_lut_find_index
 * Глобалы (через gp): 0x800227
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global get_rx_pkt_phy_data_cmd_complete
get_rx_pkt_phy_data_cmd_complete:
	.global L_8f38cc
L_8f38cc:
	push_s blink
L_8f38ce:
	bl L_8c01dc
L_8f38d2:
	sub_s sp,sp,0x28
L_8f38d4:
	mov_s r13,r0
L_8f38d6:
	ldb_s r0,[gp,0xa3]
L_8f38d8:
	mov_s r14,r1
L_8f38da:
	asr_s r0,r0
L_8f38dc:
	add r16,r0,0x5
L_8f38e0:
	mov_s r0,sp
L_8f38e2:
	bl.d L_8c1cd8
L_8f38e6:
	mov_s r1,0x28
L_8f38e8:
	mov r15,-0x23
L_8f38ec:
	brne_s r14,0,L_8f38fc
L_8f38ee:
	mov_s r1,0x1012aac
L_8f38f4:
	bl.d L_8dcba8
L_8f38f8:
	mov_s r0,0x0
L_8f38fa:
	b_s L_8f3972
	.global L_8f38fc
L_8f38fc:
	ld_s r0,[r13,0x20]
L_8f38fe:
	brne r0,0x1,L_8f3958
L_8f3902:
	ld_s r1,[r14]
L_8f3904:
	ld_s r0,[r14,0x4]
L_8f3906:
	st_s r1,[sp,0x0]
L_8f3908:
	st_s r0,[sp,0x4]
L_8f390a:
	ld_s r1,[r14,0x8]
L_8f390c:
	mov_s r0,0x800508
L_8f3912:
	ldb_s r0,[r0]
L_8f3914:
	st_s r1,[sp,0x8]
L_8f3916:
	sub_s r15,r15,r0
L_8f3918:
	sub r15,r15,r16
L_8f391c:
	ld_s r0,[r14,0x18]
L_8f391e:
	add_s r15,r15,0x11
L_8f3920:
	add_s r0,r0,r15
L_8f3922:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8f3924:
	add_s r0,r0,r1
L_8f3926:
	st_s r0,[sp,0xc]
L_8f3928:
	bl.d L_8f2038
L_8f392c:
	mov_s r0,r13
L_8f392e:
	st_s r0,[sp,0x14]
L_8f3930:
	ldb r0,[r14, 0x22]
L_8f3934:
	stb r0,[sp, 0x25]
L_8f3938:
	ld_s r0,[r14,0xc]
L_8f393a:
	st_s r0,[sp,0x18]
L_8f393c:
	ld_s r0,[r14,0x14]
L_8f393e:
	ld_s r1,[r14,0x10]
L_8f3940:
	mul64 r0,0xd1
L_8f3944:
	mov_s r0,mlo
L_8f3946:
	mul64 r1,0x34
L_8f394a:
	add_s r0,r0,mlo
L_8f394c:
	st_s r0,[sp,0x1c]
L_8f394e:
	ld_s r0,[r14,0x1c]
L_8f3950:
	st_s r0,[sp,0x20]
L_8f3952:
	ldb r0,[r14, 0x20]
L_8f3956:
	stb_s r0,[sp,0x24]
	.global L_8f3958
L_8f3958:
	mov_s r0,r13
L_8f395a:
	bl.d L_8f9bd0
L_8f395e:
	mov_s r1,0x3
L_8f3960:
	breq_s r0,0,L_8f3978
	.global L_8f3962
L_8f3962:
	ld_s r1,[r13,0x20]
L_8f3964:
	mov_s r2,sp
L_8f3966:
	add r4,r13,0x4
L_8f396a:
	mov_s r0,r13
L_8f396c:
	bl.d L_8f8948
L_8f3970:
	mov_s r3,0x28
	.global L_8f3972
L_8f3972:
	b.d L_8c0244
L_8f3976:
	add_s sp,sp,0x28
	.global L_8f3978
L_8f3978:
	mov_s r0,blink
L_8f397a:
	mov_s r1,0x1453
L_8f3980:
	bl L_8c9b28
L_8f3984:
	b_s L_8f3962
L_8f3986:
	nop_s
