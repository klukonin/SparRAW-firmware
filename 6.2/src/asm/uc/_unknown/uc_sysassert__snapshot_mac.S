/* uc_sysassert__snapshot_mac @ 0x93756c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_log__emit1, uc_log__emit2, uc_log__emit3, uc_log__emit_snapshot, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_sysassert__snapshot_mac
uc_sysassert__snapshot_mac:
	.global L_93756c
L_93756c:
	mov r5,0x887000
L_937574:
	breq r2,0x0,L_937580
	.global L_937578
L_937578:
	ld.as r4,[r5,-0x53]
L_93757c:
	bbit0 r4,0x1f,L_937578
	.global L_937580
L_937580:
	ld.as r6,[r5,-0x51]
L_937584:
	st r6,[r1, 0x4]
L_937588:
	ld.as r2,[r5,-0x52]
L_93758c:
	st_s r2,[r1]
L_93758e:
	ld.as r3,[r5,-0x51]
L_937592:
	cmp r6,r3
L_937596:
	jeq_s [blink]
L_937598:
	b_s L_937580
L_93759a:
	nop_s
