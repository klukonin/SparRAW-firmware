/* pcie__l1ss_enable @ 0x8ceab8, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sparrow PCIe L1SS Support enabled
 * Зовут его: pcie__serdes_program_all
 * Зовёт сам: fw_log__emit0, get_reg8825bc_bit3_inv
 */
	.section .text.pcie__l1ss_enable,"ax",@progbits
	.global pcie__l1ss_enable
pcie__l1ss_enable:
	.global L_8ceab8
L_8ceab8:
	push_s blink
L_8ceaba:
	mov_s r2,0x1018a20
L_8ceac0:
	mov_s r0,0x1
L_8ceac2:
	bl.d L_8edfb0
L_8ceac6:
	mov_s r1,0x2
L_8ceac8:
	bl L_8ce774
L_8ceacc:
	mov_s r2,0x88b080
L_8cead2:
	cmp_s r0,0x0
L_8cead4:
	ld_s r0,[r2,0x38]
L_8cead6:
	mov_s r1,0x88b000
L_8ceadc:
	bset.eq r0,r0,0xd
L_8ceae0:
	bset.eq r0,r0,0x14
L_8ceae4:
	bset.ne r0,r0,0x10
L_8ceae8:
	bset.ne r0,r0,0x17
L_8ceaec:
	st_s r0,[r2,0x38]
L_8ceaee:
	ld_s r0,[r1,0x60]
L_8ceaf0:
	bclr_s r0,r0,0x0
L_8ceaf2:
	st_s r0,[r1,0x60]
L_8ceaf4:
	ld_s r0,[r1,0x2c]
L_8ceaf6:
	bclr_s r0,r0,0x0
L_8ceaf8:
	st_s r0,[r1,0x2c]
L_8ceafa:
	ld_s r0,[r2,0x30]
L_8ceafc:
	mov_s r1,0x882200
L_8ceb02:
	bclr_s r0,r0,0x0
L_8ceb04:
	st_s r0,[r2,0x30]
L_8ceb06:
	ld_s r0,[r1,0x40]
L_8ceb08:
	bset_s r0,r0,0x11
L_8ceb0a:
	st_s r0,[r1,0x40]
L_8ceb0c:
	pop_s blink
L_8ceb0e:
	j_s [blink]
