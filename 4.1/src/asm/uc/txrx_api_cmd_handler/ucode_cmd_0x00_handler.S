/* ucode_cmd_0x00_handler @ 0x934f68, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, ifs_cfg__program_from_hw_cfg, mac__set_phy_mode, memcpy_uc, set_g_8005bc_x2, ucode_cmd__apply_mac_cfg
 * Глобалы (через gp): 0x8005f4, 0x8005f6, 0x8005f8
 */
	.section .text.ucode_cmd_0x00_handler,"ax",@progbits
	.global ucode_cmd_0x00_handler
ucode_cmd_0x00_handler:
	.global L_934f68
L_934f68:
	push_s blink
L_934f6a:
	bl L_920214
L_934f6e:
	mov_s r13,r0
L_934f70:
	ld_s r0,[r0,0x40]
L_934f72:
	mov_s r14,0x8019e8
L_934f78:
	st.as r0,[gp,-0x4]
L_934f7c:
	bl.d L_92b828
L_934f80:
	mov_s r0,r13
L_934f82:
	add r0,r14,0x14
L_934f86:
	add r1,r13,0x30
L_934f8a:
	bl.d L_920310
L_934f8e:
	mov_s r2,0xc
L_934f90:
	bl.d L_931bd0
L_934f94:
	add r0,r14,0x14
L_934f98:
	mov_s r0,0x857280
L_934f9e:
	ld_s r0,[r0,0x18]
L_934fa0:
	cmp_s r0,0x0
L_934fa2:
	mov.ne r0,0x1
L_934fa6:
	neg_s r0,r0
L_934fa8:
	bmsk_s r0,r0,0x1
L_934faa:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_934fac:
	stw.as r0,[gp,-0x12]
L_934fb0:
	stw.as r0,[gp,-0x11]
L_934fb4:
	bl.d L_92b9b8
L_934fb8:
	ld_s r0,[r13,0x40]
L_934fba:
	mov_s r1,0x886000
L_934fc0:
	ld_s r0,[r1,0x18]
L_934fc2:
	ld_s r1,[r1,0x1c]
L_934fc4:
	stw.as r0,[gp,0x66]
L_934fc8:
	lsr_s r0,r0,0x10
L_934fca:
	stw.as r0,[gp,0x67]
L_934fce:
	bl.d L_9319bc
L_934fd2:
	stw.as r1,[gp,0x68]
L_934fd6:
	b L_920284
L_934fda:
	nop_s
