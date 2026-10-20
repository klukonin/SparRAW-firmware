/* sched__program_alloc_slot_regs @ 0x8d0ea8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__evt_walk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sched__program_alloc_slot_regs
sched__program_alloc_slot_regs:
	.global L_8d0ea8
L_8d0ea8:
	mov_s r3,0x886f80
L_8d0eae:
	st_s r1,[r3,0x4]
L_8d0eb0:
	mov_s r1,0x88c000
L_8d0eb6:
	st_s r0,[r1,0x50]
L_8d0eb8:
	st_s r2,[r3,0x8]
L_8d0eba:
	j_s [blink]
