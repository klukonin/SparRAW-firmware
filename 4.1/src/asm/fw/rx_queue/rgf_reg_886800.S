/* rgf_reg_886800 @ 0x8efddc, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_queue.c
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.rgf_reg_886800,"ax",@progbits
	.global rgf_reg_886800
rgf_reg_886800:
	.global L_8efddc
L_8efddc:
	push_s blink
L_8efdde:
	push_s r13
L_8efde0:
	mov_s r13,r0
L_8efde2:
	bclr.f r0,r0,0x0
L_8efde6:
	bne_s L_8efdfa
	.global L_8efde8
L_8efde8:
	mov_s r1,0x886800
L_8efdee:
	ld_s r0,[r1,0x38]
L_8efdf0:
	bclr_s r0,r0,0x0
L_8efdf2:
	or_s r13,r13,r0
L_8efdf4:
	st_s r13,[r1,0x38]
L_8efdf6:
	b L_8c033c
	.global L_8efdfa
L_8efdfa:
	mov_s r0,blink
L_8efdfc:
	mov_s r2,0x1010150
L_8efe02:
	mov_s r1,0xac
L_8efe04:
	bl.d L_8c82c0
L_8efe08:
	mov r3,0x25f
L_8efe0c:
	b_s L_8efde8
L_8efe0e:
	nop_s
