/* pcie__fix_max_read_req @ 0x8d1864, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCIE: EP under Serdes: DevCtl: Chk MaxReadReq configuration!!!
 *   PCIE: EP under Serdes: DevCtl: MaxReadReq is more than 512Byte - Fixing it (0x%x)!!!
 *   PCIE: EP under Serdes: DevCtl: MaxReadReq Fix: from (0x%x) to (0x%x)
 * Зовут его: pcie_serdes__init_seq
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, dbi_write, fw_log_emit0, fw_log_emit1, fw_log_emit2, hwd_pcie__is_ep_under_serdes, pcie__dbi_read
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__fix_max_read_req
pcie__fix_max_read_req:
	.global L_8d1864
L_8d1864:
	push_s blink
L_8d1866:
	bl L_8c01e4
L_8d186a:
	bl.d L_8d1470
L_8d186e:
	sub_s sp,sp,0x8
L_8d1870:
	breq_s r0,0,L_8d18e0
L_8d1872:
	mov_s r1,0x101dd30
L_8d1878:
	bl.d L_8dcba8
L_8d187c:
	mov_s r0,0x21
L_8d187e:
	add r6,sp,0x4
L_8d1882:
	mov_s r0,0x78
L_8d1884:
	mov_s r13,0x0
L_8d1886:
	mov_s r1,r13
L_8d1888:
	mov_s r2,0x1
L_8d188a:
	mov_s r3,r13
L_8d188c:
	mov_s r4,r13
L_8d188e:
	bl.d L_8c8208
L_8d1892:
	mov_s r5,r2
L_8d1894:
	ld_s r2,[sp,0x4]
L_8d1896:
	lsr r0,r2,0xc
L_8d189a:
	bmsk_s r0,r0,0x2
L_8d189c:
	brlo r0,0x3,L_8d18e0
L_8d18a0:
	mov_s r1,0x101dd70
L_8d18a6:
	bl.d L_8dcc10
L_8d18aa:
	mov_s r0,0x1
L_8d18ac:
	ld_s r2,[sp,0x4]
L_8d18ae:
	mov_s r1,0x101ddc8
L_8d18b4:
	bclr r14,r2,0xc
L_8d18b8:
	bclr_s r14,r14,0xd
L_8d18ba:
	bclr_s r14,r14,0xe
L_8d18bc:
	bset_s r14,r14,0xd
L_8d18be:
	mov_s r0,0x21
L_8d18c0:
	bl.d L_8dcc80
L_8d18c4:
	mov_s r3,r14
L_8d18c6:
	st_s r13,[sp,0x0]
L_8d18c8:
	mov_s r0,0x78
L_8d18ca:
	mov_s r1,r14
L_8d18cc:
	mov_s r2,r13
L_8d18ce:
	mov_s r3,0x1
L_8d18d0:
	mov_s r4,r13
L_8d18d2:
	mov_s r5,r13
L_8d18d4:
	mov r6,0x1
L_8d18d8:
	bl.d L_8c8338
L_8d18dc:
	mov r7,0x1
	.global L_8d18e0
L_8d18e0:
	b.d L_8c0254
L_8d18e4:
	add_s sp,sp,0x8
L_8d18e6:
	nop_s
