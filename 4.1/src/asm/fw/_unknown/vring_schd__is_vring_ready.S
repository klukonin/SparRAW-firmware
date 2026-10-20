/* vring_schd__is_vring_ready @ 0x8c588c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_schd__disconnect_notify, vring_schd__find_runnable, vring_schd__move_to_ready
 */
	.section .text.vring_schd__is_vring_ready,"ax",@progbits
	.global vring_schd__is_vring_ready
vring_schd__is_vring_ready:
	.global L_8c588c
L_8c588c:
	mov_s r2,0x0
L_8c588e:
	bset r2,r2,r1
L_8c5892:
	ld r0,[r0, 0x98]
L_8c5896:
	j_s.d [blink]
L_8c5898:
	and_s r0,r0,r2
L_8c589a:
	nop_s
