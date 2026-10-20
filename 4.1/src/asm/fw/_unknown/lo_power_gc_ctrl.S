/* lo_power_gc_ctrl @ 0x8eb9ac, 464 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Boot is done from host
 *   flash_manager_run_inits error 1
 *   flash_manager_read_ids_section error 1
 *   MAC address from FLASH is %x:%x:%x
 *   Loading production line calibration values from FLASH
 *   ppm value from flash: %d
 *   PPM value too large (%d > %d), setting it to zero
 *   lo_power_xif_gc value from flash: %d
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_log__emit3, hwd_abif__rgf_88af80_8cb964, hwd_spi_read, set_g_8001f6_x2, set_g_80023d, set_g_80023e, set_g_80023f
 */
	.section .text.lo_power_gc_ctrl,"ax",@progbits
	.global lo_power_gc_ctrl
lo_power_gc_ctrl:
	.global L_8eb9ac
L_8eb9ac:
	push_s blink
L_8eb9ae:
	bl.d L_8c02c0
L_8eb9b2:
	mov_s r1,0x2
L_8eb9b4:
	sub_s sp,sp,0x5c
L_8eb9b6:
	mov_s r2,0x10017d4
L_8eb9bc:
	mov_s r13,0x0
L_8eb9be:
	bl.d L_8edfb0
L_8eb9c2:
	mov_s r0,r13
L_8eb9c4:
	mov_s r2,sp
L_8eb9c6:
	mov_s r0,r13
L_8eb9c8:
	bl.d L_8f0ee0
L_8eb9cc:
	mov_s r1,0x5c
L_8eb9ce:
	brne_s r0,0,L_8eb9e0
L_8eb9d0:
	mov_s r2,0x10017ec
	.global L_8eb9d6
L_8eb9d6:
	mov_s r0,r13
L_8eb9d8:
	bl.d L_8edfb0
L_8eb9dc:
	mov_s r1,r13
L_8eb9de:
	b_s L_8ebb74
	.global L_8eb9e0
L_8eb9e0:
	mov_s r14,0x840040
L_8eb9e6:
	ld_s r0,[sp,0x2c]
L_8eb9e8:
	mov_s r1,0x4c
L_8eb9ea:
	bl.d L_8f0ee0
L_8eb9ee:
	mov_s r2,r14
L_8eb9f0:
	brne_s r0,0,L_8eb9fa
L_8eb9f2:
	mov_s r2,0x100180c
L_8eb9f8:
	b_s L_8eb9d6
	.global L_8eb9fa
L_8eb9fa:
	ldw r4,[r14, 0x4]
L_8eb9fe:
	mov_s r2,0x1001834
L_8eba04:
	ldw r5,[r14, 0x2]
L_8eba08:
	mov_s r0,r13
L_8eba0a:
	mov_s r1,0x2
L_8eba0c:
	bl.d L_8ee034
L_8eba10:
	ldw_s r3,[r14,0x6]
L_8eba12:
	bl.d L_8e1aa4
L_8eba16:
	add_s r0,r14,0x2
L_8eba18:
	mov_s r0,0x8033dc
L_8eba1e:
	stw_s r13,[r0,0x26]
L_8eba20:
	mov_s r2,0x1001858
L_8eba26:
	mov_s r0,r13
L_8eba28:
	bl.d L_8edfb0
L_8eba2c:
	mov_s r1,0x2
L_8eba2e:
	ldw_s r15,[r14,0x2c]
L_8eba30:
	mov_s r2,0x1001890
L_8eba36:
	mov_s r0,r13
L_8eba38:
	mov_s r1,0x2
L_8eba3a:
	bl.d L_8edfcc
L_8eba3e:
	mov_s r3,r15
L_8eba40:
	cmp_s r15,0x3f
L_8eba42:
	bls_s L_8eba5a
L_8eba44:
	mov_s r2,0x10018ac
L_8eba4a:
	mov_s r0,r13
L_8eba4c:
	mov_s r1,0x1
L_8eba4e:
	mov_s r3,r15
L_8eba50:
	bl.d L_8edff8
L_8eba54:
	mov r4,0x3f
L_8eba58:
	mov_s r15,r13
	.global L_8eba5a
L_8eba5a:
	bl.d L_8cb964
L_8eba5e:
	extw_s r0,r15
L_8eba60:
	ldw_s r13,[r14,0x34]
L_8eba62:
	mov_s r2,0x10018e0
L_8eba68:
	mov_s r0,0x0
L_8eba6a:
	mov_s r1,0x2
L_8eba6c:
	bl.d L_8edfcc
L_8eba70:
	mov_s r3,r13
L_8eba72:
	brlo r13,0x8,L_8eba8c
L_8eba76:
	mov_s r2,0x1001908
L_8eba7c:
	mov_s r0,0x0
L_8eba7e:
	mov_s r1,0x1
