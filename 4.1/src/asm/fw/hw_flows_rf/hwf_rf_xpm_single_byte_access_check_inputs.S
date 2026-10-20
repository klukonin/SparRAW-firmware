/* hwf_rf_xpm_single_byte_access_check_inputs @ 0x8ec360, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_single_byte_access_check_inputs
 *   %s : <%s>=
 *   xpm_bit_address
 *   [NNL]=0x%x is out of valid XPM bit addresses range [0,0x%x]
 *   hw_flows_rf.c
 * Зовут его: hwf_rf_xpm_read_byte
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit2, fw_log__emit2_nonl, fw_sysassert_fatal, hwf_rf_check_rf_id
 */
	.section .text.hwf_rf_xpm_single_byte_access_check_inputs,"ax",@progbits
	.global hwf_rf_xpm_single_byte_access_check_inputs
hwf_rf_xpm_single_byte_access_check_inputs:
	.global L_8ec360
L_8ec360:
	push_s blink
L_8ec362:
	bl L_8c02bc
L_8ec366:
	mov_s r16,r1
L_8ec368:
	mov_s r15,r2
L_8ec36a:
	mov_s r14,0x1016f78
L_8ec370:
	bl.d L_8efcec
L_8ec374:
	mov_s r1,r14
L_8ec376:
	brne r0,0x1,L_8ec3de
L_8ec37a:
	cmp r16,0x2000
L_8ec382:
	bcs.d L_8ec3d2
L_8ec386:
	mov_s r13,0x1
L_8ec388:
	mov_s r2,0x1016fa4
L_8ec38e:
	mov r4,0x1016fb0
L_8ec396:
	mov_s r13,0x0
L_8ec398:
	mov_s r0,r13
L_8ec39a:
	mov_s r1,r13
L_8ec39c:
	bl.d L_8ee0ac
L_8ec3a0:
	mov_s r3,r14
L_8ec3a2:
	mov_s r2,0x1016fc0
L_8ec3a8:
	mov_s r0,r13
L_8ec3aa:
	mov_s r1,r13
L_8ec3ac:
	mov r4,0x2000
L_8ec3b4:
	bl.d L_8edff8
L_8ec3b8:
	mov_s r3,r16
L_8ec3ba:
	breq_s r15,0,L_8ec3d2
L_8ec3bc:
	mov_s r0,blink
L_8ec3be:
	mov_s r2,0x1016c54
L_8ec3c4:
	mov_s r1,0x155b
L_8ec3ca:
	bl.d L_8c82c0
L_8ec3ce:
	mov r3,0x18e
	.global L_8ec3d2
L_8ec3d2:
	cmp_s r13,0x0
L_8ec3d4:
	mov_s r1,0x1
L_8ec3d6:
	sub_s.ne r1,r1,r1
L_8ec3d8:
	mov_s r0,0x1
L_8ec3da:
	add1_s r0,r0,r1
L_8ec3dc:
	b_s L_8ec3e0
	.global L_8ec3de
L_8ec3de:
	mov_s r0,0x3
	.global L_8ec3e0
L_8ec3e0:
	b L_8c0324
