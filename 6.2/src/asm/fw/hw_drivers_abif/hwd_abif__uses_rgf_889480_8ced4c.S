/* hwd_abif__uses_rgf_889480_8ced4c @ 0x8ced4c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_modes__program_rf_clocks
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__uses_rgf_889480_8ced4c
hwd_abif__uses_rgf_889480_8ced4c:
	.global L_8ced4c
L_8ced4c:
	mov_s r1,0x889480
L_8ced52:
	cmp_s r0,0x1
L_8ced54:
	ld_s r0,[r1,0x20]
L_8ced56:
	bne_s L_8ced68
L_8ced58:
	or r0,r0,0xffe00000
L_8ced60:
	st_s r0,[r1,0x20]
L_8ced62:
	ld_s r0,[r1,0x24]
L_8ced64:
	bset_s r0,r0,0x5
L_8ced66:
	b_s L_8ced70
	.global L_8ced68
L_8ced68:
	bmsk_s r0,r0,0x14
L_8ced6a:
	st_s r0,[r1,0x20]
L_8ced6c:
	ld_s r0,[r1,0x24]
L_8ced6e:
	bclr_s r0,r0,0x5
	.global L_8ced70
L_8ced70:
	st_s r0,[r1,0x24]
L_8ced72:
	j_s [blink]
