/* hwd_abif__set_88ae60_flags @ 0x8cbd8c, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_mngr_step_a, hwf_calib__prepare_hw, hwf_calib__release_hw, hwf_calib__setup_loopback
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__set_88ae60_flags,"ax",@progbits
	.global hwd_abif__set_88ae60_flags
hwd_abif__set_88ae60_flags:
	.global L_8cbd8c
L_8cbd8c:
	push_s blink
L_8cbd8e:
	bl L_8c02c0
L_8cbd92:
	bmsk r15,r0,0x0
L_8cbd96:
	and r13,r0,0x2
L_8cbd9a:
	asr_s r13,r13
L_8cbd9c:
	bclr.f 0x0,r15,0x0
L_8cbda0:
	bic r0,r0,-0x5
L_8cbda4:
	asr_s r14,r0,0x2
L_8cbda6:
	bne_s L_8cbdd6
	.global L_8cbda8
L_8cbda8:
	bclr.f 0x0,r13,0x0
L_8cbdac:
	bne_s L_8cbdea
	.global L_8cbdae
L_8cbdae:
	bclr.f 0x0,r14,0x0
L_8cbdb2:
	bne_s L_8cbdfe
	.global L_8cbdb4
L_8cbdb4:
	mov_s r0,0x88ae00
L_8cbdba:
	ld_s r1,[r0,0x60]
L_8cbdbc:
	asl_s r15,r15,0xb
L_8cbdbe:
	bclr_s r1,r1,0xb
L_8cbdc0:
	bclr_s r1,r1,0xc
L_8cbdc2:
	bclr_s r15,r15,0xc
L_8cbdc4:
	or_s r1,r1,r15
L_8cbdc6:
	asl_s r13,r13,0xc
L_8cbdc8:
	or_s r1,r1,r13
L_8cbdca:
	bclr_s r1,r1,0xd
L_8cbdcc:
	asl_s r14,r14,0xd
L_8cbdce:
	or_s r14,r14,r1
L_8cbdd0:
	st_s r14,[r0,0x60]
L_8cbdd2:
	b L_8c032c
	.global L_8cbdd6
L_8cbdd6:
	mov_s r0,blink
L_8cbdd8:
	mov_s r2,0x1019954
L_8cbdde:
	mov_s r1,0xaf
L_8cbde0:
	bl.d L_8c82c0
L_8cbde4:
	mov r3,0x21b
L_8cbde8:
	b_s L_8cbda8
	.global L_8cbdea
L_8cbdea:
	mov_s r0,blink
L_8cbdec:
	mov_s r2,0x1019954
L_8cbdf2:
	mov_s r1,0xb0
L_8cbdf4:
	bl.d L_8c82c0
L_8cbdf8:
	mov r3,0x21b
L_8cbdfc:
	b_s L_8cbdae
	.global L_8cbdfe
L_8cbdfe:
	mov_s r0,blink
L_8cbe00:
	mov_s r2,0x1019954
L_8cbe06:
	mov_s r1,0xb1
L_8cbe08:
	bl.d L_8c82c0
L_8cbe0c:
	mov r3,0x21b
L_8cbe10:
	b_s L_8cbdb4
L_8cbe12:
	nop_s
