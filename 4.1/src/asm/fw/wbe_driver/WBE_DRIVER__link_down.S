/* WBE_DRIVER__link_down @ 0x8ed8d8, 352 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WBE_DRIVER::link_down DOCK PERST is 1!!
 *   wbe_driver.cpp
 *   WBE_DRIVER::link_down [is_root=%d] End
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: WBE_DRIVER__CLOSE, WBE_DRIVER__Force, WBE_DRIVER__HOST, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit1, fw_sysassert_fatal, pcie__set_event_bit, rgf_reg_882600, set_reg_882680, set_reg_882680_8ee788
 * Глобалы (через gp): 0x800430
 */
	.section .text.WBE_DRIVER__link_down,"ax",@progbits
	.global WBE_DRIVER__link_down
WBE_DRIVER__link_down:
	.global L_8ed8d8
L_8ed8d8:
	push_s blink
L_8ed8da:
	bl L_8c02c4
L_8ed8de:
	mov.f r13,r0
L_8ed8e2:
	beq_s L_8ed960
L_8ed8e4:
	ld_s r0,[gp,-0x78]
L_8ed8e6:
	mov_s r14,0x0
L_8ed8e8:
	breq_s r0,0,L_8ed8f2
L_8ed8ea:
	bl L_8c7794
L_8ed8ee:
	st.as r14,[gp,-0x1e]
	.global L_8ed8f2
L_8ed8f2:
	bl L_8ee778
L_8ed8f6:
	bl L_8f17d8
L_8ed8fa:
	bl L_8cb698
L_8ed8fe:
	mov_s r0,0xf
L_8ed900:
	bl.d L_8efd50
L_8ed904:
	mov_s r1,0x0
L_8ed906:
	mov_s r1,0x882600
L_8ed90c:
	ld_s r0,[r1,0x54]
L_8ed90e:
	bset_s r0,r0,0x1f
L_8ed910:
	st_s r0,[r1,0x54]
L_8ed912:
	ld_s r0,[r1,0x54]
L_8ed914:
	bmsk_s r0,r0,0x4
L_8ed916:
	brne r0,0x1d,L_8ed92c
L_8ed91a:
	mov r0,0x7d0
L_8ed91e:
	mov lp_count,r0
L_8ed922:
	nop_s
L_8ed924:
	lp L_8ed92c
L_8ed928:
	nop_s
L_8ed92a:
	nop_s
	.global L_8ed92c
L_8ed92c:
	mov_s r1,0x882600
L_8ed932:
	ld_s r0,[r1,0x54]
L_8ed934:
	bset_s r0,r0,0x1f
L_8ed936:
	st_s r0,[r1,0x54]
L_8ed938:
	ld_s r0,[r1,0x54]
L_8ed93a:
	bmsk_s r0,r0,0x4
L_8ed93c:
	brne r0,0x1d,L_8ed954
L_8ed940:
	ld_s r0,[r1,0x54]
L_8ed942:
	and r0,r0,0xffffe0ff
L_8ed94a:
	bset_s r0,r0,0x9
L_8ed94c:
	st_s r0,[r1,0x54]
L_8ed94e:
	ld_s r0,[r1,0x54]
L_8ed950:
	bset_s r0,r0,0x1e
L_8ed952:
	st_s r0,[r1,0x54]
	.global L_8ed954
L_8ed954:
	bl L_8ee788
L_8ed958:
	bl.d L_8cedf0
L_8ed95c:
	mov_s r0,0x3
L_8ed95e:
	b_s L_8eda24
	.global L_8ed960
L_8ed960:
	ld_s r0,[gp,0x2c0]
L_8ed962:
	breq_s r0,0,L_8ed972
L_8ed964:
	mov_s r0,0x882680
L_8ed96a:
	st 0x1000,[r0]
	.global L_8ed972
L_8ed972:
	ld_s r0,[gp,-0x40]
L_8ed974:
	mov_s r14,0x0
L_8ed976:
	breq_s r0,0,L_8ed980
L_8ed978:
	bl L_8c7794
L_8ed97c:
	st.as r14,[gp,-0x10]
	.global L_8ed980
L_8ed980:
	bl L_8ee768
L_8ed984:
	bl L_8ee7c0
L_8ed988:
	bl L_8ee7a4
L_8ed98c:
	bl L_8ee7b4
L_8ed990:
	mov_s r0,0x882000
L_8ed996:
	ld_s r1,[r0,0x38]
L_8ed998:
	mov_s r1,0xe
L_8ed99a:
	st_s r1,[r0,0x38]
L_8ed99c:
	ld.as r2,[r0,0x94]
L_8ed9a0:
	st.as r1,[r0,0x94]
L_8ed9a4:
	mov_s r0,0x9c40
L_8ed9aa:
	mov lp_count,r0
L_8ed9ae:
	nop_s
L_8ed9b0:
	lp L_8ed9b8
L_8ed9b4:
	nop_s
L_8ed9b6:
	nop_s
	.global L_8ed9b8
L_8ed9b8:
	mov_s r0,0xf
L_8ed9ba:
	bl.d L_8efd50
L_8ed9be:
	mov_s r1,0x0
L_8ed9c0:
	mov_s r0,0xf
L_8ed9c2:
	bl.d L_8efd50
L_8ed9c6:
	mov_s r1,0x1
L_8ed9c8:
	mov_s r0,0xf
L_8ed9ca:
	bl.d L_8efd50
L_8ed9ce:
	mov_s r1,0x0
L_8ed9d0:
	mov_s r0,0x882000
L_8ed9d6:
	ld_s r1,[r0,0x38]
L_8ed9d8:
	mov_s r1,0x0
L_8ed9da:
	st_s r1,[r0,0x38]
L_8ed9dc:
	ld.as r1,[r0,0x94]
L_8ed9e0:
	mov_s r1,0x0
L_8ed9e2:
	st.as r1,[r0,0x94]
L_8ed9e6:
	mov_s r1,0x880b00
L_8ed9ec:
	ld_s r0,[r1,0x4]
L_8ed9ee:
	bclr_s r0,r0,0x8
L_8ed9f0:
	st_s r0,[r1,0x4]
L_8ed9f2:
	mov_s r0,0x882b80
L_8ed9f8:
	ld_s r0,[r0,0x8]
L_8ed9fa:
	bbit0 r0,0x0,L_8eda24
L_8ed9fe:
	mov_s r2,0x10033b8
L_8eda04:
	mov_s r0,0xf
L_8eda06:
	bl.d L_8edfb0
L_8eda0a:
	mov_s r1,0x0
L_8eda0c:
	bl L_8c9104
L_8eda10:
	mov_s r0,blink
L_8eda12:
	mov_s r2,0x10032e4
L_8eda18:
	mov_s r1,0x62
L_8eda1a:
	bset_s r1,r1,0xc
L_8eda1c:
	bl.d L_8c82c0
L_8eda20:
	mov r3,0x27e
	.global L_8eda24
L_8eda24:
	mov_s r2,0x10033e0
L_8eda2a:
	mov_s r0,0xf
L_8eda2c:
	mov_s r1,0x2
L_8eda2e:
	bl.d L_8edfcc
L_8eda32:
	mov_s r3,r13
L_8eda34:
	b L_8c0334
