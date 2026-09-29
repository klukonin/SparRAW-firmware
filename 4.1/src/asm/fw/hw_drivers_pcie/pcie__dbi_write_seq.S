/* pcie__dbi_write_seq @ 0x8ce98c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__l1_dwell_stats, pcie__pm_host_config
 * Зовёт сам: hwd_pcie_dbi_write
 */
	.section .text.pcie__dbi_write_seq,"ax",@progbits
	.global pcie__dbi_write_seq
pcie__dbi_write_seq:
	.global L_8ce98c
L_8ce98c:
	push_s blink
L_8ce98e:
	ld_s r1,[r0]
L_8ce990:
	mov_s r2,0x0
L_8ce992:
	push_s r2
L_8ce994:
	mov r0,0x158
L_8ce998:
	mov_s r3,0x1
L_8ce99a:
	mov_s r4,r2
L_8ce99c:
	mov_s r5,r2
L_8ce99e:
	mov_s r6,r3
L_8ce9a0:
	bl.d L_8eab94
L_8ce9a4:
	mov_s r7,r3
L_8ce9a6:
	add_s sp,sp,0x4
L_8ce9a8:
	pop_s blink
L_8ce9aa:
	j_s [blink]
