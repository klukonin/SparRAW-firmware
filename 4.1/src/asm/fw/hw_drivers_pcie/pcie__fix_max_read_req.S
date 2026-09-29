/* pcie__fix_max_read_req @ 0x8ceb80, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCIE: EP under Serdes: DevCtl: Chk MaxReadReq configuration!!!
 *   PCIE: EP under Serdes: DevCtl: MaxReadReq is more than 512Byte - Fixing it (0x%x)!!!
 *   PCIE: EP under Serdes: DevCtl: MaxReadReq Fix: from (0x%x) to (0x%x)
 * Зовут его: pcie__l1_sub_timing_setup
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit2, get_reg8825bc_bit3_inv, hwd_pcie_dbi_write, pcie_serdes_step
 */
	.section .text.pcie__fix_max_read_req,"ax",@progbits
	.global pcie__fix_max_read_req
pcie__fix_max_read_req:
	.global L_8ceb80
L_8ceb80:
	push_s blink
L_8ceb82:
	bl L_8c02c0
L_8ceb86:
	bl.d L_8ce774
L_8ceb8a:
	sub_s sp,sp,0x8
L_8ceb8c:
	breq_s r0,0,L_8cec06
L_8ceb8e:
	mov_s r2,0x1018b80
L_8ceb94:
	mov_s r0,0x1
L_8ceb96:
	bl.d L_8edfb0
L_8ceb9a:
	mov_s r1,0x2
L_8ceb9c:
	add r6,sp,0x4
L_8ceba0:
	mov_s r0,0x78
L_8ceba2:
	mov_s r13,0x0
L_8ceba4:
	mov_s r1,r13
L_8ceba6:
	mov_s r2,0x1
L_8ceba8:
	mov_s r3,r13
L_8cebaa:
	mov_s r4,r13
L_8cebac:
	bl.d L_8eaa64
L_8cebb0:
	mov r5,0x1
L_8cebb4:
	ld_s r3,[sp,0x4]
L_8cebb6:
	lsr r0,r3,0xc
L_8cebba:
	bmsk_s r0,r0,0x2
L_8cebbc:
	brlo r0,0x3,L_8cec06
L_8cebc0:
	mov_s r2,0x1018bc0
L_8cebc6:
	mov_s r0,0x1
L_8cebc8:
	bl.d L_8edfcc
L_8cebcc:
	mov_s r1,r13
L_8cebce:
	ld_s r3,[sp,0x4]
L_8cebd0:
	mov_s r2,0x1018c18
L_8cebd6:
	bclr r14,r3,0xc
L_8cebda:
	bclr_s r14,r14,0xd
L_8cebdc:
	bclr_s r14,r14,0xe
L_8cebde:
	bset r15,r14,0xd
L_8cebe2:
	mov_s r0,0x1
L_8cebe4:
	mov_s r1,0x2
L_8cebe6:
	bl.d L_8edff8
L_8cebea:
	mov_s r4,r15
L_8cebec:
	st_s r13,[sp,0x0]
L_8cebee:
	mov_s r0,0x78
L_8cebf0:
	mov_s r1,r15
L_8cebf2:
	mov_s r2,r13
L_8cebf4:
	mov_s r3,0x1
L_8cebf6:
	mov_s r4,r13
L_8cebf8:
	mov_s r5,r13
L_8cebfa:
	mov r6,0x1
L_8cebfe:
	bl.d L_8eab94
L_8cec02:
	mov r7,0x1
	.global L_8cec06
L_8cec06:
	b.d L_8c032c
L_8cec0a:
	add_s sp,sp,0x8
