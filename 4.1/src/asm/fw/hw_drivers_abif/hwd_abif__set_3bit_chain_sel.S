/* hwd_abif__set_3bit_chain_sel @ 0x8cd34c, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: rfc__select_chain_and_write
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, ut_hw_drivers_cmd_0x122
 */
	.section .text.hwd_abif__set_3bit_chain_sel,"ax",@progbits
	.global hwd_abif__set_3bit_chain_sel
hwd_abif__set_3bit_chain_sel:
	.global L_8cd34c
L_8cd34c:
	push_s blink
L_8cd34e:
	bl L_8c02bc
L_8cd352:
	mov_s r13,r0
L_8cd354:
	mov_s r0,0x0
L_8cd356:
	bl.d L_8ccf48
L_8cd35a:
	mov_s r1,r13
L_8cd35c:
	mov_s r0,0x1
L_8cd35e:
	bl.d L_8ccf48
L_8cd362:
	mov_s r1,r13
L_8cd364:
	bic.f r15,r13,0x7
L_8cd368:
	bne_s L_8cd3a2
	.global L_8cd36a
L_8cd36a:
	mov_s r14,0x88af00
L_8cd370:
	ld_s r0,[r14,0x6c]
L_8cd372:
	mov r16,0x88b000
L_8cd37a:
	bic r0,r0,0x7
L_8cd37e:
	or_s r0,r0,r13
L_8cd380:
	st_s r0,[r14,0x6c]
L_8cd382:
	brne_s r15,0,L_8cd3b6
	.global L_8cd384
L_8cd384:
	ld_s r0,[r14,0x78]
L_8cd386:
	bic r0,r0,0x7
L_8cd38a:
	or_s r0,r0,r13
L_8cd38c:
	st_s r0,[r14,0x78]
L_8cd38e:
	brne_s r15,0,L_8cd3ca
	.global L_8cd390
L_8cd390:
	ld r0,[r16, -0x7c]
L_8cd394:
	bic r0,r0,0x7
L_8cd398:
	or_s r13,r13,r0
L_8cd39a:
	st r13,[r16, -0x7c]
L_8cd39e:
	b L_8c0324
	.global L_8cd3a2
L_8cd3a2:
	mov_s r0,blink
L_8cd3a4:
	mov_s r2,0x1019954
L_8cd3aa:
	mov_s r1,0xac
L_8cd3ac:
	bl.d L_8c82c0
L_8cd3b0:
	mov r3,0x7f2
L_8cd3b4:
	b_s L_8cd36a
	.global L_8cd3b6
L_8cd3b6:
	mov_s r0,blink
L_8cd3b8:
	mov_s r2,0x1019954
L_8cd3be:
	mov_s r1,0xac
L_8cd3c0:
	bl.d L_8c82c0
L_8cd3c4:
	mov r3,0x7f3
L_8cd3c8:
	b_s L_8cd384
	.global L_8cd3ca
L_8cd3ca:
	mov_s r0,blink
L_8cd3cc:
	mov_s r2,0x1019954
L_8cd3d2:
	mov_s r1,0xac
L_8cd3d4:
	bl.d L_8c82c0
L_8cd3d8:
	mov r3,0x7f4
L_8cd3dc:
	b_s L_8cd390
L_8cd3de:
	nop_s
