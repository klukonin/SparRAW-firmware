/* gpio__pulse_880b60_19 @ 0x8cd744, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_880b50__dispatch_causes
 * Зовёт сам: u_schd__add
 * Глобалы (через gp): 0x80032c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global gpio__pulse_880b60_19
gpio__pulse_880b60_19:
	.global L_8cd744
L_8cd744:
	ld_s r0,[gp,0x1a8]
L_8cd746:
	mov_s r1,0x0
L_8cd748:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cd74a:
	st.as r0,[gp,0x6a]
L_8cd74e:
	mov_s r0,0x880b00
L_8cd754:
	st 0x80000,[r0, 0x60]
L_8cd75c:
	mov_s r0,0x237c8
L_8cd762:
	mov_s r2,r1
L_8cd764:
	b.d L_8c3248
L_8cd768:
	mov_s r3,0x1
L_8cd76a:
	nop_s
