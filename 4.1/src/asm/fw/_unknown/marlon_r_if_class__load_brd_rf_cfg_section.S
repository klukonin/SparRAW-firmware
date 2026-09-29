/* marlon_r_if_class__load_brd_rf_cfg_section @ 0x8d90a8, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   marlon_r_if_class::load_brd_rf_cfg_section: BRD Section Write to RF Started, section_type=%d
 *   marlon_r_if_class::load_brd_rf_cfg_section: BRD Section Write to RF Completed, section_type=%d, elapsed_time=%d [usec]
 *   marlon_r_if_class::load_brd_rf_cfg_section: RF write failure for chunk_idx=%d, block_idx=%d, section_type=%d
 * Зовут его: marlon_r_if_class__config_channel, marlon_r_if_class__rf_configure_role_power
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, div_round_up, fw_log__emit1, fw_log__emit2, fw_log__emit3, fw_read_timer, marlon_r_if_class__load_brd_parameters_section, marlon_r_if_class__rf_write_with_block_retries, stub_ret_8e70d4, stub_ret_8e70d8, tail_brd_if__clear_block_info
 * Глобалы (через gp): 0x800228
 */
	.section .text.marlon_r_if_class__load_brd_rf_cfg_section,"ax",@progbits
	.global marlon_r_if_class__load_brd_rf_cfg_section
marlon_r_if_class__load_brd_rf_cfg_section:
	.global L_8d90a8
L_8d90a8:
	push_s blink
L_8d90aa:
	bl L_8c02a4
L_8d90ae:
	mov_s r14,r0
L_8d90b0:
	st.a r1,[sp,-0x2c]
L_8d90b4:
	mov_s r20,r2
L_8d90b6:
	brne_s r1,0,L_8d90c2
L_8d90b8:
	mov_s r0,r14
L_8d90ba:
	bl.d L_8d8f80
L_8d90be:
	mov_s r1,r20
L_8d90c0:
	b_s L_8d91b2
	.global L_8d90c2
L_8d90c2:
	bl.d L_8e4694
L_8d90c6:
	add r16,sp,0x4
L_8d90ca:
	mov_s r22,r0
L_8d90cc:
	mov_s r0,r16
L_8d90ce:
	mov_s r13,0x0
L_8d90d0:
	bl.d L_8c17e4
L_8d90d4:
	mov_s r1,r13
L_8d90d6:
	ld_s r0,[r14,0x20]
L_8d90d8:
	breq r0,0x0,L_8d91b0
L_8d90dc:
	ld_s r1,[r0]
L_8d90de:
	ld_s r3,[r1,0x4]
L_8d90e0:
	ld_s r1,[sp,0x0]
L_8d90e2:
	jl_s.d [r3]
L_8d90e4:
	mov_s r2,r16
L_8d90e6:
	breq r0,0x0,L_8d91b0
L_8d90ea:
	mov_s r2,0x1005840
L_8d90f0:
	mov_s r0,r13
L_8d90f2:
	mov_s r1,0x2
L_8d90f4:
	bl.d L_8edfcc
L_8d90f8:
	ld_s r3,[sp,0x0]
L_8d90fa:
	bl.d L_8e70d8
L_8d90fe:
	mov_s r0,r16
L_8d9100:
	add r17,sp,0x14
L_8d9104:
	mov_s r0,r17
L_8d9106:
	bl.d L_8c17e0
L_8d910a:
	mov_s r1,r13
L_8d910c:
	ld_s r0,[sp,0x8]
L_8d910e:
	brlo r0,0x1,L_8d9190
L_8d9112:
	mov_s r19,r13
	.global L_8d9114
L_8d9114:
	ld_s r0,[r14,0x20]
L_8d9116:
	mov_s r2,r19
L_8d9118:
	ld_s r1,[r0]
L_8d911a:
	ld_s r13,[r1,0x8]
L_8d911c:
	mov_s r1,r16
L_8d911e:
	jl_s.d [r13]
L_8d9120:
	mov_s r3,r17
L_8d9122:
	breq r0,0x0,L_8d91b0
L_8d9126:
	ld_s r1,[sp,0x1c]
L_8d9128:
	ldb_s r0,[gp,0xb8]
L_8d912a:
	bbit0 r0,r1,L_8d9186
L_8d912e:
	mov_s r0,r17
L_8d9130:
	bl.d L_8c9d5c
L_8d9134:
	mov_s r1,r20
L_8d9136:
	mov_s r13,r0
L_8d9138:
	bl.d L_8e70d4
L_8d913c:
	mov_s r0,r17
L_8d913e:
	brlo.d r13,0x1,L_8d9186
L_8d9142:
	mov_s r15,0x0
	.global L_8d9144
L_8d9144:
	ld_s r0,[r14,0x20]
L_8d9146:
	mov_s r2,r17
L_8d9148:
	ld_s r1,[r0]
L_8d914a:
	add r21,r14,0x24
L_8d914e:
	ld r6,[r1, 0xc]
L_8d9152:
	mov_s r1,r16
L_8d9154:
	mov_s r3,r15
L_8d9156:
	mov r4,r21
L_8d915a:
	jl.d [r6]
L_8d915e:
	mov r5,r20
L_8d9162:
	mov_s r4,r0
L_8d9164:
	mov_s r0,r14
L_8d9166:
	mov_s r1,0x0
L_8d9168:
	mov_s r2,r21
L_8d916a:
	mov_s r3,r4
L_8d916c:
	mov r4,0x10
L_8d9170:
	bl.d L_8deaac
L_8d9174:
	mov r5,0x5
L_8d9178:
	mov_s r18,r13
L_8d917a:
	breq_s r0,0,L_8d91b8
L_8d917c:
	sub r13,r18,0x1
L_8d9180:
	/* brhs.d r13,0x1,0x008d9144 */
	.byte 0xc5,0x0d,0x75,0x90
L_8d9184:
	/* _add_s r15,0x1 */
	.byte 0x01,0xe7
	.global L_8d9186
L_8d9186:
	ld_s r0,[sp,0x8]
L_8d9188:
	add r19,r19,0x1
L_8d918c:
	brlo r19,r0,L_8d9114
	.global L_8d9190
L_8d9190:
	bl L_8e4694
L_8d9194:
	mov_s r2,0x10058a0
L_8d919a:
	sub r0,r0,r22
L_8d919e:
	asl r4,r0,0x4
L_8d91a2:
	mov_s r0,0x0
L_8d91a4:
	mov_s r1,0x2
L_8d91a6:
	bl.d L_8edff8
L_8d91aa:
	ld_s r3,[sp,0x0]
L_8d91ac:
	mov_s r0,0x1
L_8d91ae:
	b_s L_8d91b2
	.global L_8d91b0
L_8d91b0:
	mov_s r0,0x0
	.global L_8d91b2
L_8d91b2:
	b.d L_8c02f4
L_8d91b6:
	add_s sp,sp,0x2c
	.global L_8d91b8
L_8d91b8:
	mov_s r2,0x1005918
L_8d91be:
	mov_s r0,0x0
L_8d91c0:
	mov_s r1,0x0
L_8d91c2:
	mov_s r3,r15
L_8d91c4:
	mov r4,r19
L_8d91c8:
	bl.d L_8ee034
L_8d91cc:
	ld r5,[sp]
L_8d91d0:
	b_s L_8d91b0
L_8d91d2:
	nop_s
