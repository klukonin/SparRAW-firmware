/* hwd_dma__kick_channel @ 0x8cdd84, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tail_hwd_dma__kick_channel, tail_hwd_dma__kick_channel_8cdf94, tail_hwd_dma__kick_channel_8cdf9c, tail_hwd_dma__kick_channel_8cdfa4
 * Зовёт сам: __ld_r13_ret, hwd_pcie_exit_l1
 */
	.section .text.hwd_dma__kick_channel,"ax",@progbits
	.global hwd_dma__kick_channel
hwd_dma__kick_channel:
	.global L_8cdd84
L_8cdd84:
	push_s blink
L_8cdd86:
	push_s r13
L_8cdd88:
	mov_s r13,r0
L_8cdd8a:
	bl.d L_8ce578
L_8cdd8e:
	mov_s r0,0x1
L_8cdd90:
	mov_s r1,0x0
L_8cdd92:
	bset r1,r1,r13
L_8cdd96:
	mov_s r0,0x881b80
L_8cdd9c:
	st_s r1,[r0,0x78]
L_8cdd9e:
	sync
L_8cdda2:
	mov_s r1,0x0
L_8cdda4:
	bset r1,r1,r13
L_8cdda8:
	mov_s r0,0x881d00
L_8cddae:
	st_s r1,[r0,0x24]
L_8cddb0:
	sync
L_8cddb4:
	bl.d L_8ce578
L_8cddb8:
	mov_s r0,0x0
L_8cddba:
	b L_8c033c
L_8cddbe:
	nop_s
