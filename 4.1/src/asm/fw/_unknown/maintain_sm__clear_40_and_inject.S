/* maintain_sm__clear_40_and_inject @ 0x8d6aec, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: MAINTAIN_SM__OPEN
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.maintain_sm__clear_40_and_inject,"ax",@progbits
	.global maintain_sm__clear_40_and_inject
maintain_sm__clear_40_and_inject:
	.global L_8d6aec
L_8d6aec:
	mov_s r2,0x0
L_8d6aee:
	st_s r2,[r0,0x40]
L_8d6af0:
	mov_s r1,0x4
L_8d6af2:
	mov_s r3,r2
L_8d6af4:
	b.d L_8d6a1c
L_8d6af8:
	mov_s r4,r2
L_8d6afa:
	nop_s
