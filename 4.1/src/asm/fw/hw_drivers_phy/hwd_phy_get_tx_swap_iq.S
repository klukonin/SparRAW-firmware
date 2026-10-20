/* hwd_phy_get_tx_swap_iq @ 0x8cefb0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_phy_get_tx_swap_iq: I and Q inverse values are not the same, I=%d, Q=%d.
 * Зовут его: hwf_calib__acquire_hw
 * Зовёт сам: __ld_r13_ret, fw_log__emit2
 */
	.section .text.hwd_phy_get_tx_swap_iq,"ax",@progbits
	.global hwd_phy_get_tx_swap_iq
hwd_phy_get_tx_swap_iq:
	.global L_8cefb0
L_8cefb0:
	push_s blink
L_8cefb2:
	push_s r13
L_8cefb4:
	mov_s r1,0x884000
L_8cefba:
	ld_s r0,[r1,0x28]
L_8cefbc:
	ld_s r13,[r1,0x28]
L_8cefbe:
	bmsk r3,r0,0x0
L_8cefc2:
	lsr_s r13,r13
L_8cefc4:
	bmsk_s r13,r13,0x0
L_8cefc6:
	breq r3,r13,L_8cefdc
L_8cefca:
	mov_s r2,0x101874c
L_8cefd0:
	mov_s r0,0x1
L_8cefd2:
	mov_s r1,r0
L_8cefd4:
	bl.d L_8edff8
L_8cefd8:
	mov_s r4,r13
L_8cefda:
	b_s L_8cefea
	.global L_8cefdc
L_8cefdc:
	btst_s r0,0x0
L_8cefde:
	mov.eq r0,0x0
L_8cefe2:
	beq_s L_8cefec
L_8cefe4:
	btst_s r0,0x0
L_8cefe6:
	mov_s r0,0x1
L_8cefe8:
	bne_s L_8cefec
	.global L_8cefea
L_8cefea:
	mov_s r0,0x3
	.global L_8cefec
L_8cefec:
	b L_8c033c