L_8eba80:
	mov_s r3,r13
L_8eba82:
	bl.d L_8edff8
L_8eba86:
	mov r4,0x7
L_8eba8a:
	b_s L_8eba92
	.global L_8eba8c
L_8eba8c:
	bl.d L_8e1a60
L_8eba90:
	extb_s r0,r13
	.global L_8eba92
L_8eba92:
	ldw_s r13,[r14,0x36]
L_8eba94:
	mov_s r2,0x100193c
L_8eba9a:
	mov_s r0,0x0
L_8eba9c:
	mov_s r1,0x2
L_8eba9e:
	bl.d L_8edfcc
L_8ebaa2:
	mov_s r3,r13
L_8ebaa4:
	brlo r13,0x10,L_8ebabe
L_8ebaa8:
	mov_s r2,0x1001964
L_8ebaae:
	mov_s r0,0x0
L_8ebab0:
	mov_s r1,0x1
L_8ebab2:
	mov_s r3,r13
L_8ebab4:
	bl.d L_8edff8
L_8ebab8:
	mov r4,0xf
L_8ebabc:
	b_s L_8ebac6
	.global L_8ebabe
L_8ebabe:
	bl.d L_8e1a58
L_8ebac2:
	ldb r0,[r14, 0x36]
	.global L_8ebac6
L_8ebac6:
	mov_s r2,0x100199c
L_8ebacc:
	mov_s r13,0x840080
L_8ebad2:
	mov_s r0,0x0
L_8ebad4:
	mov_s r1,0x2
L_8ebad6:
	bl.d L_8edfcc
L_8ebada:
	ldw_s r3,[r13,0x2]
L_8ebadc:
	ldw_s r3,[r13,0x2]
L_8ebade:
	brlt r3,0x10,L_8ebaf8
L_8ebae2:
	mov_s r2,0x10019c4
L_8ebae8:
	mov_s r0,0x0
L_8ebaea:
	mov_s r1,r0
L_8ebaec:
	bl.d L_8edff8
L_8ebaf0:
	mov r4,0xf
L_8ebaf4:
	mov_s r3,0xc
L_8ebaf6:
	stw_s r3,[r13,0x2]
	.global L_8ebaf8
L_8ebaf8:
	bl.d L_8e1a50
L_8ebafc:
	extb_s r0,r3
L_8ebafe:
	ldw_s r15,[r14,0x38]
L_8ebb00:
	mov_s r2,0x10019f0
L_8ebb06:
	mov_s r0,0x0
L_8ebb08:
	mov_s r1,0x2
L_8ebb0a:
	bl.d L_8edfcc
L_8ebb0e:
	mov_s r3,r15
L_8ebb10:
	brlo r15,0x10,L_8ebb2a
L_8ebb14:
	mov_s r2,0x1001a10
L_8ebb1a:
	mov_s r0,0x0
L_8ebb1c:
	mov_s r1,0x1
L_8ebb1e:
	mov_s r3,r15
L_8ebb20:
	bl.d L_8edff8
L_8ebb24:
	mov r4,0xf
L_8ebb28:
	b_s L_8ebb36
	.global L_8ebb2a
L_8ebb2a:
	extb_s r3,r15
L_8ebb2c:
	mov_s r0,0x0
L_8ebb2e:
	mov_s r1,0x3f
L_8ebb30:
	bl.d L_8cc398
L_8ebb34:
	mov_s r2,0x1
	.global L_8ebb36
L_8ebb36:
	ldw_s r14,[r14,0x3a]
L_8ebb38:
	mov_s r2,0x1001a40
L_8ebb3e:
	mov_s r0,0x0
L_8ebb40:
	mov_s r1,0x2
L_8ebb42:
	bl.d L_8edfcc
L_8ebb46:
	mov_s r3,r14
L_8ebb48:
	brlo r14,0x10,L_8ebb62
L_8ebb4c:
	mov_s r2,0x1001a68
L_8ebb52:
	mov_s r0,0x0
L_8ebb54:
	mov_s r1,0x1
L_8ebb56:
	mov_s r3,r14
L_8ebb58:
	bl.d L_8edff8
L_8ebb5c:
	mov r4,0xf
L_8ebb60:
	b_s L_8ebb6c
	.global L_8ebb62
L_8ebb62:
	extb_s r2,r14
L_8ebb64:
	mov_s r0,0x0
L_8ebb66:
	bl.d L_8cc61c
L_8ebb6a:
	mov_s r1,0x3f
	.global L_8ebb6c
L_8ebb6c:
	ldw_s r0,[r13,0x6]
L_8ebb6e:
	bl.d L_8e159c
L_8ebb72:
	ldw_s r1,[r13,0x8]
	.global L_8ebb74
L_8ebb74:
	b.d L_8c032c
L_8ebb78:
	add_s sp,sp,0x5c
L_8ebb7a:
	nop_s
