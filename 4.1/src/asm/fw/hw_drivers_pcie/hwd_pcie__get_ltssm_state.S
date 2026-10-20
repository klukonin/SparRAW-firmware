/* hwd_pcie__get_ltssm_state @ 0x8ce700, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter, hwd_pcie__is_l1_state, link_lost_diag__dump_pcie
 * Зовёт сам: get_reg8825bc_bit3_inv
 */
	.section .text.hwd_pcie__get_ltssm_state,"ax",@progbits
	.global hwd_pcie__get_ltssm_state
hwd_pcie__get_ltssm_state:
	.global L_8ce700
L_8ce700:
	push_s blink
L_8ce702:
	bl L_8ce774
L_8ce706:
	breq_s r0,0,L_8ce712
L_8ce708:
	mov_s r0,0x882580
L_8ce70e:
	ld_s r0,[r0,0xc]
L_8ce710:
	b_s L_8ce71a
	.global L_8ce712
L_8ce712:
	mov_s r0,0x882080
L_8ce718:
	ld_s r0,[r0,0x40]
	.global L_8ce71a
L_8ce71a:
	bmsk_s r0,r0,0x4
L_8ce71c:
	pop_s blink
L_8ce71e:
	j_s [blink]
