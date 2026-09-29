/* uc_pending__clear_bit @ 0x928f6c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__clear_pending_and_notify, bf_sm__release_sta, bi_manager__rx_bi_flow, internal_tx__clear_pending, internal_tx__pending_sm, pm__wake_sequence
 * Зовёт сам: set_reg_886f00_928d78
 */
	.section .text.uc_pending__clear_bit,"ax",@progbits
	.global uc_pending__clear_bit
uc_pending__clear_bit:
	.global L_928f6c
L_928f6c:
	push_s blink
L_928f6e:
	lr r3,[0xa]
L_928f72:
	bclr r1,r3,0x1
L_928f76:
	flag r1
L_928f7a:
	mov_s r2,0x800674
L_928f80:
	ld_s r1,[r2]
L_928f82:
	bclr.f r1,r1,r0
L_928f86:
	st_s r1,[r2]
L_928f88:
	bl.eq L_928d78
L_928f8c:
	lr r0,[0xa]
L_928f90:
	bic r3,r3,-0x3
L_928f94:
	or_s r3,r3,r0
L_928f96:
	flag r3
L_928f9a:
	pop_s blink
L_928f9c:
	j_s [blink]
L_928f9e:
	nop_s
