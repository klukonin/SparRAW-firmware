/* pcie__dbi_start_cmd @ 0x8d122c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__dbi_read, pcie__dbi_transfer
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__dbi_start_cmd
pcie__dbi_start_cmd:
	.global L_8d122c
L_8d122c:
	asl_s r0,r0,0x1f
L_8d122e:
	asl_s r1,r1,0x10
L_8d1230:
	or_s r0,r0,r1
L_8d1232:
	or_s r2,r2,r0
L_8d1234:
	mov_s r0,0x882600
L_8d123a:
	st_s r2,[r0,0x48]
L_8d123c:
	j_s [blink]
L_8d123e:
	nop_s
