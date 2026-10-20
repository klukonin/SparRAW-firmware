/* vring_macq_delete__program_ba_win @ 0x8e5288, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_macq_delete_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_indirect__write_entry
 */
	.section .text.vring_macq_delete__program_ba_win,"ax",@progbits
	.global vring_macq_delete__program_ba_win
vring_macq_delete__program_ba_win:
	.global L_8e5288
L_8e5288:
	push_s blink
L_8e528a:
	bl.d L_8c02c4
L_8e528e:
	mov_s r2,0x2
L_8e5290:
	mov_s r13,r1
L_8e5292:
	add3 r14,r0,0x8
L_8e5296:
	mov_s r3,0x0
L_8e5298:
	mov_s r4,r3
L_8e529a:
	mov_s r5,r3
L_8e529c:
	mov_s r6,r3
L_8e529e:
	bl.d L_8c46a4
L_8e52a2:
	mov r7,0x4
L_8e52a6:
	mov_s r0,r14
L_8e52a8:
	mov_s r1,r13
L_8e52aa:
	mov_s r2,0x2
L_8e52ac:
	mov_s r3,0x3
L_8e52ae:
	mov r4,0x0
L_8e52b2:
	mov r5,0x0
L_8e52b6:
	mov r6,0x0
L_8e52ba:
	bl.d L_8c46a4
L_8e52be:
	mov_s r7,r3
L_8e52c0:
	b L_8c0334
