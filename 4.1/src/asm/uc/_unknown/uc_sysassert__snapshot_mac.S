/* uc_sysassert__snapshot_mac @ 0x9325e4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_sysassert
 */
	.section .text.uc_sysassert__snapshot_mac,"ax",@progbits
	.global uc_sysassert__snapshot_mac
uc_sysassert__snapshot_mac:
	.global L_9325e4
L_9325e4:
	mov r5,0x887000
L_9325ec:
	breq r2,0x0,L_9325f8
	.global L_9325f0
L_9325f0:
	ld.as r4,[r5,-0x53]
L_9325f4:
	bbit0 r4,0x1f,L_9325f0
	.global L_9325f8
L_9325f8:
	ld.as r6,[r5,-0x51]
L_9325fc:
	st r6,[r1, 0x4]
L_932600:
	ld.as r2,[r5,-0x52]
L_932604:
	st_s r2,[r1]
L_932606:
	ld.as r3,[r5,-0x51]
L_93260a:
	cmp r6,r3
L_93260e:
	jeq_s [blink]
L_932610:
	b_s L_9325f8
L_932612:
	nop_s
