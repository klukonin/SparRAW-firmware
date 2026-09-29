/* dma_mac_setup_wrap @ 0x927d20, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__switch_core_and_setup_dma
 * Зовёт сам: dma_mac_setup_step, dma_mac_substep, rgf_reg_889000, tail_uc_hwd_rfc_write_core
 */
	.section .text.dma_mac_setup_wrap,"ax",@progbits
	.global dma_mac_setup_wrap
dma_mac_setup_wrap:
	.global L_927d20
L_927d20:
	st.a r13,[sp,-0x8]
L_927d24:
	st blink,[sp, 0x4]
L_927d28:
	mov r13,r1
L_927d2c:
	breq.d r0,0x0,L_927d84
L_927d30:
	ld r2,[r1]
L_927d34:
	bbit0 r2,0x0,L_927d44
L_927d38:
	bl.d L_9274fc
L_927d3c:
	mov r0,0x0
L_927d40:
	ld r2,[r13]
	.global L_927d44
L_927d44:
	bbit0 r2,0x1,L_927d58
L_927d48:
	mov r0,0x0
L_927d4c:
	bl.d L_927508
L_927d50:
	mov r1,0x1
L_927d54:
	ld r2,[r13]
	.global L_927d58
L_927d58:
	bbit0 r2,0x3,L_927d68
L_927d5c:
	bl.d L_927dd0
L_927d60:
	mov r0,0x1
L_927d64:
	ld r2,[r13]
	.global L_927d68
L_927d68:
	bbit0 r2,0x5,L_927dc4
L_927d6c:
	add r1,r13,0x4
L_927d70:
	bl.d L_927b60
L_927d74:
	mov r0,0x1
L_927d78:
	ld blink,[sp, 0x4]
L_927d7c:
	j.d [blink]
L_927d80:
	ld.ab r13,[sp,0x8]
	.global L_927d84
L_927d84:
	bbit0 r2,0x5,L_927d98
L_927d88:
	add r1,r13,0x4
L_927d8c:
	bl.d L_927b60
L_927d90:
	mov r0,0x0
L_927d94:
	ld r2,[r13]
	.global L_927d98
L_927d98:
	bbit0 r2,0x3,L_927da8
L_927d9c:
	bl.d L_927dd0
L_927da0:
	mov r0,0x0
L_927da4:
	ld r2,[r13]
	.global L_927da8
L_927da8:
	bbit0 r2,0x1,L_927dc4
L_927dac:
	mov r0,0x0
L_927db0:
	bl.d L_927508
L_927db4:
	mov r1,r0
L_927db8:
	ld blink,[sp, 0x4]
L_927dbc:
	j.d [blink]
L_927dc0:
	ld.ab r13,[sp,0x8]
	.global L_927dc4
L_927dc4:
	ld blink,[sp, 0x4]
L_927dc8:
	j.d [blink]
L_927dcc:
	ld.ab r13,[sp,0x8]
