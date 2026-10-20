/* hw__power_sequence_rf @ 0x92ab40, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__power_seq_and_save
 * Зовёт сам: hw__bring_up_phy_dma, hw__power_step, hwd_rfc_powerdown_deep_all_rfs, hwd_rfc_powerup_deep_all_rfs, rf__set_normal_mode
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hw__power_sequence_rf
hw__power_sequence_rf:
	.global L_92ab40
L_92ab40:
	st.a r13,[sp,-0x8]
L_92ab44:
	st blink,[sp, 0x4]
L_92ab48:
	mov r13,r1
L_92ab4c:
	breq.d r0,0x0,L_92aba0
L_92ab50:
	ld r2,[r1]
L_92ab54:
	bbit0 r2,0x0,L_92ab68
L_92ab58:
	ldb r0,[0x8006b6]
L_92ab60:
	bl L_929eec
L_92ab64:
	ld r2,[r13]
	.global L_92ab68
L_92ab68:
	bbit0 r2,0x1,L_92ab74
L_92ab6c:
	bl L_929fa0
L_92ab70:
	ld r2,[r13]
	.global L_92ab74
L_92ab74:
	bbit0 r2,0x3,L_92ab84
L_92ab78:
	bl.d L_92abe4
L_92ab7c:
	mov r0,0x1
L_92ab80:
	ld r2,[r13]
	.global L_92ab84
L_92ab84:
	bbit0 r2,0x5,L_92abd8
L_92ab88:
	add r1,r13,0x4
L_92ab8c:
	bl.d L_92a980
L_92ab90:
	mov r0,0x1
L_92ab94:
	ld blink,[sp, 0x4]
L_92ab98:
	j.d [blink]
L_92ab9c:
	ld.ab r13,[sp,0x8]
	.global L_92aba0
L_92aba0:
	bbit0 r2,0x5,L_92abb4
L_92aba4:
	add r1,r13,0x4
L_92aba8:
	bl.d L_92a980
L_92abac:
	mov r0,0x0
L_92abb0:
	ld r2,[r13]
	.global L_92abb4
L_92abb4:
	bbit0 r2,0x3,L_92abc4
L_92abb8:
	bl.d L_92abe4
L_92abbc:
	mov r0,0x0
L_92abc0:
	ld r2,[r13]
	.global L_92abc4
L_92abc4:
	bbit0 r2,0x1,L_92abd8
L_92abc8:
	bl L_92a0a0
L_92abcc:
	ld blink,[sp, 0x4]
L_92abd0:
	j.d [blink]
L_92abd4:
	ld.ab r13,[sp,0x8]
	.global L_92abd8
L_92abd8:
	ld blink,[sp, 0x4]
L_92abdc:
	j.d [blink]
L_92abe0:
	ld.ab r13,[sp,0x8]
