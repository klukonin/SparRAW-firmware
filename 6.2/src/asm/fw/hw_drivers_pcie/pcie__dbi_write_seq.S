/* pcie__dbi_write_seq @ 0x8d167c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__l1ss_config, pcie_pm_host_config
 * Зовёт сам: dbi_write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__dbi_write_seq
pcie__dbi_write_seq:
	.global L_8d167c
L_8d167c:
	push_s blink
L_8d167e:
	ld_s r1,[r0]
L_8d1680:
	mov_s r2,0x0
L_8d1682:
	push_s r2
L_8d1684:
	mov r0,0x158
L_8d1688:
	mov_s r3,0x1
L_8d168a:
	mov_s r4,r2
L_8d168c:
	mov_s r5,r2
L_8d168e:
	mov_s r6,r3
L_8d1690:
	bl.d L_8c8338
L_8d1694:
	mov_s r7,r3
L_8d1696:
	add_s sp,sp,0x4
L_8d1698:
	pop_s blink
L_8d169a:
	j_s [blink]
