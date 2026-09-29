/* rx_funcs__set_rx_off @ 0x928bd4, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_funcs.c
 * Зовут его: ucode_cmd__rx_off
 * Зовёт сам: mac__rx_off_seq, perform_shallow_sleep, rx__set_enable_mask, uc_pm__enter_idle, uc_read_tsf_lo, uc_sysassert
 * Глобалы (через gp): 0x80053c, 0x8005d6
 */
	.section .text.rx_funcs__set_rx_off,"ax",@progbits
	.global rx_funcs__set_rx_off
rx_funcs__set_rx_off:
	.global L_928bd4
L_928bd4:
	st.a r13,[sp,-0x10]
L_928bd8:
	st blink,[sp, 0x4]
L_928bdc:
	st_s r14,[sp,0x8]
L_928bde:
	st_s r15,[sp,0xc]
L_928be0:
	mov_s r13,r0
L_928be2:
	mov_s r15,0x0
L_928be4:
	mov_s r0,0x801ed0
L_928bea:
	mov_s r1,r15
L_928bec:
	mov_s r2,r15
L_928bee:
	mov_s r14,0x1
L_928bf0:
	mov r3,r14
L_928bf4:
	bl.d L_92af4c
L_928bf8:
	mov r4,r14
L_928bfc:
	breq r0,0x0,L_928c08
L_928c00:
	st r14,[0x800660]
	.global L_928c08
L_928c08:
	breq_s r13,0,L_928c44
L_928c0a:
	breq r13,0x1,L_928c6c
L_928c0e:
	mov_s r0,blink
L_928c10:
	mov_s r2,0x1000ecc
L_928c16:
	mov_s r1,0x80
L_928c18:
	bl.d L_925548
L_928c1c:
	mov r3,0x323
L_928c20:
	bl L_9315e8
L_928c24:
	stw.as r15,[gp,0x57]
L_928c28:
	st.as r0,[gp,0x5]
L_928c2c:
	bl.d L_921f84
L_928c30:
	mov r0,0x1
L_928c34:
	ld blink,[sp, 0x4]
L_928c38:
	ld_s r14,[sp,0x8]
L_928c3a:
	ld_s r15,[sp,0xc]
L_928c3c:
	j.d [blink]
L_928c40:
	ld.ab r13,[sp,0x10]
	.global L_928c44
L_928c44:
	bl L_932614
L_928c48:
	bl L_9315e8
L_928c4c:
	stw.as r15,[gp,0x57]
L_928c50:
	st.as r0,[gp,0x5]
L_928c54:
	bl.d L_921f84
L_928c58:
	mov r0,0x1
L_928c5c:
	ld blink,[sp, 0x4]
L_928c60:
	ld_s r14,[sp,0x8]
L_928c62:
	ld_s r15,[sp,0xc]
L_928c64:
	j.d [blink]
L_928c68:
	ld.ab r13,[sp,0x10]
	.global L_928c6c
L_928c6c:
	bl.d L_936ca8
L_928c70:
	mov r0,0x1
L_928c74:
	bl L_9315e8
L_928c78:
	stw.as r15,[gp,0x57]
L_928c7c:
	st.as r0,[gp,0x5]
L_928c80:
	bl.d L_921f84
L_928c84:
	mov r0,0x1
L_928c88:
	ld blink,[sp, 0x4]
L_928c8c:
	ld_s r14,[sp,0x8]
L_928c8e:
	ld_s r15,[sp,0xc]
L_928c90:
	j.d [blink]
L_928c94:
	ld.ab r13,[sp,0x10]
