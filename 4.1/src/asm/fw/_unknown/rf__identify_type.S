/* rf__identify_type @ 0x8ec45c, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *         Identify RF Type: device_id=%d val1=0x%X val2=0x%X
 *         Identify RF Type : Falcon
 *         Identify RF Type : UNKNOWN !!!
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, check_rf_boardfile, fr_clr_mdm_crc_statistics, fw_log__emit0, fw_log__emit3, get_reg_880a7c, tail_hwd_rfc_read_rgf
 */
	.section .text.rf__identify_type,"ax",@progbits
	.global rf__identify_type
rf__identify_type:
	.global L_8ec45c
L_8ec45c:
	push_s blink
L_8ec45e:
	bl L_8c02b8
L_8ec462:
	bl.d L_8c9220
L_8ec466:
	mov_s r14,r0
L_8ec468:
	mov_s r13,0x0
L_8ec46a:
	mov_s r0,r14
L_8ec46c:
	mov_s r1,r13
L_8ec46e:
	bl.d L_8ddd74
L_8ec472:
	mov r2,0x428
L_8ec476:
	mov_s r16,r0
L_8ec478:
	mov_s r0,r14
L_8ec47a:
	mov_s r1,r13
L_8ec47c:
	bl.d L_8ddd74
L_8ec480:
	mov r2,0x428
L_8ec484:
	mov_s r17,r0
L_8ec486:
	mov_s r2,0x1005274
L_8ec48c:
	mov_s r0,r13
L_8ec48e:
	mov_s r15,0x2
L_8ec490:
	mov_s r1,r15
L_8ec492:
	mov_s r3,r13
L_8ec494:
	mov r4,r16
L_8ec498:
	bl.d L_8ee034
L_8ec49c:
	mov r5,r17
L_8ec4a0:
	add r0,r16,0x1
L_8ec4a4:
	brne r0,r17,L_8ec4ba
L_8ec4a8:
	stb_s r13,[r14]
L_8ec4aa:
	mov_s r2,0x10052b0
L_8ec4b0:
	mov_s r0,r13
L_8ec4b2:
	mov_s r1,r15
L_8ec4b4:
	mov_s r16,r13
L_8ec4b6:
	mov_s r13,r15
L_8ec4b8:
	b_s L_8ec4cc
	.global L_8ec4ba
L_8ec4ba:
	mov r16,0x1
L_8ec4be:
	mov_s r0,0xa
L_8ec4c0:
	stb_s r0,[r14]
L_8ec4c2:
	mov_s r2,0x10052d0
L_8ec4c8:
	mov_s r0,r13
L_8ec4ca:
	mov_s r1,r13
	.global L_8ec4cc
L_8ec4cc:
	bl L_8edfb0
L_8ec4d0:
	mov_s r1,0x880a3c
L_8ec4d6:
	st r16,[r1, 0x2c]
L_8ec4da:
	stw r13,[r1, 0x52]
L_8ec4de:
	mov_s r0,0x1
L_8ec4e0:
	bl.d L_8d74f8
L_8ec4e4:
	st_s r0,[r14,0x4]
L_8ec4e6:
	cmp_s r0,0x1
L_8ec4e8:
	bl.eq.d L_8ea224
L_8ec4ec:
	mov.eq r0,r14
L_8ec4f0:
	b L_8c031c
