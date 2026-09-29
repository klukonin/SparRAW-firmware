/* xpm__read_3cc @ 0x8d4680, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_rf_xpm_cfg_get
 * Зовёт сам: hwd_rfc_read_rgf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global xpm__read_3cc
xpm__read_3cc:
	.global L_8d4680
L_8d4680:
	push_s blink
L_8d4682:
	extb_s r0,r0
L_8d4684:
	bl.d L_8d3588
L_8d4688:
	mov r1,0x3cc
L_8d468c:
	bmsk_s r0,r0,0x17
L_8d468e:
	pop_s blink
L_8d4690:
	j_s [blink]
L_8d4692:
	nop_s
