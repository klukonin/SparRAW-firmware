/* marlon_r_if_class__rf_write_with_block_retries @ 0x8deaac, 588 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   /home/gatis/sdk/sparrow/fwsrc4/src/common/inc/hw_drivers_rfc.h
 *   marlon_r_if_class::rf_write_with_block_retries: RF block write failed. starting address [0x%x], crc_cnt [%d], num_cur_block_values [%d]
 *   marlon_r_if.cpp
 *   rf_write_with_block_retries: read failed. Calling hwd_abif_rfc_divider_restart
 *   marlon_r_if_class::rf_write_with_block_retries: RF block write retry %d for starting address=0x%x
 * Зовут его: marlon_r_if_class__config_brp_sectors, marlon_r_if_class__load_brd_rf_cfg_section
 * Зовёт сам: __ld_r25_to_r13_ret, __st_r25_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, hwd_abif_rfc_divider_restart, marlon_r_if_class__rf_hw_write_buffer, rfc__write_buffer_and_wait
 * Глобалы (через gp): 0x8003c0, 0x8003c4, 0x8003c8
 */
	.section .text.marlon_r_if_class__rf_write_with_block_retries,"ax",@progbits
	.global marlon_r_if_class__rf_write_with_block_retries
marlon_r_if_class__rf_write_with_block_retries:
	.global L_8deaac
L_8deaac:
	push_s blink
L_8deaae:
	bl L_8c0298
L_8deab2:
	push_s r0
L_8deab4:
	mov_s r23,r1
L_8deab6:
	mov_s r22,r2
L_8deab8:
	mov_s r25,r3
L_8deaba:
	mov r21,r4
L_8deabe:
	mov r24,r5
L_8deac2:
	extb r17,r1
L_8deac6:
	mov_s r0,r17
L_8deac8:
	mov_s r1,0x4
L_8deaca:
	mov r2,0x428
L_8deace:
	bl.d L_8e85b0
L_8dead2:
	mov_s r3,0x0
L_8dead4:
	mov lp_count,0x7d0
L_8dead8:
	mov_s r14,0x889080
L_8deade:
	lp L_8deaea
L_8deae2:
	ld_s r0,[r14,0x4c]
L_8deae4:
	btst_s r0,0x1d
L_8deae6:
	beq_s L_8deaea
L_8deae8:
	nop_s
	.global L_8deaea
L_8deaea:
	ld_s r0,[r14,0x4c]
L_8deaec:
	bbit0 r0,0x1d,L_8deb00
L_8deaf0:
	mov_s r3,blink
L_8deaf2:
	mov_s r2,0x1005620
L_8deaf8:
	mov_s r0,0x0
L_8deafa:
	bl.d L_8edfcc
L_8deafe:
	mov_s r1,r0
	.global L_8deb00
L_8deb00:
	mov lp_count,0x30d40
L_8deb08:
	nop_s
L_8deb0a:
	lp L_8deb16
L_8deb0e:
	ld_s r0,[r14,0x4c]
L_8deb10:
	btst_s r0,0x1d
L_8deb12:
	beq_s L_8deb16
L_8deb14:
	nop_s
	.global L_8deb16
L_8deb16:
	ld_s r0,[r14,0x4c]
L_8deb18:
	bbit0 r0,0x1d,L_8deb3e
L_8deb1c:
	mov_s r2,0x1005650
L_8deb22:
	mov_s r0,0x0
L_8deb24:
	bl.d L_8edfb0
L_8deb28:
	mov_s r1,r0
L_8deb2a:
	mov_s r0,blink
L_8deb2c:
	mov_s r2,0x1005670
L_8deb32:
	mov_s r1,0x1349
L_8deb38:
	bl.d L_8c82c0
L_8deb3c:
	mov_s r3,0x95
	.global L_8deb3e
L_8deb3e:
	ld_s r15,[r14,0x58]
L_8deb40:
	mov r19,0x0
L_8deb44:
	b_s L_8deb8e
	.global L_8deb46
L_8deb46:
	ld_s r0,[gp,0x258]
L_8deb48:
	add_s r0,r0,r13
L_8deb4a:
	st.as r0,[gp,0x96]
L_8deb4e:
	breq r4,r20,L_8deb8a
L_8deb52:
	ld_s r0,[gp,0x254]
L_8deb54:
	ld r3,[r16]
L_8deb58:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8deb5a:
	st.as r0,[gp,0x95]
L_8deb5e:
	st.as r3,[gp,0x94]
L_8deb62:
	mov_s r2,0x1005704
L_8deb68:
	mov_s r0,0x0
L_8deb6a:
	mov_s r1,r0
L_8deb6c:
	bl.d L_8ee034
L_8deb70:
	mov r5,r20
L_8deb74:
	mov_s r0,blink
L_8deb76:
	mov_s r2,0x1005078
L_8deb7c:
	mov_s r1,0x1344
L_8deb82:
	bl.d L_8c82c0
L_8deb86:
	mov r3,0x4a6
	.global L_8deb8a
L_8deb8a:
	add r19,r19,r21
	.global L_8deb8e
L_8deb8e:
	cmp r25,r19
L_8deb92:
	bls L_8decee
L_8deb96:
	add3 r16,r22,r19
L_8deb9a:
	sub r0,r25,r19
L_8deb9e:
	cmp r21,r0
L_8deba2:
	mov.cc r20,r0
L_8deba6:
	mov.cs r20,r21
L_8debaa:
	mov_s r13,0x0
L_8debac:
	b_s L_8debec
	.global L_8debae
L_8debae:
	ld_s r0,[r14,0x4c]
L_8debb0:
	bbit0 r0,0x1d,L_8debd6
