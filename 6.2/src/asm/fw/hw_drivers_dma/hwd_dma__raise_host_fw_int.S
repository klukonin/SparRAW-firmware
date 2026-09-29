/* hwd_dma__raise_host_fw_int @ 0x8d0ad8, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_irq__raise_fw_error, host_irq__raise_fw_int2, host_irq__raise_fw_ready, host_irq__raise_mbox_evt
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_pcie_exit_l1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__raise_host_fw_int
hwd_dma__raise_host_fw_int:
	.global L_8d0ad8
L_8d0ad8:
	push_s blink
L_8d0ada:
	push_s r13
L_8d0adc:
	mov_s r13,r0
L_8d0ade:
	bl.d L_8d12ac
L_8d0ae2:
	mov_s r0,0x1
L_8d0ae4:
	mov_s r1,0x0
L_8d0ae6:
	bset r1,r1,r13
L_8d0aea:
	mov_s r0,0x881b80
L_8d0af0:
	st_s r1,[r0,0x78]
L_8d0af2:
	sync
L_8d0af6:
	mov_s r1,0x0
L_8d0af8:
	bset r1,r1,r13
L_8d0afc:
	mov_s r0,0x881d00
L_8d0b02:
	st_s r1,[r0,0x24]
L_8d0b04:
	sync
L_8d0b08:
	bl.d L_8d12ac
L_8d0b0c:
	mov_s r0,0x0
L_8d0b0e:
	b L_8c025c
L_8d0b12:
	nop_s
