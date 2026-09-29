/* tx_budget__arm_refill @ 0x8ea4f0, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_budget__take
 * Зовёт сам: u_schd__add
 */
	.section .text.tx_budget__arm_refill,"ax",@progbits
	.global tx_budget__arm_refill
tx_budget__arm_refill:
	.global L_8ea4f0
L_8ea4f0:
	mov_s r2,r0
L_8ea4f2:
	ld_s r0,[r0,0x8]
L_8ea4f4:
	add_s r1,r1,r0
L_8ea4f6:
	ld_s r0,[r2,0x4]
L_8ea4f8:
	brhs.d r0,r1,L_8ea500
L_8ea4fc:
	st_s r1,[r2,0x8]
L_8ea4fe:
	st_s r0,[r2,0x8]
	.global L_8ea500
L_8ea500:
	mov_s r0,0x24ba0
L_8ea506:
	ld_s r1,[r2,0x10]
L_8ea508:
	mov_s r2,0x0
L_8ea50a:
	b.d L_8c2ac8
L_8ea50e:
	mov_s r3,0x1
