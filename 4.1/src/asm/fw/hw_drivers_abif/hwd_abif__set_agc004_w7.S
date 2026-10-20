/* hwd_abif__set_agc004_w7 @ 0x8ccdac, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf__set_agc_index_1c, hwf_calib_lo_leakage_res
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__set_agc004_w7,"ax",@progbits
	.global hwd_abif__set_agc004_w7
hwd_abif__set_agc004_w7:
	.global L_8ccdac
L_8ccdac:
	push_s blink
L_8ccdae:
	bl L_8c02c0
L_8ccdb2:
	mov_s r13,r0
L_8ccdb4:
	mov_s r14,r1
L_8ccdb6:
	brge.d r0,0x20,L_8ccdce
L_8ccdba:
	mov_s r15,r2
	.global L_8ccdbc
L_8ccdbc:
	brge r14,0x2,L_8ccde6
	.global L_8ccdc0
L_8ccdc0:
	brge r15,0x80,L_8ccdfe
	.global L_8ccdc8
L_8ccdc8:
	breq_s r14,0,L_8cce16
L_8ccdca:
	mov_s r1,0x15
L_8ccdcc:
	b_s L_8cce18
	.global L_8ccdce
L_8ccdce:
	mov_s r0,blink
L_8ccdd0:
	mov_s r2,0x1019954
L_8ccdd6:
	mov_s r1,0x1116
L_8ccddc:
	bl.d L_8c82c0
L_8ccde0:
	mov r3,0x686
L_8ccde4:
	b_s L_8ccdbc
	.global L_8ccde6
L_8ccde6:
	mov_s r0,blink
L_8ccde8:
	mov_s r2,0x1019954
L_8ccdee:
	mov_s r1,0x1117
L_8ccdf4:
	bl.d L_8c82c0
L_8ccdf8:
	mov r3,0x687
L_8ccdfc:
	b_s L_8ccdc0
	.global L_8ccdfe
L_8ccdfe:
	mov_s r0,blink
L_8cce00:
	mov_s r2,0x1019954
L_8cce06:
	mov_s r1,0x111c
L_8cce0c:
	bl.d L_8c82c0
L_8cce10:
	mov r3,0x688
L_8cce14:
	b_s L_8ccdc8
	.global L_8cce16
L_8cce16:
	mov_s r1,0xc
	.global L_8cce18
L_8cce18:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cce1a:
	/* add_s r13,0x2 */
	.byte 0x02,0xe5
L_8cce1c:
	mov_s r0,0x88a004
L_8cce22:
	add2_s r0,r0,r13
L_8cce24:
	ld_s r3,[r0]
L_8cce26:
	mov_s r2,0x7f
L_8cce28:
	asl_s r2,r2,r1
L_8cce2a:
	bic_s r3,r3,r2
L_8cce2c:
	asl_s r15,r15,r1
L_8cce2e:
	or_s r3,r3,r15
L_8cce30:
	st_s r3,[r0]
L_8cce32:
	b L_8c032c
L_8cce36:
	nop_s
