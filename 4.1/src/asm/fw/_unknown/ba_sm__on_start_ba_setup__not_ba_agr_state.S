/* ba_sm__on_start_ba_setup__not_ba_agr_state @ 0x8dcab0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event
 */
	.section .text.ba_sm__on_start_ba_setup__not_ba_agr_state,"ax",@progbits
	.global ba_sm__on_start_ba_setup__not_ba_agr_state
ba_sm__on_start_ba_setup__not_ba_agr_state:
L_8dcab0:
	push_s blink
L_8dcab2:
	bl.d L_8c02c4
L_8dcab6:
	mov_s r5,r1
L_8dcab8:
	mov_s r13,r0
L_8dcaba:
	mov_s r14,r2
L_8dcabc:
	mov_s r4,r3
L_8dcabe:
	add_s r0,r0,0x2c
L_8dcac0:
	mov_s r1,0x0
L_8dcac2:
	mov_s r2,r5
L_8dcac4:
	bl.d L_8d6a1c
L_8dcac8:
	mov_s r3,r14
L_8dcaca:
	ld r0,[r13, 0xac]
L_8dcace:
	ld r1,[r0, 0xd4]
L_8dcad2:
	ld_s r1,[r1,0xc]
L_8dcad4:
	jl_s [r1]
L_8dcad6:
	.byte 0x61,0x00