L_8debb4:
	mov_s r2,0x1005650
L_8debba:
	mov_s r0,0x0
L_8debbc:
	bl.d L_8edfb0
L_8debc0:
	mov_s r1,r0
L_8debc2:
	mov_s r0,blink
L_8debc4:
	mov_s r2,0x1005670
L_8debca:
	mov_s r1,0x1349
L_8debd0:
	bl.d L_8c82c0
L_8debd4:
	mov_s r3,0x95
	.global L_8debd6
L_8debd6:
	ld_s r15,[r14,0x58]
L_8debd8:
	sub r0,r15,r18
L_8debdc:
	sub r4,r0,0x1
L_8debe0:
	add_s r0,r13,0x1
L_8debe2:
	breq r4,r20,L_8deb46
L_8debe6:
	brhs r0,r24,L_8deb46
L_8debea:
	mov_s r13,r0
	.global L_8debec
L_8debec:
	cmp_s r13,0x0
L_8debee:
	mov.eq r18,r15
L_8debf2:
	beq_s L_8dec94
L_8debf4:
	mov_s r2,0x100578c
L_8debfa:
	mov_s r0,0x0
L_8debfc:
	bl.d L_8edfb0
L_8dec00:
	mov_s r1,0x1
L_8dec02:
	bl.d L_8cbce8
L_8dec06:
	mov_s r0,0x1
L_8dec08:
	mov_s r0,r17
L_8dec0a:
	mov_s r1,0x4
L_8dec0c:
	mov r2,0x428
L_8dec10:
	bl.d L_8e85b0
L_8dec14:
	mov_s r3,0x0
L_8dec16:
	mov lp_count,0x7d0
L_8dec1a:
	nop_s
L_8dec1c:
	lp L_8dec28
L_8dec20:
	ld_s r0,[r14,0x4c]
L_8dec22:
	btst_s r0,0x1d
L_8dec24:
	beq_s L_8dec28
L_8dec26:
	nop_s
	.global L_8dec28
L_8dec28:
	ld_s r0,[r14,0x4c]
L_8dec2a:
	bbit0 r0,0x1d,L_8dec3e
L_8dec2e:
	mov_s r3,blink
L_8dec30:
	mov_s r2,0x1005620
L_8dec36:
	mov_s r0,0x0
L_8dec38:
	bl.d L_8edfcc
L_8dec3c:
	mov_s r1,r0
	.global L_8dec3e
L_8dec3e:
	mov lp_count,0x30d40
L_8dec46:
	nop_s
L_8dec48:
	lp L_8dec54
L_8dec4c:
	ld_s r0,[r14,0x4c]
L_8dec4e:
	btst_s r0,0x1d
L_8dec50:
	beq_s L_8dec54
L_8dec52:
	nop_s
	.global L_8dec54
L_8dec54:
	ld_s r0,[r14,0x4c]
L_8dec56:
	bbit0 r0,0x1d,L_8dec7c
L_8dec5a:
	mov_s r2,0x1005650
L_8dec60:
	mov_s r0,0x0
L_8dec62:
	bl.d L_8edfb0
L_8dec66:
	mov_s r1,r0
L_8dec68:
	mov_s r0,blink
L_8dec6a:
	mov_s r2,0x1005670
L_8dec70:
	mov_s r1,0x1349
L_8dec76:
	bl.d L_8c82c0
L_8dec7a:
	mov_s r3,0x95
	.global L_8dec7c
L_8dec7c:
	ld r18,[r14, 0x58]
L_8dec80:
	mov_s r2,0x10057dc
L_8dec86:
	ld r4,[r22]
L_8dec8a:
	mov_s r0,0x0
L_8dec8c:
	mov_s r1,0x1
L_8dec8e:
	bl.d L_8edff8
L_8dec92:
	mov_s r3,r13
	.global L_8dec94
L_8dec94:
	ld_s r0,[sp,0x0]
L_8dec96:
	mov_s r1,r23
L_8dec98:
	mov_s r2,r16
L_8dec9a:
	bl.d L_8dea6c
L_8dec9e:
	mov_s r3,r20
L_8deca0:
	mov_s r0,r17
L_8deca2:
	mov_s r1,0x4
L_8deca4:
	mov r2,0x428
L_8deca8:
	bl.d L_8e85b0
L_8decac:
	mov_s r3,0x0
L_8decae:
	mov lp_count,0x7d0
L_8decb2:
	nop_s
L_8decb4:
	lp L_8decc0
L_8decb8:
	ld_s r0,[r14,0x4c]
L_8decba:
	btst_s r0,0x1d
L_8decbc:
	beq_s L_8decc0
L_8decbe:
	nop_s
	.global L_8decc0
L_8decc0:
	ld_s r0,[r14,0x4c]
L_8decc2:
	bbit0 r0,0x1d,L_8decd6
L_8decc6:
	mov_s r3,blink
L_8decc8:
	mov_s r2,0x1005620
L_8decce:
	mov_s r0,0x0
L_8decd0:
	bl.d L_8edfcc
L_8decd4:
	mov_s r1,r0
	.global L_8decd6
L_8decd6:
	mov lp_count,0x30d40
L_8decde:
	nop_s
L_8dece0:
	lp L_8decec
L_8dece4:
	ld_s r0,[r14,0x4c]
L_8dece6:
	btst_s r0,0x1d
L_8dece8:
	beq_s L_8debae
L_8decea:
	nop_s
	.global L_8decec
L_8decec:
	b_s L_8debae
	.global L_8decee
L_8decee:
	mov_s r0,0x1
L_8decf0:
	b.d L_8c02dc
L_8decf4:
	add_s sp,sp,0x4
L_8decf6:
	nop_s
