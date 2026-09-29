/* hwd_rfc_write_core @ 0x8d0f80, 444 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   hw_drivers_rfc.c
 *   hwd_rfc_write_core busy set before write! (rfc_opcode=%d, rfc_addr=0x%x, rfc_data=0x%x)
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hwd_rfc_write_core busy set - go again!! (rfc_opcode=%d, rfc_addr=0x%x, rfc_data=0x%x)
 *   [NNL] mac_go_when_busy_err_cnt=%d
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_rfc__rgf_889100, hwd_rfc__write_xpm_cmd, hwd_rfc_read_rgf, marlon_r_if__log_data0, rf_sector_commit_rx, rf_sector_commit_tx, rfc__write_core_reg6, rfc_field_write, tail_hwd_rfc_write_core
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.hwd_rfc_write_core,"ax",@progbits
	.global hwd_rfc_write_core
hwd_rfc_write_core:
	.global L_8d0f80
L_8d0f80:
	push_s blink
L_8d0f82:
	bl L_8c02b4
L_8d0f86:
	mov_s r14,r1
L_8d0f88:
	mov_s r16,r2
L_8d0f8a:
	brge.d r0,0x10,L_8d1016
L_8d0f8e:
	mov_s r17,r3
	.global L_8d0f90
L_8d0f90:
	brge r14,0x10,L_8d102e
	.global L_8d0f94
L_8d0f94:
	brlo 0x7fff,r16,L_8d1044
	.global L_8d0f9c
L_8d0f9c:
	mov_s r13,0x889080
L_8d0fa2:
	ld_s r0,[r13,0x4c]
L_8d0fa4:
	mov r18,0x889000
L_8d0fac:
	bmsk r15,r14,0x3
L_8d0fb0:
	/* asl_s r15,r15,0x4 */
	.byte 0x04,0xbf
L_8d0fb2:
	bbit1 r0,0x1d,L_8d105c
	.global L_8d0fb6
L_8d0fb6:
	and.f 0x0,r15,0xffff8000
L_8d0fbe:
	bne_s L_8d10b6
	.global L_8d0fc0
L_8d0fc0:
	ld_s r0,[r13,0x50]
L_8d0fc2:
	asl_s r15,r15,0x10
L_8d0fc4:
	and r0,r0,0x8000ffff
L_8d0fcc:
	or_s r15,r15,r0
L_8d0fce:
	st_s r15,[r13,0x50]
L_8d0fd0:
	ld_s r0,[r13,0x54]
L_8d0fd2:
	st r16,[r13, 0x54]
L_8d0fd6:
	ld_s r0,[r13,0x58]
L_8d0fd8:
	st r17,[r13, 0x58]
L_8d0fdc:
	ld_s r0,[r13,0x4c]
L_8d0fde:
	mov lp_count,0x30d40
L_8d0fe6:
	bset_s r0,r0,0x1e
L_8d0fe8:
	st_s r0,[r13,0x4c]
L_8d0fea:
	lp L_8d0ff6
L_8d0fee:
	ld_s r0,[r13,0x4c]
L_8d0ff0:
	btst_s r0,0x1d
L_8d0ff2:
	beq_s L_8d0ff6
L_8d0ff4:
	nop_s
	.global L_8d0ff6
L_8d0ff6:
	ld_s r0,[r13,0x4c]
L_8d0ff8:
	bbit0 r0,0x1d,L_8d100c
L_8d0ffc:
	mov_s r3,blink
L_8d0ffe:
	mov_s r2,0x1018f28
L_8d1004:
	mov_s r0,0x0
L_8d1006:
	bl.d L_8edfcc
L_8d100a:
	mov_s r1,r0
	.global L_8d100c
L_8d100c:
	ld_s r0,[r13,0x4c]
L_8d100e:
	bbit1 r0,0x1d,L_8d10ca
	.global L_8d1012
L_8d1012:
	b L_8c0314
	.global L_8d1016
L_8d1016:
	mov_s r0,blink
L_8d1018:
	mov_s r2,0x1018f58
L_8d101e:
	mov_s r1,0x1135
L_8d1024:
	bl.d L_8c82c0
L_8d1028:
	mov r3,0x188
L_8d102c:
	b_s L_8d0f90
	.global L_8d102e
L_8d102e:
	mov_s r0,blink
