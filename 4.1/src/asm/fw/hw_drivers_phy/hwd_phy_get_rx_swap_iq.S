/* hwd_phy_get_rx_swap_iq @ 0x8cef4c, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_phy_get_rx_swap_iq: I and Q inverse values are not the same, I=%d, Q=%d.
 * Зовут его: hwf_calib__acquire_hw
 * Зовёт сам: __ld_r13_ret, fw_log__emit2
 */
	.section .text.hwd_phy_get_rx_swap_iq,"ax",@progbits
	.global hwd_phy_get_rx_swap_iq
hwd_phy_get_rx_swap_iq:
	.global L_8cef4c
L_8cef4c:
	push_s blink
L_8cef4e:
	push_s r13
L_8cef50:
	mov_s r1,0x883000
L_8cef56:
	ld_s r0,[r1,0x38]
L_8cef58:
	ld_s r1,[r1,0x38]
L_8cef5a:
	bmsk r3,r0,0x0
L_8cef5e:
	lsr_s r1,r1
L_8cef60:
	bmsk r4,r1,0x0
L_8cef64:
	bxor r0,r0,0x0
L_8cef68:
	bmsk_s r0,r0,0x0
L_8cef6a:
	bxor r1,r1,0x0
L_8cef6e:
	bmsk_s r1,r1,0x0
L_8cef70:
	tst_s r1,r0
L_8cef72:
	sub_s.ne r0,r0,r0
L_8cef74:
	bne_s L_8cefaa
L_8cef76:
	cmp_s r3,0x1
L_8cef78:
	mov_s r13,0x1
L_8cef7a:
	sub_s.ne r13,r13,r13
L_8cef7c:
	cmp r4,0x1
L_8cef80:
	mov_s r2,0x1
L_8cef82:
	sub_s.ne r2,r2,r2
L_8cef84:
	tst_s r2,r13
L_8cef86:
	mov.ne r0,0x1
L_8cef8a:
	bne_s L_8cefaa
L_8cef8c:
	tst_s r2,r0
L_8cef8e:
	mov.ne r0,0x4
L_8cef92:
	bne_s L_8cefaa
L_8cef94:
	tst_s r13,r1
L_8cef96:
	mov_s r0,0x5
L_8cef98:
	bne_s L_8cefaa
L_8cef9a:
	mov_s r2,0x101879c
L_8cefa0:
	mov_s r0,0x1
L_8cefa2:
	bl.d L_8edff8
L_8cefa6:
	mov_s r1,r0
L_8cefa8:
	mov_s r0,0x3
	.global L_8cefaa
L_8cefaa:
	b L_8c033c
L_8cefae:
	nop_s
