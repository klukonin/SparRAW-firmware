/* dma_mac_setup_step @ 0x927b60, 448 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mac_setup_wrap
 * Зовёт сам: dma_mac__cfg_880c14, dma_mac__cfg_880c28, dma_mac__cfg_880c2c, hwd_abif__rgf_880800_926ad0, hwd_abif__rgf_880800_926b00, hwd_dma__set_mode_map, hwd_mac__set_mode_map, hwd_phy__rgf_881000, hwd_phy__set_881000, hwd_phy_init__2, rgf_reg_880800, uc_hwd_phy_pwr
 */
	.section .text.dma_mac_setup_step,"ax",@progbits
	.global dma_mac_setup_step
dma_mac_setup_step:
	.global L_927b60
L_927b60:
	st.a r13,[sp,-0xc]
L_927b64:
	st blink,[sp, 0x4]
L_927b68:
	st_s r14,[sp,0x8]
L_927b6a:
	cmp_s r0,0x0
L_927b6c:
	mov r13,r1
L_927b70:
	beq.d L_927c44
L_927b74:
	ld r2,[r1]
L_927b78:
	bbit0 r2,0x0,L_927ba8
L_927b7c:
	bl.d L_927014
L_927b80:
	mov r0,0x4
L_927b84:
	bl.d L_927250
L_927b88:
	mov r0,0x1
L_927b8c:
	bl.d L_926e8c
L_927b90:
	mov r0,0x1
L_927b94:
	bl.d L_926fc4
L_927b98:
	mov r0,0x1
L_927b9c:
	bl.d L_92709c
L_927ba0:
	mov r0,0x0
L_927ba4:
	ld r2,[r13]
	.global L_927ba8
L_927ba8:
	bbit0 r2,0x1,L_927bf4
L_927bac:
	add r14,r13,0x4
L_927bb0:
	ld r4,[r14]
L_927bb4:
	bbit0 r4,0x0,L_927bc4
L_927bb8:
	bl.d L_926bc0
L_927bbc:
	mov r0,0x4
L_927bc0:
	ld r4,[r14]
	.global L_927bc4
L_927bc4:
	bbit0 r4,0x2,L_927bd4
L_927bc8:
	bl.d L_927014
L_927bcc:
	mov r0,0x4
L_927bd0:
	ld r4,[r14]
	.global L_927bd4
L_927bd4:
	bbit0 r4,0x3,L_927be4
L_927bd8:
	bl.d L_926d34
L_927bdc:
	mov r0,0x4
L_927be0:
	ld r4,[r14]
	.global L_927be4
L_927be4:
	btst r4,0x4
L_927be8:
	bl.ne.d L_926b00
L_927bec:
	mov.ne r0,0x4
L_927bf0:
	ld r2,[r13]
	.global L_927bf4
L_927bf4:
	btst_s r2,0x3
L_927bf6:
	beq_s L_927d14
L_927bf8:
	ld.a r3,[r13,0x8]
L_927bfc:
	bbit0 r3,0x0,L_927c0c
L_927c00:
	bl.d L_926b60
L_927c04:
	mov r0,0x1
L_927c08:
	ld r3,[r13]
	.global L_927c0c
L_927c0c:
	bbit0 r3,0x2,L_927c1c
L_927c10:
	bl.d L_926e8c
L_927c14:
	mov r0,0x1
L_927c18:
	ld r3,[r13]
	.global L_927c1c
L_927c1c:
	bbit0 r3,0x3,L_927c2c
L_927c20:
	bl.d L_926c68
L_927c24:
	mov r0,0x1
L_927c28:
	ld r3,[r13]
	.global L_927c2c
L_927c2c:
	btst_s r3,0x4
L_927c2e:
	beq_s L_927d14
L_927c30:
	bl.d L_926ad0
L_927c34:
	mov r0,0x1
L_927c38:
	ld blink,[sp, 0x4]
L_927c3c:
	ld_s r14,[sp,0x8]
L_927c3e:
	j_s.d [blink]
L_927c40:
	ld.ab r13,[sp,0xc]
	.global L_927c44
L_927c44:
	bbit0 r2,0x3,L_927c90
L_927c48:
	add r14,r13,0x8
L_927c4c:
	ld r0,[r14]
L_927c50:
	bbit0 r0,0x0,L_927c60
L_927c54:
	bl.d L_926b60
L_927c58:
	mov r0,0x0
L_927c5c:
	ld r0,[r14]
	.global L_927c60
L_927c60:
	bbit0 r0,0x2,L_927c70
L_927c64:
	bl.d L_926e8c
L_927c68:
	mov r0,0x0
L_927c6c:
	ld r0,[r14]
	.global L_927c70
L_927c70:
	bbit0 r0,0x3,L_927c80
L_927c74:
	bl.d L_926c68
L_927c78:
	mov r0,0x0
L_927c7c:
	ld r0,[r14]
	.global L_927c80
L_927c80:
	btst r0,0x4
L_927c84:
	bl.ne.d L_926ad0
L_927c88:
	sub.ne r0,r0,r0
L_927c8c:
	ld r2,[r13]
	.global L_927c90
L_927c90:
	bbit0 r2,0x0,L_927cc4
L_927c94:
	bl.d L_92709c
L_927c98:
	mov r0,0x1
L_927c9c:
	bl.d L_926fc4
L_927ca0:
	mov r0,0x0
L_927ca4:
	bl.d L_926e8c
L_927ca8:
	mov r0,0x0
L_927cac:
	bl.d L_927250
L_927cb0:
	mov r0,0x0
L_927cb4:
	bl.d L_927014
L_927cb8:
	mov r0,0x0
L_927cbc:
	bl L_926ef4
L_927cc0:
	ld r2,[r13]
	.global L_927cc4
L_927cc4:
	bbit0 r2,0x1,L_927d14
L_927cc8:
	ld.a r1,[r13,0x4]
L_927ccc:
	bbit0 r1,0x0,L_927cdc
L_927cd0:
	bl.d L_926bc0
L_927cd4:
	mov r0,0x0
L_927cd8:
	ld r1,[r13]
	.global L_927cdc
L_927cdc:
	bbit0 r1,0x2,L_927cec
L_927ce0:
	bl.d L_927014
L_927ce4:
	mov r0,0x0
L_927ce8:
	ld r1,[r13]
	.global L_927cec
L_927cec:
	bbit0 r1,0x3,L_927cfc
L_927cf0:
	bl.d L_926d34
L_927cf4:
	mov r0,0x0
L_927cf8:
	ld r1,[r13]
	.global L_927cfc
L_927cfc:
	bbit0 r1,0x4,L_927d14
L_927d00:
	bl.d L_926b00
L_927d04:
	mov r0,0x0
L_927d08:
	ld blink,[sp, 0x4]
L_927d0c:
	ld_s r14,[sp,0x8]
L_927d0e:
	j_s.d [blink]
L_927d10:
	ld.ab r13,[sp,0xc]
	.global L_927d14
L_927d14:
	ld blink,[sp, 0x4]
L_927d18:
	ld_s r14,[sp,0x8]
L_927d1a:
	j_s.d [blink]
L_927d1c:
	ld.ab r13,[sp,0xc]
