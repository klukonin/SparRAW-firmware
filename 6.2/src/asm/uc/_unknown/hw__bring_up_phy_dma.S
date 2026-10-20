/* hw__bring_up_phy_dma @ 0x92a980, 448 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__power_sequence_rf
 * Зовёт сам: clk__gate_880b00, dma_mac__cfg_880c14, dma_mac__cfg_880c28, dma_mac__cfg_880c2c, hwd_dma__set_mode_map, hwd_phy__uses_rgf_881000_9296e0, hwd_phy__uses_rgf_881000_929730, hwd_phy_init__2, hwd_phy_pwr, mac__fill_mode_nibbles, mac__set_880afc_bits, mac__set_880bf0_mode
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hw__bring_up_phy_dma
hw__bring_up_phy_dma:
	.global L_92a980
L_92a980:
	st.a r13,[sp,-0xc]
L_92a984:
	st blink,[sp, 0x4]
L_92a988:
	st_s r14,[sp,0x8]
L_92a98a:
	cmp_s r0,0x0
L_92a98c:
	mov r13,r1
L_92a990:
	beq.d L_92aa64
L_92a994:
	ld r1,[r1]
L_92a998:
	bbit0 r1,0x0,L_92a9c8
L_92a99c:
	bl.d L_929730
L_92a9a0:
	mov r0,0x4
L_92a9a4:
	bl.d L_9298f8
L_92a9a8:
	mov r0,0x1
L_92a9ac:
	bl.d L_92961c
L_92a9b0:
	mov r0,0x1
L_92a9b4:
	bl.d L_9296e0
L_92a9b8:
	mov r0,0x1
L_92a9bc:
	bl.d L_9297f0
L_92a9c0:
	mov r0,0x0
L_92a9c4:
	ld r1,[r13]
	.global L_92a9c8
L_92a9c8:
	bbit0 r1,0x1,L_92aa14
L_92a9cc:
	add r14,r13,0x4
L_92a9d0:
	ld r4,[r14]
L_92a9d4:
	bbit0 r4,0x0,L_92a9e4
L_92a9d8:
	bl.d L_929150
L_92a9dc:
	mov r0,0x4
L_92a9e0:
	ld r4,[r14]
	.global L_92a9e4
L_92a9e4:
	bbit0 r4,0x2,L_92a9f4
L_92a9e8:
	bl.d L_929730
L_92a9ec:
	mov r0,0x4
L_92a9f0:
	ld r4,[r14]
	.global L_92a9f4
L_92a9f4:
	bbit0 r4,0x3,L_92aa04
L_92a9f8:
	bl.d L_9294d8
L_92a9fc:
	mov r0,0x4
L_92aa00:
	ld r4,[r14]
	.global L_92aa04
L_92aa04:
	btst r4,0x4
L_92aa08:
	bl.ne.d L_928d78
L_92aa0c:
	mov.ne r0,0x4
L_92aa10:
	ld r1,[r13]
	.global L_92aa14
L_92aa14:
	btst_s r1,0x3
L_92aa16:
	beq_s L_92ab34
L_92aa18:
	ld.a r3,[r13,0x8]
L_92aa1c:
	bbit0 r3,0x0,L_92aa2c
L_92aa20:
	bl.d L_928dcc
L_92aa24:
	mov r0,0x1
L_92aa28:
	ld r3,[r13]
	.global L_92aa2c
L_92aa2c:
	bbit0 r3,0x2,L_92aa3c
L_92aa30:
	bl.d L_92961c
L_92aa34:
	mov r0,0x1
L_92aa38:
	ld r3,[r13]
	.global L_92aa3c
L_92aa3c:
	bbit0 r3,0x3,L_92aa4c
L_92aa40:
	bl.d L_929424
L_92aa44:
	mov r0,0x1
L_92aa48:
	ld r3,[r13]
	.global L_92aa4c
L_92aa4c:
	btst_s r3,0x4
L_92aa4e:
	beq_s L_92ab34
L_92aa50:
	bl.d L_928d40
L_92aa54:
	mov r0,0x1
L_92aa58:
	ld blink,[sp, 0x4]
L_92aa5c:
	ld_s r14,[sp,0x8]
L_92aa5e:
	j_s.d [blink]
L_92aa60:
	ld.ab r13,[sp,0xc]
	.global L_92aa64
L_92aa64:
	bbit0 r1,0x3,L_92aab0
L_92aa68:
	add r14,r13,0x8
L_92aa6c:
	ld r2,[r14]
L_92aa70:
	bbit0 r2,0x0,L_92aa80
L_92aa74:
	bl.d L_928dcc
L_92aa78:
	mov r0,0x0
L_92aa7c:
	ld r2,[r14]
	.global L_92aa80
L_92aa80:
	bbit0 r2,0x2,L_92aa90
L_92aa84:
	bl.d L_92961c
L_92aa88:
	mov r0,0x0
L_92aa8c:
	ld r2,[r14]
	.global L_92aa90
L_92aa90:
	bbit0 r2,0x3,L_92aaa0
L_92aa94:
	bl.d L_929424
L_92aa98:
	mov r0,0x0
L_92aa9c:
	ld r2,[r14]
	.global L_92aaa0
L_92aaa0:
	btst r2,0x4
L_92aaa4:
	bl.ne.d L_928d40
L_92aaa8:
	sub.ne r0,r0,r0
L_92aaac:
	ld r1,[r13]
	.global L_92aab0
L_92aab0:
	bbit0 r1,0x0,L_92aae4
L_92aab4:
	bl.d L_9297f0
L_92aab8:
	mov r0,0x1
L_92aabc:
	bl.d L_9296e0
L_92aac0:
	mov r0,0x0
L_92aac4:
	bl.d L_92961c
L_92aac8:
	mov r0,0x0
L_92aacc:
	bl.d L_9298f8
L_92aad0:
	mov r0,0x0
L_92aad4:
	bl.d L_929730
L_92aad8:
	mov r0,0x0
L_92aadc:
	bl L_929684
L_92aae0:
	ld r1,[r13]
	.global L_92aae4
L_92aae4:
	bbit0 r1,0x1,L_92ab34
L_92aae8:
	ld.a r0,[r13,0x4]
L_92aaec:
	bbit0 r0,0x0,L_92aafc
L_92aaf0:
	bl.d L_929150
L_92aaf4:
	mov r0,0x0
L_92aaf8:
	ld r0,[r13]
	.global L_92aafc
L_92aafc:
	bbit0 r0,0x2,L_92ab0c
L_92ab00:
	bl.d L_929730
L_92ab04:
	mov r0,0x0
L_92ab08:
	ld r0,[r13]
	.global L_92ab0c
L_92ab0c:
	bbit0 r0,0x3,L_92ab1c
L_92ab10:
	bl.d L_9294d8
L_92ab14:
	mov r0,0x0
L_92ab18:
	ld r0,[r13]
	.global L_92ab1c
L_92ab1c:
	bbit0 r0,0x4,L_92ab34
L_92ab20:
	bl.d L_928d78
L_92ab24:
	mov r0,0x0
L_92ab28:
	ld blink,[sp, 0x4]
L_92ab2c:
	ld_s r14,[sp,0x8]
L_92ab2e:
	j_s.d [blink]
L_92ab30:
	ld.ab r13,[sp,0xc]
	.global L_92ab34
L_92ab34:
	ld blink,[sp, 0x4]
L_92ab38:
	ld_s r14,[sp,0x8]
L_92ab3a:
	j_s.d [blink]
L_92ab3c:
	ld.ab r13,[sp,0xc]
