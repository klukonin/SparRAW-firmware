/* marlon_r_if_class__load_brd_parameters_section @ 0x8d8f80, 296 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   marlon_r_if_class::load_brd_parameters_section: BRD Section Write to RF Started, section_type=%d
 *   marlon_r_if_class::load_brd_parameters_section: g_shared_mem_ipc.valid_antennas_vec = 0x%X, invalid antennas = 0x%X, VALID_ANTENNAS_BRD_LABEL_ADDR=0x%X
 *   marlon_r_if_class::load_brd_parameters_section: BRD Section Write to RF Completed, section_type=%d, elapsed_time=%d [usec]
 * Зовут его: WBE_DRIVER__pcie_boot_init, marlon_r_if_class__load_brd_rf_cfg_section
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, div_round_up, fw_log__emit1, fw_log__emit2, fw_log__emit3, fw_read_timer, stub_ret_8e70d4, stub_ret_8e70d8, tail_brd_if__clear_block_info, tail_brd_if__clear_section_info
 */
	.section .text.marlon_r_if_class__load_brd_parameters_section,"ax",@progbits
	.global marlon_r_if_class__load_brd_parameters_section
marlon_r_if_class__load_brd_parameters_section:
	.global L_8d8f80
L_8d8f80:
	push_s blink
L_8d8f82:
	bl L_8c02a0
L_8d8f86:
	sub_s sp,sp,0x28
L_8d8f88:
	mov_s r14,r0
L_8d8f8a:
	mov_s r21,r1
L_8d8f8c:
	mov_s r0,sp
L_8d8f8e:
	mov_s r18,r0
L_8d8f90:
	mov_s r1,0x0
L_8d8f92:
	bl.d L_8c17e4
L_8d8f96:
	mov_s r16,r1
L_8d8f98:
	ld_s r0,[r14,0x20]
L_8d8f9a:
	breq r0,0x0,L_8d9060
L_8d8f9e:
	ld_s r1,[r0]
L_8d8fa0:
	ld_s r3,[r1,0x4]
L_8d8fa2:
	mov_s r1,r16
L_8d8fa4:
	jl_s.d [r3]
L_8d8fa6:
	mov_s r2,r18
L_8d8fa8:
	breq r0,0x0,L_8d9060
L_8d8fac:
	bl L_8e4694
L_8d8fb0:
	mov_s r23,r0
L_8d8fb2:
	mov_s r2,0x10054a8
L_8d8fb8:
	mov_s r0,r16
L_8d8fba:
	mov_s r1,0x2
L_8d8fbc:
	bl.d L_8edfcc
L_8d8fc0:
	ld_s r3,[sp,0x0]
L_8d8fc2:
	bl.d L_8e70d8
L_8d8fc6:
	mov_s r0,r18
L_8d8fc8:
	mov_s r0,0x857000
L_8d8fce:
	mov_s r20,r0
L_8d8fd0:
	st 0xfff1fbf7,[r0, 0x4c]
L_8d8fd8:
	add_s r0,sp,0x10
L_8d8fda:
	mov_s r19,r0
L_8d8fdc:
	bl.d L_8c17e0
L_8d8fe0:
	mov_s r1,r16
L_8d8fe2:
	ld_s r0,[sp,0x4]
L_8d8fe4:
	brlo r0,0x1,L_8d9084
	.global L_8d8fe8
L_8d8fe8:
	ld_s r0,[r14,0x20]
L_8d8fea:
	mov_s r2,r16
L_8d8fec:
	ld_s r1,[r0]
L_8d8fee:
	ld_s r13,[r1,0x8]
L_8d8ff0:
	mov_s r1,r18
L_8d8ff2:
	jl_s.d [r13]
L_8d8ff4:
	mov_s r3,r19
L_8d8ff6:
	breq_s r0,0,L_8d9060
L_8d8ff8:
	mov_s r0,r19
L_8d8ffa:
	bl.d L_8c9d5c
L_8d8ffe:
	mov_s r1,r21
L_8d9000:
	mov_s r13,r0
L_8d9002:
	bl.d L_8e70d4
L_8d9006:
	mov_s r0,r19
L_8d9008:
	brlo.d r13,0x1,L_8d907a
L_8d900c:
	mov_s r0,0x0
	.global L_8d900e
L_8d900e:
	mov_s r17,r0
L_8d9010:
	ld_s r0,[r14,0x20]
L_8d9012:
	mov_s r22,r13
L_8d9014:
	ld_s r1,[r0]
L_8d9016:
	add r4,r14,0x24
L_8d901a:
	ld_s r13,[r1,0xc]
L_8d901c:
	mov_s r1,r18
L_8d901e:
	mov_s r2,r19
L_8d9020:
	mov_s r3,r17
L_8d9022:
	jl_s.d [r13]
L_8d9024:
	mov r5,r21
L_8d9028:
	brlo.d r0,0x1,L_8d906e
L_8d902c:
	mov_s r13,0x0
	.global L_8d902e
L_8d902e:
	mov_s r15,r0
L_8d9030:
	add3 r0,r14,r13
L_8d9034:
	ld_s r1,[r0,0x24]
L_8d9036:
	ld_s r3,[r0,0x28]
L_8d9038:
	brne r1,0x8fffff,L_8d9064
L_8d9040:
	st r3,[r20, 0x4c]
L_8d9044:
	mov_s r2,0x100550c
L_8d904a:
	mov_s r0,0x0
L_8d904c:
	mov_s r1,0x2
L_8d904e:
	mov r5,0x8fffff
L_8d9056:
	bl.d L_8ee034
L_8d905a:
	not r4,r3
L_8d905e:
	b_s L_8d9066
	.global L_8d9060
L_8d9060:
	mov_s r0,0x0
L_8d9062:
	b_s L_8d90a2
	.global L_8d9064
L_8d9064:
	st_s r3,[r1]
	.global L_8d9066
L_8d9066:
	sub_s r0,r15,0x1
L_8d9068:
	/* brhs.d r0,0x1,0x008d902e */
	.byte 0xc7,0x08,0x75,0x80
L_8d906c:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8d906e
L_8d906e:
	sub r13,r22,0x1
L_8d9072:
	brhs.d r13,0x1,L_8d900e
L_8d9076:
	add r0,r17,0x1
	.global L_8d907a
L_8d907a:
	ld_s r0,[sp,0x4]
L_8d907c:
	add r16,r16,0x1
L_8d9080:
	brlo r16,r0,L_8d8fe8
	.global L_8d9084
L_8d9084:
	bl L_8e4694
L_8d9088:
	mov_s r2,0x10055a4
L_8d908e:
	sub r0,r0,r23
L_8d9092:
	asl r4,r0,0x4
L_8d9096:
	mov_s r0,0x0
L_8d9098:
	mov_s r1,0x2
L_8d909a:
	bl.d L_8edff8
L_8d909e:
	mov_s r3,r0
L_8d90a0:
	mov_s r0,0x1
	.global L_8d90a2
L_8d90a2:
	b.d L_8c02ec
L_8d90a6:
	add_s sp,sp,0x28
