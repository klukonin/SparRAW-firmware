/* hwd_dma__bad_cause @ 0x8cd978, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DMA BAD Interrupt: cause = %x
 *   hw_drivers_dma.c
 * Зовут его: isr_vring_dma
 * Зовёт сам: fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.hwd_dma__bad_cause,"ax",@progbits
	.global hwd_dma__bad_cause
hwd_dma__bad_cause:
	.global L_8cd978
L_8cd978:
	push_s blink
L_8cd97a:
	mov_s r0,0x881c00
L_8cd980:
	ld_s r3,[r0,0x48]
L_8cd982:
	btst_s r3,0x1f
L_8cd984:
	btst.eq r3,0x1c
L_8cd988:
	btst.eq r3,0x1b
L_8cd98c:
	beq_s L_8cd9b0
L_8cd98e:
	mov_s r2,0x10184e4
L_8cd994:
	mov_s r0,0x0
L_8cd996:
	bl.d L_8edfcc
L_8cd99a:
	mov_s r1,r0
L_8cd99c:
	mov_s r0,blink
L_8cd99e:
	mov_s r2,0x1018504
L_8cd9a4:
	mov_s r1,0xbad1
L_8cd9aa:
	bl.d L_8c82c0
L_8cd9ae:
	mov_s r3,0xbe
	.global L_8cd9b0
L_8cd9b0:
	pop_s blink
L_8cd9b2:
	j_s [blink]
