/* rgf_reg_880280_8ea634 @ 0x8ea634, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_kill__poll_and_notify, rf_kill_sm__init
 */
	.section .text.rgf_reg_880280_8ea634,"ax",@progbits
	.global rgf_reg_880280_8ea634
rgf_reg_880280_8ea634:
	.global L_8ea634
L_8ea634:
	mov_s r1,0x0
	.global L_8ea636
L_8ea636:
	mov_s r2,0x880280
L_8ea63c:
	ld_s r0,[r2,0x8]
L_8ea63e:
	btst_s r0,0x0
L_8ea640:
	ld_s r0,[r2,0x8]
L_8ea642:
	bne_s L_8ea650
L_8ea644:
	bset_s r0,r0,0x1
L_8ea646:
	st_s r0,[r2,0x8]
L_8ea648:
	ld_s r0,[r2,0x8]
L_8ea64a:
	bbit1 r0,0x0,L_8ea65c
L_8ea64e:
	b_s L_8ea65a
	.global L_8ea650
L_8ea650:
	bclr_s r0,r0,0x1
L_8ea652:
	st_s r0,[r2,0x8]
L_8ea654:
	ld_s r0,[r2,0x8]
L_8ea656:
	bbit0 r0,0x0,L_8ea65c
	.global L_8ea65a
L_8ea65a:
	mov_s r1,0x1
	.global L_8ea65c
L_8ea65c:
	breq_s r1,0,L_8ea636
L_8ea65e:
	j_s [blink]
