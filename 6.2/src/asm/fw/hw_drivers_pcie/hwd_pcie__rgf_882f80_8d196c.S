/* hwd_pcie__rgf_882f80_8d196c @ 0x8d196c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_program_all
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__rgf_882f80_8d196c
hwd_pcie__rgf_882f80_8d196c:
	.global L_8d196c
L_8d196c:
	mov_s r1,0x882f80
L_8d1972:
	ld_s r0,[r1,0x8]
L_8d1974:
	bclr_s r0,r0,0x1d
L_8d1976:
	st_s r0,[r1,0x8]
L_8d1978:
	ld_s r0,[r1,0x8]
L_8d197a:
	bclr_s r0,r0,0x1e
L_8d197c:
	st_s r0,[r1,0x8]
L_8d197e:
	j_s [blink]
