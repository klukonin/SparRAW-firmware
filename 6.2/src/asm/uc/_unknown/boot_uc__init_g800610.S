/* boot_uc__init_g800610 @ 0x920a10, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_vector_01
 * Зовёт сам: bi_mode_init_sequence, boot_uc__init_tail, boot_uc__set_88000c, cpu__aux28_set_bits12, mac__program_13ab6680, tof__set_tx_rx_offset_regs, uc_log__init_ring, uc_send_evt__ucode_ready, vring_is_empty_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global boot_uc__init_g800610
boot_uc__init_g800610:
	.global L_920a10
L_920a10:
	push_s blink
L_920a12:
	bl L_92d0a0
L_920a16:
	mov_s r0,0x6
L_920a18:
	mov_s r1,0x800610
L_920a1e:
	stw_s r0,[r1]
L_920a20:
	mov_s r0,0x2
L_920a22:
	stw_s r0,[r1,0x2]
L_920a24:
	mov_s r0,0x0
L_920a26:
	stw_s r0,[r1,0x4]
L_920a28:
	mov r0,0x3e8
L_920a2c:
	st_s r0,[r1,0x8]
L_920a2e:
	mov_s r0,0x1b
L_920a30:
	stb_s r0,[r1,0xc]
L_920a32:
	mov_s r0,0x24
L_920a34:
	stb_s r0,[r1,0xd]
L_920a36:
	mov_s r0,0xf
L_920a38:
	stb_s r0,[r1,0xe]
L_920a3a:
	mov_s r0,0x1e
L_920a3c:
	stb_s r0,[r1,0xf]
L_920a3e:
	mov_s r0,0x1
L_920a40:
	stb_s r0,[r1,0x10]
L_920a42:
	mov_s r0,0x13
L_920a44:
	stb_s r0,[r1,0x11]
L_920a46:
	mov_s r0,0x800000
L_920a4c:
	bl L_92a6e4
L_920a50:
	bl.d L_92a6f0
L_920a54:
	add_s r0,gp,0x30
L_920a56:
	bl L_9365fc
L_920a5a:
	mov_s r0,0x800694
L_920a60:
	ld_s r0,[r0]
L_920a62:
	mov_s r1,0x800698
L_920a68:
	bl.d L_929d10
L_920a6c:
	ld_s r1,[r1]
L_920a6e:
	bl L_93c8e0
L_920a72:
	bl L_927508
L_920a76:
	bl L_9202f4
L_920a7a:
	bl L_9215b8
L_920a7e:
	pop_s blink
L_920a80:
	j_s [blink]
L_920a82:
	nop_s
