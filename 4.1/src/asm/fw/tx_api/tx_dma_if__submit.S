/* tx_dma_if__submit @ 0x8ca6ec, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/tx_api.h
 *   tx_dma_if.cpp
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_sysassert_fatal, llist__insert, llist__pop_front, rm_ch_switch_sm__bump_turn, tx_desc_by_index, vring__reg_write_locked_0c, vring__reg_write_locked_20
 */
	.section .text.tx_dma_if__submit,"ax",@progbits
	.global tx_dma_if__submit
tx_dma_if__submit:
L_8ca6ec:
	push_s blink
L_8ca6ee:
	bl L_8c02ac
L_8ca6f2:
	sub_s sp,sp,0x8
L_8ca6f4:
	mov_s r16,r0
L_8ca6f6:
	mov_s r20,r1
L_8ca6f8:
	mov_s r19,r2
L_8ca6fa:
	ld_s r0,[r0,0x18]
L_8ca6fc:
	mov_s r12,0x1
L_8ca6fe:
	asl r0,r12,r0
L_8ca702:
	mov_s r1,0x0
L_8ca704:
	bl.d L_8cd64c
L_8ca708:
	mov_s r17,r1
L_8ca70a:
	add r14,r16,0x4
L_8ca70e:
	b_s L_8ca788
	.global L_8ca710
L_8ca710:
	bmsk r18,r1,0x2
L_8ca714:
	bclr_s r1,r1,0x8
L_8ca716:
	ld_s r13,[r0,0x14]
L_8ca718:
	st_s r1,[r0,0x1c]
L_8ca71a:
	st r17,[r0, 0x14]
L_8ca71e:
	ld_s r0,[r0,0x10]
L_8ca720:
	bset_s r13,r13,0x12
L_8ca722:
	lsr_s r0,r0,0x10
L_8ca724:
	bmsk_s r0,r0,0x4
L_8ca726:
	mov_s r15,sp
L_8ca728:
	bset_s r13,r13,0x17
L_8ca72a:
	brne r0,0x19,L_8ca736
L_8ca72e:
	ld_s r0,[gp,-0x138]
L_8ca730:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ca732:
	st.as r0,[gp,-0x4e]
	.global L_8ca736
L_8ca736:
	brne_s r13,0,L_8ca74c
L_8ca738:
	mov_s r0,blink
L_8ca73a:
	mov_s r2,0x10159a4
L_8ca740:
	mov_s r1,0x11e9
L_8ca746:
	bl.d L_8c82c0
L_8ca74a:
	mov_s r3,0xab
	.global L_8ca74c
L_8ca74c:
	st_s r13,[r15,0x4]
L_8ca74e:
	sub_s r13,r13,0x1c
L_8ca750:
	st_s r13,[r15]
L_8ca752:
	ld_s r13,[sp,0x0]
L_8ca754:
	stb r18,[r13, 0x11]
L_8ca758:
	bl.d L_8de2d4
L_8ca75c:
	mov_s r0,r19
L_8ca75e:
	breq r13,r0,L_8ca776
L_8ca762:
	mov_s r0,blink
L_8ca764:
	mov_s r2,0x1015994
L_8ca76a:
	mov_s r1,0x1228
L_8ca770:
	bl.d L_8c82c0
L_8ca774:
	mov_s r3,0x5d
	.global L_8ca776
L_8ca776:
	mov_s r0,r20
L_8ca778:
	bl.d L_8c1fc4
L_8ca77c:
	mov_s r1,r13
L_8ca77e:
	add r1,r14,0x8
L_8ca782:
	bl.d L_8c6d20
L_8ca786:
	mov_s r0,r14
	.global L_8ca788
L_8ca788:
	mov_s r0,r14
L_8ca78a:
	bl.d L_8c9ff8
L_8ca78e:
	ld_s r1,[r14,0x8]
L_8ca790:
	ld_s r1,[r0,0x1c]
L_8ca792:
	bbit1 r1,0x8,L_8ca710
L_8ca796:
	ld r0,[r16, 0x18]
L_8ca79a:
	mov_s r12,0x1
L_8ca79c:
	asl r0,r12,r0
L_8ca7a0:
	bl.d L_8cd67c
L_8ca7a4:
	mov_s r1,0x0
L_8ca7a6:
	b.d L_8c0304
L_8ca7aa:
	add_s sp,sp,0x8
