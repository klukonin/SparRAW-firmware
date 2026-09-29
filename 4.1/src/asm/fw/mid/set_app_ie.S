/* set_app_ie @ 0x8e14bc, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   set_app_ie: frame type %x length %d
 *   mid.cpp
 * Зовут его: mid__apply_app_ies
 * Зовёт сам: TX_API__free_memory, __ld_r18_to_r13_ret, __st_r18_to_r13, app_ie__print_ies, app_ies__clear, app_ies__set_buffer, fw_log__emit2, fw_sysassert_fatal
 */
	.section .text.set_app_ie,"ax",@progbits
	.global set_app_ie
set_app_ie:
	.global L_8e14bc
L_8e14bc:
	push_s blink
L_8e14be:
	bl L_8c02b4
L_8e14c2:
	mov_s r16,r0
L_8e14c4:
	mov_s r13,r1
L_8e14c6:
	mov_s r17,r2
L_8e14c8:
	mov_s r18,r3
L_8e14ca:
	mov_s r2,0x100b390
L_8e14d0:
	mov_s r0,0xb
L_8e14d2:
	mov_s r1,0x2
L_8e14d4:
	mov_s r3,r13
L_8e14d6:
	bl.d L_8edff8
L_8e14da:
	mov r4,r17
L_8e14de:
	brhs r13,0x5,L_8e1532
L_8e14e2:
	ldb.x r13,[0x801e7c,r13]
L_8e14ea:
	add r0,pcl,0xa
L_8e14ee:
	add1_s r0,r0,r13
L_8e14f0:
	j_s [r0]
L_8e14f2:
	add r16,r16,0x1e0
L_8e14f6:
	b_s L_8e150e
L_8e14f8:
	add r16,r16,0x1b0
L_8e14fc:
	b_s L_8e150e
L_8e14fe:
	add r16,r16,0x1bc
L_8e1502:
	b_s L_8e150e
L_8e1504:
	add r16,r16,0x1c8
L_8e1508:
	b_s L_8e150e
L_8e150a:
	add r16,r16,0x1d4
	.global L_8e150e
L_8e150e:
	bl.d L_8c5a00
L_8e1512:
	mov_s r0,r16
L_8e1514:
	cmp_s r0,0x0
L_8e1516:
	bl.ne L_8c94c4
L_8e151a:
	breq r17,0x0,L_8e1548
L_8e151e:
	mov_s r0,r16
L_8e1520:
	mov_s r1,r18
L_8e1522:
	mov_s r2,r17
L_8e1524:
	bl.d L_8e1afc
L_8e1528:
	mov_s r3,0x0
L_8e152a:
	bl.d L_8dce44
L_8e152e:
	mov_s r0,r16
L_8e1530:
	b_s L_8e1548
	.global L_8e1532
L_8e1532:
	mov_s r0,blink
L_8e1534:
	mov_s r2,0x100aedc
L_8e153a:
	mov_s r1,0x11f4
L_8e1540:
	bl.d L_8c82c0
L_8e1544:
	mov r3,0x746
	.global L_8e1548
L_8e1548:
	b L_8c0314