L_8d1030:
	mov_s r2,0x1018f58
L_8d1036:
	mov_s r1,0x45
L_8d1038:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8d103a:
	bl.d L_8c82c0
L_8d103e:
	mov r3,0x189
L_8d1042:
	b_s L_8d0f94
	.global L_8d1044
L_8d1044:
	mov_s r0,blink
L_8d1046:
	mov_s r2,0x1018f58
L_8d104c:
	mov_s r1,0x1141
L_8d1052:
	bl.d L_8c82c0
L_8d1056:
	mov r3,0x18a
L_8d105a:
	b_s L_8d0f9c
	.global L_8d105c
L_8d105c:
	mov_s r2,0x1018f6c
L_8d1062:
	mov_s r0,0x0
L_8d1064:
	mov_s r1,0x1
L_8d1066:
	mov_s r3,r14
L_8d1068:
	mov r4,r16
L_8d106c:
	bl.d L_8ee034
L_8d1070:
	mov r5,r17
L_8d1074:
	mov lp_count,0x30d40
L_8d107c:
	nop_s
L_8d107e:
	lp L_8d108a
L_8d1082:
	ld_s r0,[r13,0x4c]
L_8d1084:
	btst_s r0,0x1d
L_8d1086:
	beq_s L_8d108a
L_8d1088:
	nop_s
	.global L_8d108a
L_8d108a:
	ld_s r0,[r13,0x4c]
L_8d108c:
	bbit0 r0,0x1d,L_8d0fb6
L_8d1090:
	mov_s r2,0x1018fc4
L_8d1096:
	mov_s r0,0x0
L_8d1098:
	bl.d L_8edfb0
L_8d109c:
	mov_s r1,r0
L_8d109e:
	mov_s r0,blink
L_8d10a0:
	mov_s r2,0x1018f58
L_8d10a6:
	mov_s r1,0x134a
L_8d10ac:
	bl.d L_8c82c0
L_8d10b0:
	mov r3,0x195
L_8d10b4:
	b_s L_8d0fb6
	.global L_8d10b6
L_8d10b6:
	mov_s r0,blink
L_8d10b8:
	mov_s r2,0x1018f58
L_8d10be:
	mov_s r1,0xac
L_8d10c0:
	bl.d L_8c82c0
L_8d10c4:
	mov r3,0x198
L_8d10c8:
	b_s L_8d0fc0
	.global L_8d10ca
L_8d10ca:
	mov_s r2,0x1018fe4
L_8d10d0:
	mov_s r0,0x0
L_8d10d2:
	mov_s r1,0x1
L_8d10d4:
	mov_s r3,r14
L_8d10d6:
	mov r4,r16
L_8d10da:
	bl.d L_8ee034
L_8d10de:
	mov r5,r17
L_8d10e2:
	ld.as r3,[r18,0x42]
L_8d10e6:
	mov_s r2,0x101903c
L_8d10ec:
	bmsk_s r3,r3,0xe
L_8d10ee:
	mov_s r0,0x0
L_8d10f0:
	bl.d L_8edfcc
L_8d10f4:
	mov_s r1,0x1
L_8d10f6:
	ld_s r0,[r13,0x4c]
L_8d10f8:
	mov lp_count,0x30d40
L_8d1100:
	bset_s r0,r0,0x1e
L_8d1102:
	st_s r0,[r13,0x4c]
L_8d1104:
	lp L_8d1110
L_8d1108:
	ld_s r0,[r13,0x4c]
L_8d110a:
	btst_s r0,0x1d
L_8d110c:
	beq_s L_8d1110
L_8d110e:
	nop_s
	.global L_8d1110
L_8d1110:
	ld_s r0,[r13,0x4c]
L_8d1112:
	btst_s r0,0x1d
L_8d1114:
	beq_s L_8d1012
L_8d1116:
	mov_s r2,0x1018fc4
L_8d111c:
	mov_s r0,0x0
L_8d111e:
	bl.d L_8edfb0
L_8d1122:
	mov_s r1,r0
L_8d1124:
	mov_s r0,blink
L_8d1126:
	mov_s r2,0x1018f58
L_8d112c:
	mov_s r1,0x133d
L_8d1132:
	bl.d L_8c82c0
L_8d1136:
	mov r3,0x1b1
L_8d113a:
	b_s L_8d1012
