/* hwd_phy_rx_set_agc_start_val_and_gain_array_uc @ 0x929c10, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_phy_rx_set_agc_start_val_and_gain_array(): ina_agc_gain_array=%x doesn't match ina_agc_start=%d, estimated_agc_plus_step0=%d
 *   hwd_phy_rx_set_agc_start_val_and_gain_array(): estimated_agc_plus_step1=%d, estimated_agc_plus_step2=%d, estimated_agc_plus_step3=%d
 * Зовут его: rx_mode__configure
 * Зовёт сам: uc_log__emit3, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_phy_rx_set_agc_start_val_and_gain_array_uc
hwd_phy_rx_set_agc_start_val_and_gain_array_uc:
	.global L_929c10
L_929c10:
	st.a r13,[sp,-0x18]
L_929c14:
	st blink,[sp, 0x4]
L_929c18:
	st_s r14,[sp,0x8]
L_929c1a:
	st_s r15,[sp,0xc]
L_929c1c:
	st r16,[sp, 0x10]
L_929c20:
	st r17,[sp, 0x14]
L_929c24:
	mov_s r13,r0
L_929c26:
	mov_s r14,r1
L_929c28:
	bmsk r4,r1,0x5
L_929c2c:
	and r17,r1,0xfc0
L_929c34:
	and r16,r1,0x3f000
L_929c3c:
	and r15,r1,0xfc0000
L_929c44:
	cmp_s r0,r4
L_929c46:
	cmp.ls r13,r17
L_929c4a:
	cmp.ls r13,r16
L_929c4e:
	cmp.ls r13,r15
L_929c52:
	bls L_929c88
L_929c56:
	mov_s r1,0x10027e8
L_929c5c:
	mov_s r0,0x0
L_929c5e:
	mov_s r2,r14
L_929c60:
	bl.d L_92d338
L_929c64:
	mov r3,r13
L_929c68:
	mov_s r1,0x100286c
L_929c6e:
	mov_s r0,0x0
L_929c70:
	mov_s r2,r17
L_929c72:
	mov_s r3,r16
L_929c74:
	bl.d L_92d338
L_929c78:
	mov r4,r15
L_929c7c:
	mov_s r0,blink
L_929c7e:
	mov_s r1,0x146c
L_929c84:
	bl L_926618
	.global L_929c88
L_929c88:
	mov_s r2,0x883000
L_929c8e:
	st.as r13,[r2,0x4b]
L_929c92:
	st.as r14,[r2,0x73]
L_929c96:
	ld blink,[sp, 0x4]
L_929c9a:
	ld_s r14,[sp,0x8]
L_929c9c:
	ld_s r15,[sp,0xc]
L_929c9e:
	ld r16,[sp, 0x10]
L_929ca2:
	ld r17,[sp, 0x14]
L_929ca6:
	j_s.d [blink]
L_929ca8:
	ld.ab r13,[sp,0x18]
