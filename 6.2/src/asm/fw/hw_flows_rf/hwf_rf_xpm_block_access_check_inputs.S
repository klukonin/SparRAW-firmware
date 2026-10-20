/* hwf_rf_xpm_block_access_check_inputs @ 0x8f46f4, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_block_access_check_inputs
 *   %s : Value <%s>=
 *   num_bytes
 *   [NNL]%d is out valid range [%d,%d]
 *   %s : <%s>=
 *   (xpm_start_bit_address+8*num_bytes-1)
 *   [NNL]=0x%x is out of valid XPM bit addresses range [0,0x%x]
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler, host_if__read_rf_xpm_handler, host_if__write_rf_xpm_handler, hwf_rf_xpm_read_block, hwf_rf_xpm_read_block_8f4b70
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit2_tsf, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, hwf_rf_check_rf_id
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf_xpm_block_access_check_inputs
hwf_rf_xpm_block_access_check_inputs:
	.global L_8f46f4
L_8f46f4:
	push_s blink
L_8f46f6:
	bl L_8c01d0
L_8f46fa:
	mov_s r16,r1
L_8f46fc:
	mov_s r13,r2
L_8f46fe:
	mov_s r17,r3
L_8f4700:
	mov r19,r4
L_8f4704:
	mov r18,r5
L_8f4708:
	mov_s r15,0x101b658
L_8f470e:
	mov_s r1,r15
L_8f4710:
	bl.d L_8e2f18
L_8f4714:
	mov_s r2,r5
L_8f4716:
	brne r0,0x1,L_8f47d4
L_8f471a:
	brlo.d r19,r13,L_8f4722
L_8f471e:
	mov_s r14,0x1
L_8f4720:
	brne_s r13,0,L_8f4760
	.global L_8f4722
L_8f4722:
	mov_s r1,0x101b680
L_8f4728:
	mov_s r3,0x101b694
L_8f472e:
	mov_s r14,0x0
L_8f4730:
	mov_s r0,r14
L_8f4732:
	bl.d L_8dce04
L_8f4736:
	mov_s r2,r15
L_8f4738:
	mov_s r1,0x101b6a0
L_8f473e:
	mov_s r0,r14
L_8f4740:
	mov_s r2,r13
L_8f4742:
	mov_s r3,0x1
L_8f4744:
	bl.d L_8dcd00
L_8f4748:
	mov r4,r19
L_8f474c:
	cmp r18,0x0
L_8f4750:
	mov.ne r0,blink
L_8f4754:
	mov.ne r1,0x155c
L_8f475c:
	bl.ne L_8c9b28
	.global L_8f4760
L_8f4760:
	add3 r0,r16,r13
L_8f4764:
	sub_s r1,r0,0x1
L_8f4766:
	cmp_s r0,0x0
L_8f4768:
	mov.ne r13,r1
L_8f476c:
	mov.eq r13,r0
L_8f4770:
	brlo r13,0x2000,L_8f47b4
L_8f4778:
	mov_s r1,0x101b600
L_8f477e:
	mov_s r3,0x101b6c4
L_8f4784:
	mov_s r14,0x0
L_8f4786:
	mov_s r0,r14
L_8f4788:
	bl.d L_8dce04
L_8f478c:
	mov_s r2,r15
L_8f478e:
	mov_s r1,0x101b61c
L_8f4794:
	mov_s r0,r14
L_8f4796:
	mov_s r2,r13
L_8f4798:
	mov_s r3,0x0
L_8f479a:
	bl.d L_8dcc80
L_8f479e:
	bset_s r3,r3,0xd
L_8f47a0:
	cmp r18,0x0
L_8f47a4:
	mov.ne r0,blink
L_8f47a8:
	mov.ne r1,0x155d
L_8f47b0:
	bl.ne L_8c9b28
	.global L_8f47b4
L_8f47b4:
	cmp r17,0x0
L_8f47b8:
	mov.eq r0,blink
L_8f47bc:
	mov.eq r1,0x155e
L_8f47c4:
	bl.eq L_8c9b28
L_8f47c8:
	cmp_s r14,0x0
L_8f47ca:
	mov_s r1,0x1
L_8f47cc:
	sub_s.ne r1,r1,r1
L_8f47ce:
	mov_s r0,0x1
L_8f47d0:
	add1_s r0,r0,r1
L_8f47d2:
	b_s L_8f47d6
	.global L_8f47d4
L_8f47d4:
	mov_s r0,0x3
	.global L_8f47d6
L_8f47d6:
	b L_8c022c
L_8f47da:
	nop_s
